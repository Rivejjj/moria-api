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
  set :sistema, Sistema.new(RepositorioUsuarios.new, RepositorioContenido.new)
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

post '/usuarios/:id_plataforma/playlist' do |id_plataforma|
  nombre_cancion = sistema.agregar_a_playlist(@params[:id_cancion], id_plataforma)
  respuesta = { nombre_cancion: }
  status 201
  json(respuesta)
rescue CancionNoEncontradaError
  status 404
end
