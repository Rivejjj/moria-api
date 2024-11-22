Dado('que no hay podcasts registrados') do
  repo_podcasts = RepositorioContenido.new
  repo_podcasts.delete_all
end

Cuando('el administrador carga el podcast {string} hecho por {string} en {int} con duracion de {int} segundos y genero {string}') do |nombre, autor, anio, duracion, genero|
  @request_body = { nombre:, autor:, anio:, duracion:, genero: }
  @response = Faraday.post('/podcasts', @request_body.to_json, { 'Content-Type' => 'application/json' })
end

Entonces('se da de alta el podcast') do
  expect(@response.status).to eq(201)
  repo_podcasts = RepositorioContenido.new
  podcast = repo_podcasts.first
  expect(podcast.nombre).to eq(@request_body[:nombre])
  expect(podcast.nombre_autor).to eq(@request_body[:autor])
  expect(podcast.anio).to eq(@request_body[:anio])
  expect(podcast.duracion).to eq(@request_body[:duracion])
  expect(podcast.genero).to eq(@request_body[:genero])
  expect(podcast.es_una_cancion?).to eq(false)
end
