Dado('que existen {int} canciones del genero {string} y a {int} le dio me gusta') do |cantidad_canciones, genero, cantidad_me_gusta|
  canciones = crear_y_guardar_n_canciones_de_genero(cantidad_canciones, genero)
  guardar_reproducciones_de_canciones(@usuario, canciones.first(cantidad_me_gusta))
  dar_me_gustas(canciones)
end

Dado('que existen {int} podcasts del genero {string} y a {int} le dio me gusta') do |cantidad_podcast, genero, cantidad_megusta|
  id_podcasts = crear_y_guardar_n_podcasts_de_genero(cantidad_podcast, genero)
  dar_me_gustas(id_podcasts.first(cantidad_megusta))
end

Cuando('el usuario intenta obtener una recomendacion segun el genero que mas le gusta') do
  @response = Faraday.get("/usuarios/#{@usuario.id_plataforma}/recomendacion")
end

Entonces('obtiene una cancion de genero {string} a la que no le dio me gusta') do |genero|
  cancion = JSON.parse(@response.body)['recomendacion'][0]
  me_gustas_cancion = RepositorioMeGustasContenido.new.get(cancion['id_contenido'])
  expect(me_gustas_cancion.usuarios).not_to include(@usuario)
  expect(me_gustas_cancion.contenido.genero).to eq(genero)
end

Entonces('obtiene un podcast de genero {string} al que no le dio me gusta') do |genero|
  podcast = JSON.parse(@response.body)['recomendacion'][1]
  me_gustas_podcast = RepositorioMeGustasContenido.new.get(podcast['id_contenido'])
  expect(me_gustas_podcast.usuarios).not_to include(@usuario)
  expect(me_gustas_podcast.contenido.genero).to eq(genero)
end

Entonces('obtiene una cancion de las ultimas cargadas a la que no le dio me gusta') do
  cancion = JSON.parse(@response.body)['recomendacion'][0]
  me_gustas_cancion = RepositorioMeGustasContenido.new.get(cancion['id_contenido'])
  expect(me_gustas_cancion.usuarios).not_to include(@usuario)
  expect(me_gustas_cancion.contenido.genero).not_to eq(genero)
end

Entonces('obtiene un podcast de los ultimos cargados al que no le dio me gusta') do
  podcast = JSON.parse(@response.body)['recomendacion'][1]
  me_gustas_podcast = RepositorioMeGustasContenido.new.get(podcast['id_contenido'])
  expect(me_gustas_podcast.usuarios).not_to include(@usuario)
  expect(me_gustas_podcast.contenido.genero).not_to eq(genero)
end

def crear_y_guardar_autor(nombre)
  Faraday.post('/autores', { nombre:, id_externo: '12345' }.to_json, { 'Content-Type' => 'application/json' })
end

def crear_y_reproducir_episodio_para_podcast(usuario, numero, id_podcast)
  request_body = { nombre: "episodio#{numero}", numero:, duracion: 10_000 }
  response = Faraday.post("/podcasts/#{id_podcast}/episodios", request_body.to_json, { 'Content-Type' => 'application/json' })
  reproducir_episodio(usuario, JSON.parse(response.body)['id_episodio'])
end

def reproducir_episodio(usuario, id_episodio)
  request_body = { 'nombre_usuario' => usuario.nombre }
  Faraday.post("/episodios/#{id_episodio}/reproduccion", request_body.to_json, { 'Content-Type' => 'application/json' })
end

def crear_y_guardar_podcast_de_genero(nombre, genero)
  crear_y_guardar_autor('autor')
  request_body = { nombre:, autor: 'autor', anio: 2010, duracion: 1000, genero: }
  response = Faraday.post('/podcasts', request_body.to_json, { 'Content-Type' => 'application/json' })
  id_podcast = JSON.parse(response.body)['id_podcast']
  crear_y_reproducir_episodio_para_podcast(@usuario, 1, id_podcast)
  crear_y_reproducir_episodio_para_podcast(@usuario, 2, id_podcast)
  id_podcast
end

def crear_y_guardar_n_podcasts_de_genero(cantidad, genero)
  id_podcasts = []
  cantidad.times do |i|
    id_podcasts << crear_y_guardar_podcast_de_genero("podcast#{i}", genero)
  end
  id_podcasts
end

def crear_y_guardar_cancion_de_genero(nombre_cancion, genero)
  crear_y_guardar_autor('autor')
  cancion_body = { nombre: nombre_cancion, autor: 'autor', anio: 2010, duracion: 123, genero: }
  response = Faraday.post('/canciones', cancion_body.to_json, { 'Content-Type' => 'application/json' })
  JSON.parse(response.body)['id_cancion']
end

def crear_y_guardar_n_canciones_de_genero(cantidad, genero)
  id_canciones = []
  cantidad.times do |i|
    id_canciones << crear_y_guardar_cancion_de_genero("cancion#{i}", genero)
  end
  id_canciones
end

def guardar_reproduccion_de_cancion(usuario, id_cancion)
  request_body = { 'nombre_usuario' => usuario.nombre }.to_json
  Faraday.post("/canciones/#{id_cancion}/reproduccion", request_body, { 'Content-Type' => 'application/json' })
end

def guardar_reproducciones_de_canciones(usuario, canciones)
  canciones.each do |cancion|
    guardar_reproduccion_de_cancion(usuario, cancion)
  end
end

def guardar_reproduccion_de_podcast(_usuario, id_podcast)
  crear_episodio_para_podcast(1, id_podcast)
end

def dar_me_gustas(id_contenidos)
  id_contenidos.each do |id_contenido|
    request_body = { id_plataforma: @usuario.id_plataforma }.to_json
    Faraday.post("/contenidos/#{id_contenido}/megusta", request_body, { 'Content-Type' => 'application/json' })
  end
end
