Dado('existen {int} episodios del podcast con id {int}') do |cantidad, id_podcast|
  (1..cantidad).each do |i|
    crear_episodio_para_podcast(id_podcast, i)
  end
end

Dado('reprodujo {int} episodios del podcast con id {int}') do |cantidad, id_podcast|
  podcast = RepositorioContenido.new.get(id_podcast)
  cantidad.times do |i|
    reproducciones_episodio = RepositorioReproducciones.new.get_reproducciones_episodio_podcast(podcast.episodios[i].id)
    reproducciones_episodio.agregar_reproduccion_de(@usuario)
    RepositorioReproducciones.new.save_reproducciones_episodio_podcast(reproducciones_episodio)
  end
end

Cuando('el usuario le da me gusta a un podcast con id {int}') do |id_podcast|
  request_body = { id_plataforma: @usuario.id_plataforma }.to_json
  @response = Faraday.post("/contenidos/#{id_podcast}/megusta", request_body, { 'Content-Type' => 'application/json' })
end

Entonces('se registra el me gusta') do
  me_gustas_podcast = RepositorioMeGustasContenido.new.get(@id_contenido)
  expect(me_gustas_podcast.usuarios.any? { |un_usuario| un_usuario.es_el_mismo_usuario_que?(@usuario) }).to be(true)
end

Entonces('no se registra el me gusta') do
  me_gustas_podcast = RepositorioMeGustasContenido.new.get(@id_contenido)
  expect(me_gustas_podcast.usuarios.any? { |un_usuario| un_usuario.es_el_mismo_usuario_que?(@usuario) }).to be(false)
end

Entonces('se le informa que debe reproducir episodios del podcast') do
  expect(@response.status).to eq(403)
  expect(JSON.parse(@response.body)['tipo_contenido']).to eq('podcast')
end

def crear_episodio_para_podcast(id_podcast, numero_episodio)
  podcast = RepositorioContenido.new.get(id_podcast)
  episodio_podcast = EpisodioPodcast.new(numero_episodio, 'nombre', 4567)
  podcast.agregar_episodio(episodio_podcast)
  RepositorioContenido.new.save(podcast)
end
