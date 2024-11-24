Dado('que una cancion con id {int} fue reproducida por {int} usuarios esta semana') do |id_cancion, cantidad_reproducciones|
  cancion = crear_y_guardar_cancion('nombre_cancion', id_cancion)
  cantidad_reproducciones.times do |i|
    usuario = crear_y_guardar_usuario("Usuario#{id_cancion}#{i}")
    reproducir_cancion(usuario, cancion.id)
  end
end

Dado('que un episodio de un podcast con id {int} fue reproducido por {int} usuarios esta semana') do |id_podcast, cantidad_reproducciones|
  podcast = crear_y_guardar_podcast('nombre', id_podcast)
  episodio = EpisodioPodcast.new(1, 'nombre', 4567)
  podcast.agregar_episodio(episodio)
  RepositorioContenido.new.save(podcast)

  cantidad_reproducciones.times do |i|
    usuario = crear_y_guardar_usuario("Usuario#{id_podcast}#{i}")
    reproducir_episodio(usuario, episodio.id)
  end
end

Cuando('un usuario intenta obtener el contenido mas escuchado de la semana') do
  @response = Faraday.get('/contenidos/top_semanal')
end

Entonces('obtiene el top de contenidos con ids {int}, {int}, {int}') do |id1, id2, id3|
  expect(@response.status).to eq 200
  top_semanal = JSON.parse(@response.body)['top_semanal']
  expect(top_semanal[0]['id_contenido']).to eq id1
  expect(top_semanal[1]['id_contenido']).to eq id2
  expect(top_semanal[2]['id_contenido']).to eq id3
end

Dado('que una cancion con id {int} fue reproducida por {int} usuarios la semana pasada') do |id_cancion, cantidad_reproducciones|
  fix_date(Date.today - 7)

  cancion = crear_y_guardar_cancion('nombre_cancion', id_cancion)
  cantidad_reproducciones.times do |i|
    usuario = crear_y_guardar_usuario("Usuario#{id_cancion}#{i}")
    reproducir_cancion(usuario, cancion.id)
  end

  unfix_date
end

def fix_date(date)
  @original_today = Date.method(:today)
  Date.define_singleton_method(:today) do
    date
  end
end

def unfix_date
  Date.define_singleton_method(:today, @original_today)
end
