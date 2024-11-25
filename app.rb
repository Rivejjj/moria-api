require 'sinatra'
require 'sinatra/json'
require 'sequel'
require 'sinatra/custom_logger'
require_relative './config/configuration'
require_relative './config/middleware'
require_relative './lib/version'
require_relative './app/configuracion_repositorios'
require_relative './proveedor_de_fecha/proveedor_de_fecha_date'
require_relative './adaptadores_plataforma_musica/adaptador_spotify'
Dir[File.join(__dir__, 'dominio', '*.rb')].each { |file| require file }
Dir[File.join(__dir__, 'dominio/reproducciones', '*.rb')].each { |file| require file }
Dir[File.join(__dir__, 'persistencia', '*.rb')].each { |file| require file }
Dir[File.join(__dir__, 'presentacion', '*.rb')].each { |file| require file }

configure do
  customer_logger = Configuration.logger
  DB = Configuration.db # rubocop:disable  Lint/ConstantDefinitionInBlock
  DB.loggers << customer_logger
  set :logger, customer_logger
  set :default_content_type, :json
  set :environment, ENV['APP_MODE'].to_sym
  set :sistema, Sistema.new(ConfiguracionRepositorios.new, ProveedorDeFechaDate.new, AdaptadorSpotify.new)
  use LogMiddleware
end

before do
  if !request.body.nil? && request.body.size.positive?
    request.body.rewind
    @params = JSON.parse(request.body.read, symbolize_names: true)
  end
end

def sistema
  settings.sistema
end

get '/version' do
  logger.debug 'Recibido GET /version'
  respuesta = { version: Version.current }
  logger.debug "Respondiendo con #{respuesta.to_json}"
  json(respuesta)
end

post '/reset' do
  logger.debug 'Recibido POST /reset'
  sistema.reset
  logger.debug 'Respondiendo con status 200'
  status 200
end

get '/usuarios' do
  logger.debug 'Recibido GET /usuarios'
  usuarios = sistema.usuarios
  respuesta = []
  usuarios.map { |u| respuesta << { email: u.email, id: u.id } }
  logger.debug "Respondiendo con #{respuesta.to_json} - status 200"
  status 200
  json(respuesta)
end

post '/usuarios' do
  logger.debug "Recibido POST /usuarios - #{@params.to_json}"
  sistema.crear_usuario(@params[:nombre_de_usuario], @params[:email], @params[:id_plataforma])
  logger.debug 'Respondiendo con status 201'
  status 201
rescue NombreDeUsuarioEnUsoError
  logger.debug 'Respondiendo con status 409'
  status 409
end

post '/canciones' do
  logger.debug "Recibido POST /canciones - #{@params.to_json}"
  id_cancion = sistema.crear_cancion(@params[:nombre], @params[:autor], @params[:anio], @params[:duracion], @params[:genero])
  respuesta = { id_cancion: }
  logger.debug "Respondiendo con #{respuesta.to_json} - status 201"
  status 201
  json(respuesta)
rescue AutorNoEncontradoError
  logger.debug 'Respondiendo con status 404'
  status 404
end

post '/canciones/:id_cancion/reproduccion' do |id_cancion|
  logger.debug "Recibido POST /canciones/#{id_cancion}/reproduccion - #{@params.to_json}"
  sistema.reproducir_cancion(id_cancion, @params[:nombre_usuario])
  logger.debug 'Respondiendo con status 201'
  status 201
end

post '/usuarios/:id_plataforma/playlist' do |id_plataforma|
  logger.debug "Recibido POST /usuarios/#{id_plataforma}/playlist - #{@params.to_json}"
  nombre_cancion = sistema.agregar_a_playlist(@params[:id_cancion], id_plataforma)
  respuesta = { nombre_cancion: }
  logger.debug "Respondiendo con #{respuesta.to_json} - status 201"
  status 201
  json(respuesta)
rescue ContenidoNoEncontradoError
  logger.debug 'Respondiendo con status 404'
  status 404
rescue UsuarioNoEncontradoError
  logger.debug 'Respondiendo con status 401'
  status 401
end

get '/usuarios/:id_plataforma/recomendacion' do |id_plataforma|
  logger.debug "Recibido GET /usuarios/#{id_plataforma}/recomendacion"
  recomendacion = sistema.recomendar_contenido(id_plataforma)
  respuesta_recomendacion = []
  recomendacion.map { |c| respuesta_recomendacion << { 'id_contenido': c[0], 'nombre': c[1] } }
  respuesta = { 'recomendacion': respuesta_recomendacion }
  logger.debug "Respondiendo con #{respuesta.to_json} - status 200"
  status 200
  json(respuesta)
rescue UsuarioNoEncontradoError
  logger.debug 'Respondiendo con status 401'
  status 401
end

