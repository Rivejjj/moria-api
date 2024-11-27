require 'dotenv/load'
require 'faraday'
require 'base64'
require 'json'

class AdaptadorSpotify
  SPOTIFY_TOKEN_API_URL = 'https://accounts.spotify.com/api/token'.freeze
  CONTENT_TYPE = 'application/x-www-form-urlencoded'.freeze
  GRANT_TYPE = 'client_credentials'.freeze
  SPOTIFY_AUTORES_API_URL = 'https://api.spotify.com/v1/artists'.freeze

  def initialize(client_id = ENV['CLIENT_ID'], client_secret = ENV['CLIENT_SECRET'], logger = SemanticLogger['AdaptadorSpotify'])
    @client_id = client_id
    @client_secret = client_secret
    @logger = logger
  end

  def obtener_token
    response = pedir_token

    if response.status == 200
      body = JSON.parse(response.body)
      token = body['access_token']
      @logger.debug "Token obtenido: #{token}"
      token
    else
      @logger.error "Error al obtener token: #{response.body}"
    end
  end

  def obtener_autores_relacionados_a(autor)
    response = Faraday.new(url: "#{SPOTIFY_AUTORES_API_URL}/#{autor.id_externo}/related-artists").get do |req|
      req.headers['Authorization'] = "Bearer #{obtener_token}"
      @logger.debug "Pidiendo autores relacionados a #{SPOTIFY_AUTORES_API_URL}/#{autor.id_externo}/related-artists - headers: #{req.headers.to_json}"
    end

    if response.status == 200
      obtener_autores_relacionados_de_respuesta(autor, response)
    else
      @logger.error "Error al obtener autores relacionados: #{response.body}"
      raise AutorNoEncontradoError
    end
  end

  protected

  def pedir_token
    auth_header = Base64.strict_encode64("#{@client_id}:#{@client_secret}")
    Faraday.new(url: SPOTIFY_TOKEN_API_URL).post do |req|
      req.headers['Authorization'] = "Basic #{auth_header}"
      req.headers['Content-Type'] = CONTENT_TYPE
      req.body = { grant_type: GRANT_TYPE }
      @logger.debug "Pidiendo token a #{SPOTIFY_TOKEN_API_URL} - headers: #{req.headers.to_json} - body: #{req.body.to_json}"
    end
  end

  def obtener_autores_relacionados_de_respuesta(autor, response)
    @logger.debug "Autores relacionados obtenidos: #{response.body}"
    relacionados = parsear_relacionados(response)
    AutoresRelacionados.new(autor, relacionados)
  end

  def parsear_relacionados(response)
    JSON.parse(response.body)['artists'].map do |relacionado|
      Autor.new(relacionado['name'], relacionado['id'])
    end
  end
end
