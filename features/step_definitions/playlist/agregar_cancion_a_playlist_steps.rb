Dado('existe una cancion {string} con id {int}') do |nombre_cancion, id_cancion|
  crear_y_guardar_cancion(nombre_cancion, id_cancion)
end

Cuando('el usuario agrega la cancion con id {int} a su playlist') do |id_cancion|
  request_body = { 'id_contenido' => id_cancion }.to_json
  @response = Faraday.post("/usuarios/#{ID_PLATAFORMA_PRUEBA}/playlist", request_body, { 'Content-Type' => 'application/json' })
end

Entonces('se agrega la cancion {string} a la playlist') do |nombre_cancion|
  expect(@response.status).to eq(201)
  expect(JSON.parse(@response.body)['nombre']).to eq nombre_cancion
  repo_usuarios = RepositorioUsuarios.new
  usuario = repo_usuarios.get_by_id_plataforma(ID_PLATAFORMA_PRUEBA)
  expect(usuario.tiene_cancion_en_playlist(nombre_cancion)).to eq true
end

Entonces('no se agrega la cancion a la playlist') do
  expect(@response.status).to eq(404)
  repo_usuarios = RepositorioUsuarios.new
  usuario = repo_usuarios.get_by_id_plataforma(ID_PLATAFORMA_PRUEBA)
  expect(usuario.playlist.size).to eq 0
end

Dado('que una persona no esta registrada') do
  # No hacer nada
end

Cuando('la persona agrega la cancion con id {int} a su playlist') do |id_cancion|
  request_body = { 'id_contenido' => id_cancion }.to_json
  @response = Faraday.post("/usuarios/#{ID_PLATAFORMA_PRUEBA}/playlist", request_body, { 'Content-Type' => 'application/json' })
end

Entonces('la persona debe registrarse') do
  expect(@response.status).to eq(401)
end

def crear_y_guardar_cancion(nombre_cancion, id = 1)
  repo_contenido = RepositorioContenido.new
  autor = Autor.new('autor', '12345678')
  RepositorioAutores.new.save(autor)
  info_cancion = InformacionContenido.new(nombre_cancion, autor, 2020, 180, 'genero')
  cancion = Cancion.new(info_cancion, id)
  repo_contenido.save(cancion)
  cancion
end
