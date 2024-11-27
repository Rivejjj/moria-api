Dado('existe un podcast {string} con id {int}') do |nombre_podcast, id|
  repo_contenido = RepositorioContenido.new
  autor = Autor.new('autor', '12345678')
  RepositorioAutores.new.save(autor)
  info_podcast = InformacionContenido.new(nombre_podcast, autor, 2020, 180, 'genero')
  podcast = Podcast.new(info_podcast, id)
  repo_contenido.save(podcast)
end

Cuando('el usuario agrega el podcast con id {int} a su playlist') do |id_podcast|
  request_body = { 'id_contenido' => id_podcast }.to_json
  @response = Faraday.post("/usuarios/#{ID_PLATAFORMA_PRUEBA}/playlist", request_body, { 'Content-Type' => 'application/json' })
end

Entonces('se agrega el podcast {string} a la playlist') do |nombre_podcast|
  expect(@response.status).to eq(201)
  expect(JSON.parse(@response.body)['nombre']).to eq nombre_podcast
  repo_usuarios = RepositorioUsuarios.new
  usuario = repo_usuarios.get_by_id_plataforma(ID_PLATAFORMA_PRUEBA)
  expect(usuario.playlist.any? { |contenido| contenido.nombre == nombre_podcast }).to eq true
end
