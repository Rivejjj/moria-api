Dado('que no hay canciones registradas') do
  repo_contenido = RepositorioContenido.new
  repo_contenido.delete_all
end

Cuando('el administrador carga la cancion {string} hecha por {string} en {int} con duracion de {int} segundos y genero {string}') do |nombre, autor, anio, duracion, genero|
  @request_body = { nombre:, autor:, anio:, duracion:, genero: }
  @response = Faraday.post('/canciones', @request_body.to_json, { 'Content-Type' => 'application/json' })
end

Dado('que existe un autor con nombre {string}') do |nombre|
  request_body = { nombre:, id_externo: '3fMbdgg4jU18AjLCKBhRSm' }
  Faraday.post('/autores', request_body.to_json, { 'Content-Type' => 'application/json' })
end

Entonces('se da de alta la cancion') do
  expect(@response.status).to eq(201)
  repo_contenido = RepositorioContenido.new
  cancion = repo_contenido.first
  expect(cancion.nombre).to eq(@request_body[:nombre])
  expect(cancion.nombre_autor).to eq(@request_body[:autor])
  expect(cancion.anio).to eq(@request_body[:anio])
  expect(cancion.duracion).to eq(@request_body[:duracion])
  expect(cancion.genero).to eq(@request_body[:genero])
  expect(cancion.is_a?(Cancion)).to eq(true)
end

Entonces('no se da de alta la cancion') do
  expect(@response.status).to eq(404)
end
