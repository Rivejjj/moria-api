Dado('existe un episodio de un podcast con id {int}') do |id|
  episodios_repo = RepositorioEpisodiosPodcast.new
  contenido_repo = RepositorioContenido.new
  podcast = Podcast.new(InformacionContenido.new('nombre', 'autor', 2021, 180, 'genero'))
  contenido_repo.save(podcast)

  episodio_podcast = EpisodioPodcast.new(1, podcast.id, 'nombre', 4567, id)
  episodios_repo.save(episodio_podcast)
end

Cuando('reproduce un episodio de un podcast con id {int}') do |id_episodio|
  request_body = { 'nombre_usuario' => @usuario.nombre }
  @response = Faraday.post("/episodios/#{id_episodio}/reproduccion", request_body.to_json, { 'Content-Type' => 'application/json' })
  @id_episodio = id_episodio
end

Entonces('se registra la reproduccion del episodio del podcast') do
  expect(@response.status).to eq(201)
  expect(JSON.parse(@response.body)['id_episodio']).to eq @id_episodio
  repo_usuarios = RepositorioUsuarios.new
  usuario = repo_usuarios.find_by_nombre(@usuario.nombre)
  expect(usuario.reproducciones.map(&:id)).to include(@id_episodio)
end
