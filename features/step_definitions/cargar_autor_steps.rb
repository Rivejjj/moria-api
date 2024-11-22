Dado('que no hay autores registrados') do
  RepositorioAutores.new.delete_all
end

Cuando('el administrador carga el autor {string} con id_externo {string}') do |nombre, id_externo|
  @request_body = { nombre:, id_externo: }
  @response = Faraday.post('/autores', @request_body.to_json, { 'Content-Type' => 'application/json' })
end

Entonces('se da de alta el autor') do
  expect(@response.status).to eq(201)
  repo_autores = RepositorioAutores.new
  autor = repo_autores.first
  expect(JSON.parse(@response.body)['id_autor']).to eq(autor.id)
  expect(autor.nombre).to eq(@request_body[:nombre])
  expect(autor.id_externo).to eq(@request_body[:id_externo])
end
