Dado('existe un episodio de un podcast con id {int}') do |id_episodio|
  contenido_repo = RepositorioContenido.new
  podcast = Podcast.new(InformacionContenido.new('nombre', 'autor', 2021, 180, 'genero'))
  episodio_podcast = EpisodioPodcast.new(1, 'nombre', 4567, id_episodio)
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
  reproducciones_episodio_podcast = RepositorioReproducciones.new.get_reproducciones_episodio_podcast(@id_episodio)
  expect(reproducciones_episodio_podcast.contiene_reproduccion_de?(@usuario)).to be true
end
