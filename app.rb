require 'sinatra'
require 'sinatra/json'
require 'sequel'
require 'sinatra/custom_logger'
require_relative './config/configuration'
require_relative './lib/version'
Dir[File.join(__dir__, 'dominio', '*.rb')].each { |file| require file }
Dir[File.join(__dir__, 'persistencia', '*.rb')].each { |file| require file }

configure do
  customer_logger = Configuration.logger
  DB = Configuration.db # rubocop:disable  Lint/ConstantDefinitionInBlock
  DB.loggers << customer_logger
  set :logger, customer_logger
  set :default_content_type, :json
  set :environment, ENV['APP_MODE'].to_sym
  set :sistema, Sistema.new(RepositorioUsuarios.new, RepositorioContenido.new, RepositorioEpisodiosPodcast.new)
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
  json({ version: Version.current })
end

post '/reset' do
  sistema.reset
  status 200
end

get '/usuarios' do
  usuarios = sistema.usuarios
  respuesta = []
  usuarios.map { |u| respuesta << { email: u.email, id: u.id } }
  status 200
  json(respuesta)
end

post '/usuarios' do
  sistema.crear_usuario(@params[:nombre_de_usuario], @params[:email], @params[:id_plataforma])
  status 201
rescue NombreDeUsuarioEnUsoError
  status 409
end

post '/canciones' do
  id_cancion = sistema.crear_cancion(@params[:nombre], @params[:autor], @params[:anio], @params[:duracion], @params[:genero])
  respuesta = { id_cancion: }
  status 201
  json(respuesta)
end

post '/canciones/:id_cancion/reproduccion' do |id_cancion|
  sistema.reproducir_cancion(id_cancion, @params[:nombre_usuario])
  status 201
end

post '/usuarios/:id_plataforma/playlist' do |id_plataforma|
  nombre_cancion = sistema.agregar_a_playlist(@params[:id_cancion], id_plataforma)
  respuesta = { nombre_cancion: }
  status 201
  json(respuesta)
rescue ContenidoNoEncontradoError
  status 404
rescue UsuarioNoEncontradoError
  status 401
end

get '/usuarios/:id_plataforma/recomendacion' do |id_plataforma|
  recomendacion = sistema.recomendar_contenido(id_plataforma)
  respuesta_recomendacion = []
  recomendacion.map { |c| respuesta_recomendacion << { 'id_cancion': c[0], 'nombre_cancion': c[1] } }
  respuesta = { 'recomendacion': respuesta_recomendacion }
  status 200
  json(respuesta)
rescue UsuarioNoEncontradoError
  status 401
end

post '/contenidos/:id_contenido/megusta' do |id_contenido|
  sistema.dar_me_gusta_a_cancion(id_contenido, @params[:id_plataforma])
  status 201
rescue ContenidoNoEncontradoError
  status 404
rescue UsuarioNoEncontradoError
  status 401
rescue CancionNoReproducidaError
  respuesta = { tipo_contenido: 'cancion' }
  status 403
  json(respuesta)
end

post '/podcasts' do
  id_podcast = sistema.crear_podcast(@params[:nombre], @params[:autor], @params[:anio], @params[:duracion], @params[:genero])
  respuesta = { id_podcast: }
  status 201
  json(respuesta)
end

post '/podcasts/:id_podcast/episodios' do |id_podcast|
  id_episodio = sistema.crear_episodio_podcast(id_podcast, params[:numero], params[:nombre], params[:duracion])
  status 201
  json({ id_episodio: })
rescue ContenidoNoEncontradoError
  status 404
end

post '/episodios/:id_episodio/reproduccion' do |id_episodio|
  id_episodio = sistema.reproducir_episodio_podcast(id_episodio, params[:nombre_usuario])
  status 201
  json({ id_episodio: })
end
