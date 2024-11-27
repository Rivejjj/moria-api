Dado('que tiene {int} canciones en su playlist') do |cantidad_canciones_en_playlist|
  agregar_contenidos_a_playlist(@usuario, cantidad_canciones_en_playlist, Cancion)
end

Dado('que tiene {int} podcasts en su playlist') do |cantidad_podcasts_en_playlist|
  agregar_contenidos_a_playlist(@usuario, cantidad_podcasts_en_playlist, Podcast)
end

Cuando('pide ver la playlist') do
  @response = Faraday.get("/usuarios/#{ID_PLATAFORMA_PRUEBA}/playlist")
end

Entonces('obtiene todos los contenidos de su playlist') do
  expect(@response.status).to eq 200
  playlist = JSON.parse(@response.body)['playlist']
  expect(playlist.length).to eq @usuario.playlist.length
  expect(playlist.map(&:id_contenido)).to eq(@usuario.playlist.map(&:id))
end

def agregar_contenidos_a_playlist(usuario, cantidad_contenidos, tipo_contenido)
  repo_contenido = RepositorioContenido.new
  autor = Autor.new('Autor', '12345678')
  RepositorioAutores.new.save(autor)
  cantidad_contenidos.times do |i|
    nombre_contenido = "#{tipo_contenido.name}#{i}"
    info_contenido = InformacionContenido.new(nombre_contenido, autor, 2020, 180, 'Rock')
    contenido = tipo_contenido.new(info_contenido)
    repo_contenido.save(contenido)
    usuario.agregar_a_playlist(contenido)
  end
  RepositorioUsuarios.new.save(usuario)
end
