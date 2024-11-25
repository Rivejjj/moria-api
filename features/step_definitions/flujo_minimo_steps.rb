Cuando('me registro') do
  @id = DateTime.now.strftime('%Y%m%d%H%M%S')
  @id_plataforma = "id_plataforma#{@id}"
  @nombre_usuario = "usuario#{@id}"
  @email = 'email@email.com'
  request_body = { id_plataforma: @id_plataforma, nombre_de_usuario: @nombre_usuario, email: @email }.to_json
  @respuesta_registrar_usuario = Faraday.post('/usuarios', request_body, { 'Content-Type' => 'application/json' })
end

Cuando('cargo un autor') do
  @nombre_autor = "autor#{@id}"
  @id_externo = '3fMbdgg4jU18AjLCKBhRSm'
  request_body = { nombre: @nombre_autor, id_externo: @id_externo }
  @respuesta_cargar_autor = Faraday.post('/autores', request_body.to_json, { 'Content-Type' => 'application/json' })
end

Cuando('cargo una cancion con el autor') do
  @nombre_cancion = "cancion#{@id}"
  @anio_cancion = 2020
  @duracion_cancion = 180
  @genero_cancion = 'rock'
  request_body = { nombre: @nombre_cancion, autor: @nombre_autor, anio: @anio_cancion, duracion: @duracion_cancion, genero: @genero_cancion }
  @respuesta_cargar_cancion = Faraday.post('/canciones', request_body.to_json, { 'Content-Type' => 'application/json' })
end

Cuando('obtengo los detalles de la cancion') do
  @id_cancion = JSON.parse(@respuesta_cargar_cancion.body, symbolize_names: true)[:id_cancion]
  @respuesta_detalles_cancion = Faraday.get("/contenidos/#{@id_cancion}/detalles")
end

Cuando('obtengo los autores relacionados al autor') do
  WebMock.allow_net_connect!
  params = { 'nombre_autor' => @nombre_autor }
  @respuesta_autores_relacionados = Faraday.get('/autores/relacionados', params)
  WebMock.disable_net_connect!
end

Entonces('estoy registrado') do
  expect(@respuesta_registrar_usuario.status).to eq 201
end

Entonces('hay un autor cargado') do
  expect(@respuesta_cargar_autor.status).to eq 201
end

Entonces('hay una cancion cargada') do
  expect(@respuesta_cargar_cancion.status).to eq 201
end

Entonces('tengo los detalles de la cancion') do
  expect(@respuesta_detalles_cancion.status).to eq 200
  cancion_respuesta = JSON.parse(@respuesta_detalles_cancion.body, symbolize_names: true)
  id_cancion = cancion_respuesta[:cancion]
  detalles_cancion = cancion_respuesta[:detalles]
  expect(id_cancion).to eq @id_cancion
  expect(detalles_cancion[:nombre]).to eq @nombre_cancion
  expect(detalles_cancion[:autor]).to eq @nombre_autor
  expect(detalles_cancion[:anio]).to eq @anio_cancion
  expect(detalles_cancion[:duracion]).to eq @duracion_cancion
  expect(detalles_cancion[:genero]).to eq @genero_cancion
end

Entonces('tengo los autores relacionados al autor') do
  expect(@respuesta_autores_relacionados.status).to eq 200
  autores_relacionados = JSON.parse(@respuesta_autores_relacionados.body, symbolize_names: true)[:relacionados]
  expect(autores_relacionados).to be_an_instance_of(Array)
end
