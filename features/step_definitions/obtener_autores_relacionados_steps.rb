Cuando('un usuario intenta obtener los autores relacionados a {string}') do |nombre_autor|
  stub_spotify_token
  stub_spotify_autores_relacionados
  params = { 'nombre_autor' => nombre_autor }
  @respuesta = Faraday.get('/autores/relacionados', params)
end

Entonces('obtiene {int} autores relacionados') do |cantidad_autores_relacionados|
  expect(@respuesta.status).to eq 200
  autores_relacionados = JSON.parse(@respuesta.body, symbolize_names: true)[:relacionados]
  expect(autores_relacionados.size).to eq cantidad_autores_relacionados
end

def stub_spotify_token
  body = {
    'access_token': 'fake_token',
    'token_type': 'Bearer',
    'expires_in': 3600
  }.to_json
  stub_request(:post, 'https://accounts.spotify.com/api/token')
    .to_return(status: 200, body:)
end

def stub_spotify_autores_relacionados
  body = {
    'artists': [
      { 'name': 'autor1', 'id': 'id_autor1' },
      { 'name': 'autor2', 'id': 'id_autor2' },
      { 'name': 'autor3', 'id': 'id_autor3' },
      { 'name': 'autor4', 'id': 'id_autor4' }
    ]
  }.to_json
  stub_request(:get, 'https://api.spotify.com/v1/artists/3fMbdgg4jU18AjLCKBhRSm/related-artists')
    .with(headers: {
            'Authorization' => 'Bearer fake_token'
          })
    .to_return(status: 200, body:)
end
