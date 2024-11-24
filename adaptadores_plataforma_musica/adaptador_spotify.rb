require 'dotenv/load'
require 'faraday'
require 'base64'
require 'json'

class AdaptadorSpotify
  SPOTIFY_TOKEN_API_URL = 'https://accounts.spotify.com/api/token'.freeze
  CONTENT_TYPE = 'application/x-www-form-urlencoded'.freeze
  GRANT_TYPE = 'client_credentials'.freeze
  SPOTIFY_AUTORES_API_URL = 'https://api.spotify.com/v1/artists'.freeze

  def initialize(client_id = ENV['CLIENT_ID'], client_secret = ENV['CLIENT_SECRET'])
    @client_id = client_id
    @client_secret = client_secret
    @logger = SemanticLogger['AdaptadorSpotify']
  end

  def obtener_token
    auth_header = Base64.strict_encode64("#{@client_id}:#{@client_secret}")
    response = Faraday.post(SPOTIFY_TOKEN_API_URL) do |req|
      req.headers['Authorization'] = "Basic #{auth_header}"
      req.headers['Content-Type'] = CONTENT_TYPE
      req.body = { grant_type: GRANT_TYPE }
    end

    if response.status == 200
      body = JSON.parse(response.body)
      token = body['access_token']
      @logger.debug "Token obtenido: #{token}"
      token
    else
      @logger.error "Error al obtener token: #{response.body}"
    end
  end

  def obtener_relacionados_a(autor)
    response = Faraday.get("#{SPOTIFY_AUTORES_API_URL}/#{autor.id_externo}/related-artists") do |req|
      req.headers['Authorization'] = "Bearer #{obtener_token}"
    end
    if response.status == 200
      @logger.debug "Autores relacionados obtenidos: #{response.body}"
      relacionados = parsear_relacionados(response)
      AutoresRelacionados.new(autor, relacionados)
    else
      @logger.error "Error al obtener autores relacionados: #{response.body}"
    end
  end

  protected

  def parsear_relacionados(response)
    JSON.parse(response.body)['artists'].map do |relacionado|
      Autor.new(relacionado['name'], relacionado['id'])
    end
  end
end
