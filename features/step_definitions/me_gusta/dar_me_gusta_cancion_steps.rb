Cuando('el usuario le da me gusta a una cancion con id {int}') do |id_cancion|
  @id_contenido = id_cancion
  request_body = { id_plataforma: @usuario.id_plataforma }.to_json
  @response = Faraday.post("/contenidos/#{id_cancion}/megusta", request_body, { 'Content-Type' => 'application/json' })
end

Entonces('se le informa que la calificacion fue registrada') do
  expect(@response.status).to eq(201)
end

Cuando('la persona le da me gusta a una cancion con id {int}') do |id_cancion|
  request_body = { id_plataforma: '123456789' }.to_json
  @response = Faraday.post("/contenidos/#{id_cancion}/megusta", request_body, { 'Content-Type' => 'application/json' })
end

Dado('reprodujo la cancion con id {int}') do |id_cancion|
  reproducir_cancion(@usuario, id_cancion)
end

Entonces('se le informa que debe reproducir la cancion') do
  expect(@response.status).to eq(403)
  expect(JSON.parse(@response.body)['tipo_contenido']).to eq('cancion')
end

def reproducir_cancion(usuario, id_cancion)
  request_body = { 'nombre_usuario' => usuario.nombre }.to_json
  Faraday.post("/canciones/#{id_cancion}/reproduccion", request_body, { 'Content-Type' => 'application/json' })
end
