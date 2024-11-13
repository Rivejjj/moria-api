Dado('existe una cancion {string} con id {int}') do |nombre_cancion, id_cancion|
  repo_contenido = RepositorioContenido.new
  info_cancion = InformacionCancion.new(nombre_cancion, 'autor', 2020, 180, 'rock')
  cancion = Cancion.new(info_cancion, id_cancion)
  repo_contenido.save(cancion)
end

Cuando('el usuario agrega la cancion con id {int} a su playlist') do |id_cancion|
  request_body = { 'id_cancion' => id_cancion }.to_json
  @response = Faraday.post("/usuarios/#{ID_PLATAFORMA_PRUEBA}/playlist", request_body, { 'Content-Type' => 'application/json' })
end

Entonces('se agrega la cancion {string} a la playlist') do |nombre_cancion|
  expect(@response.status).to eq(201)
  repo_usuarios = RepositorioUsuarios.new
  usuario = repo_usuarios.find_by_id_plataforma(ID_PLATAFORMA_PRUEBA)
  expect(usuario.tiene_cancion_en_playlist(nombre_cancion)).to eq true
end

Entonces('no se agrega la cancion a la playlist') do
  expect(@response.status).to eq(404)
  repo_usuarios = RepositorioUsuarios.new
  usuario = repo_usuarios.find_by_id_plataforma(ID_PLATAFORMA_PRUEBA)
  expect(usuario.playlist.size).to eq 0
end

Dado('que una persona no esta registrada') do
  # No hacer nada
end

Cuando('la persona agrega la cancion con id {int} a su playlist') do |id_cancion|
  request_body = { 'id_cancion' => id_cancion }.to_json
  @response = Faraday.post("/usuarios/#{ID_PLATAFORMA_PRUEBA}/playlist", request_body, { 'Content-Type' => 'application/json' })
end
