Dado('que existe una cancion de {string}') do |nombre_autor|
  repo_canciones = RepositorioContenido.new
  autor = RepositorioAutores.new.get_by_nombre(nombre_autor)
  info_cancion = InformacionContenido.new('Cancion', autor, 1982, 42, 'Pop')
  @cancion = Cancion.new(info_cancion)
  repo_canciones.save(@cancion)
end

Dado('que existe un podcast de {string}') do |nombre_autor|
  repo_podcasts = RepositorioContenido.new
  autor = RepositorioAutores.new.get_by_nombre(nombre_autor)
  info_podcast = InformacionContenido.new('Podcast', autor, 1982, 42, 'Pop')
  @podcast = Podcast.new(info_podcast)
  repo_podcasts.save(@podcast)
end

Cuando('un usuario intenta obtener los contenidos del autor {string}') do |nombre_autor|
  params = { 'nombre_autor' => nombre_autor }
  @respuesta = Faraday.get('/autores/contenidos', params)
end

Entonces('obtiene los contenidos del autor') do
  expect(@respuesta.status).to eq 200
  contenidos = JSON.parse(@respuesta.body, symbolize_names: true)[:contenidos]
  expect(contenidos.size).to eq 2
  expect(contenidos).to include({ id_contenido: @cancion.id, nombre_contenido: @cancion.nombre })
  expect(contenidos).to include({ id_contenido: @podcast.id, nombre_contenido: @podcast.nombre })
end
