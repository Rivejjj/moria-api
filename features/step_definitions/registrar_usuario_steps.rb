Dado('que no hay usuarios en el sistema') do
  repo_usuarios = RepositorioUsuarios.new
  repo_usuarios.delete_all
end

Cuando('una persona se registra con el usuario {string} y mail {string}') do |nombre_de_usuario, email|
  request_body = { id_plataforma: 141_733_544, nombre_de_usuario:, email: }.to_json
  @response = Faraday.post('/usuarios', request_body, { 'Content-Type' => 'application/json' })
end

Entonces('la registracion es exitosa') do
  expect(@response.status).to eq(201)
end

Dado('que existe un usuario {string}') do |nombre_de_usuario|
  repo_usuarios = RepositorioUsuarios.new
  usuario = Usuario.new(nombre_de_usuario, 'email@email.com', 141_733_544)
  repo_usuarios.save(usuario)
end

Entonces('la registracion falla') do
  expect(@response.status).to eq(409)
end
