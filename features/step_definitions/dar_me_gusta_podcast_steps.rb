Dado('existen {int} episodios del podcast con id {int}') do |cantidad, id_podcast|
  (1..cantidad).each do |i|
    crear_episodio_para_podcast(id_podcast, i)
  end
end

Dado('reprodujo {int} episodios del podcast con id {int}') do |cantidad, id_podcast|
  podcast = RepositorioContenido.new.get(id_podcast)
  (0..cantidad - 1).each do |i|
    reproducciones_episodio = RepositorioReproducciones.new.get_reproducciones_episodio_podcast(podcast.episodios[i].id)
    reproducciones_episodio.agregar_reproduccion_de(@usuario)
  end
end

Cuando('el usuario le da me gusta a un podcast con id {int}') do |id_podcast|
  request_body = { id_plataforma: @usuario.id_plataforma }.to_json
  @response = Faraday.post("/contenidos/#{id_podcast}/megusta", request_body, { 'Content-Type' => 'application/json' })
end

Entonces('el me gusta se registra') do
  me_gustas_podcast = RepositorioMeGustasContenido.new.get(@id_podcast)
  expect(me_gustas_podcast.usuarios.any? { |un_usuario| un_usuario.es_el_mismo_usuario_que?(@usuario) }).to be(true)
end

def crear_episodio_para_podcast(id_podcast, numero_episodio)
  podcast = RepositorioContenido.new.get(id_podcast)
  episodio_podcast = EpisodioPodcast.new(numero_episodio, 'nombre', 4567)
  podcast.agregar_episodio(episodio_podcast)
  RepositorioContenido.new.save(podcast)
end
