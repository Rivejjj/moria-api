Dado('existe un episodio de un podcast con id {int}') do |id|
  contenido_repo = RepositorioContenido.new
  podcast = Podcast.new(InformacionContenido.new('nombre', 'autor', 2021, 180, 'genero'))
  episodio_podcast = EpisodioPodcast.new(1, 'nombre', 4567, id)

  podcast.agregar_episodio(episodio_podcast)
  contenido_repo.save(podcast)
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
