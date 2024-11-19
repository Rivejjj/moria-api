Dado('que no hay episodios de podcasts registrados') do
  repo_episodios = RepositorioEpisodiosPodcast.new
  repo_episodios.delete_all
end

Dado('que existe un podcast con id {int}') do |id|
  @id_podcast = id
  repo_contenido = RepositorioContenido.new
  info_podcast = InformacionContenido.new('El podcast de la semana', 'Juan Perez', 2020, 36_000, 'Entretenimiento')
  podcast = Podcast.new(info_podcast, id)
  repo_contenido.save(podcast)
end

Cuando('el administrador carga el episodio numero {int} de un podcast con id {int} llamado {string} con duracion de {int} segundos') do |numero, id_podcast, nombre, duracion|
  @request_body = { nombre:, numero:, duracion: }
  @response = Faraday.post("/podcasts/#{id_podcast}/episodios", @request_body.to_json, { 'Content-Type' => 'application/json' })
  @id_podcast = id_podcast
end

Entonces('se da de alta el episodio del podcast') do
  expect(@response.status).to eq(201)
  repo_episodios = RepositorioEpisodiosPodcast.new
  episodio = repo_episodios.first
  expect(episodio.nombre).to eq(@request_body[:nombre])
  expect(episodio.numero_episodio).to eq(@request_body[:numero])
  expect(episodio.duracion).to eq(@request_body[:duracion])
end

Entonces('no se da de alta el episodio del podcast') do
  expect(@response.status).to eq(404)
  repo_episodios = RepositorioEpisodiosPodcast.new
  expect(repo_episodios.all).to be_empty
end