post '/contenidos/:id_contenido/megusta' do |id_contenido|
  logger.debug "Recibido POST /contenidos/#{id_contenido}/megusta - #{@params.to_json}"
  sistema.dar_me_gusta_a_contenido(id_contenido, @params[:id_plataforma])
  logger.debug 'Respondiendo con status 201'
  status 201
rescue ContenidoNoEncontradoError
  logger.debug 'Respondiendo con status 404'
  status 404
rescue UsuarioNoEncontradoError
  logger.debug 'Respondiendo con status 401'
  status 401
rescue CancionNoReproducidaError
  respuesta = { tipo_contenido: 'cancion' }
  logger.debug "Respondiendo con #{respuesta.to_json} - status 403"
  status 403
  json(respuesta)
rescue PodcastNoReproducidoError
  respuesta = { tipo_contenido: 'podcast' }
  logger.debug "Respondiendo con #{respuesta.to_json} - status 403"
  status 403
  json(respuesta)
end

post '/podcasts' do
  logger.debug "Recibido POST /podcasts - #{@params.to_json}"
  id_podcast = sistema.crear_podcast(@params[:nombre], @params[:autor], @params[:anio], @params[:duracion], @params[:genero])
  respuesta = { id_podcast: }
  logger.debug "Respondiendo con #{respuesta.to_json} - status 201"
  status 201
  json(respuesta)
rescue AutorNoEncontradoError
  logger.debug 'Respondiendo con status 404'
  status 404
end

post '/podcasts/:id_podcast/episodios' do |id_podcast|
  logger.debug "Recibido POST /podcasts/#{id_podcast}/episodios - #{@params.to_json}"
  id_episodio = sistema.crear_episodio_podcast(id_podcast, @params[:numero], @params[:nombre], @params[:duracion])
  respuesta = { id_episodio: }
  logger.debug "Respondiendo con #{respuesta.to_json} - status 201"
  status 201
  json(respuesta)
rescue ContenidoNoEncontradoError
  logger.debug 'Respondiendo con status 404'
  status 404
end

post '/episodios/:id_episodio/reproduccion' do |id_episodio|
  logger.debug "Recibido POST /episodios/#{id_episodio}/reproduccion - #{@params.to_json}"
  id_episodio = sistema.reproducir_episodio_podcast(id_episodio, @params[:nombre_usuario])
  respuesta = { id_episodio: }
  logger.debug "Respondiendo con #{respuesta.to_json} - status 201"
  status 201
  json(respuesta)
end

get '/contenidos/:id_contenido/detalles' do |id_contenido|
  logger.debug "Recibido GET /contenidos/#{id_contenido}/detalles"
  detalles_contenido = sistema.obtener_detalles_contenido(id_contenido)
  respuesta = detalles_contenido.obtener_json
  logger.debug "Respondiendo con #{respuesta} - status 200"
  status 200
  respuesta
rescue ContenidoNoEncontradoError
  logger.debug 'Respondiendo con status 404'
  status 404
end

get '/contenidos/top_semanal' do
  logger.debug 'Recibido GET /contenidos/top_semanal'
  top_semanal = TopSemanalPresentacion.new(sistema.obtener_top_semanal)
  respuesta = top_semanal.obtener_json
  logger.debug "Respondiendo con #{respuesta} - status 200"
  status 200
  respuesta
end

post '/autores' do
  logger.debug "Recibido POST /autores - #{@params.to_json}"
  id_autor = sistema.crear_autor(@params[:nombre], @params[:id_externo])
  respuesta = { id_autor: }
  logger.debug "Respondiendo con #{respuesta.to_json} - status 201"
  status 201
  json(respuesta)
end

get '/autores/relacionados' do
  logger.debug "Recibido GET /autores/relacionados - #{@params.to_json}"
  nombre_autor = @params[:nombre_autor]
  autores_relacionados = sistema.obtener_autores_relacionados_a(nombre_autor)
  presentacion_autores_relacionados = PresentacionAutoresRelacionados.new(autores_relacionados)
  respuesta = presentacion_autores_relacionados.obtener_json
  logger.debug "Respondiendo con #{respuesta} - status 200"
  status 200
  respuesta
rescue AutorNoEncontradoError
  logger.debug 'Respondiendo con status 404'
  status 404
end

get '/autores/contenidos' do
  logger.debug "Recibido GET /autores/contenidos - #{@params.to_json}"
  nombre_autor = @params[:nombre_autor]
  contenidos_de_autor = sistema.obtener_contenidos_de_autor(nombre_autor)
  presentacion_contenidos_de_autor = PresentacionContenidosDeAutor.new(contenidos_de_autor)
  respuesta = presentacion_contenidos_de_autor.obtener_json
  logger.debug "Respondiendo con #{respuesta} - status 200"
  status 200
  respuesta
rescue AutorNoEncontradoError
  logger.debug 'Respondiendo con status 404'
  status 404
end
