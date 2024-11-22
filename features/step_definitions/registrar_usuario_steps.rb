ID_PLATAFORMA_PRUEBA = '141733544'.freeze

Dado('que no hay usuarios en el sistema') do
  repo_usuarios = RepositorioUsuarios.new
  repo_usuarios.delete_all
end

Cuando('una persona se registra con el usuario {string} y mail {string}') do |nombre_de_usuario, email|
  @nombre_de_usuario = nombre_de_usuario
  @email = email
  request_body = { id_plataforma: ID_PLATAFORMA_PRUEBA, nombre_de_usuario:, email: }.to_json
  @response = Faraday.post('/usuarios', request_body, { 'Content-Type' => 'application/json' })
end

Entonces('la registracion es exitosa') do
  expect(@response.status).to eq(201)
  repo_usuarios = RepositorioUsuarios.new
  usuario = repo_usuarios.find_by_nombre(@nombre_de_usuario)
  expect(usuario.nombre).to eq(@nombre_de_usuario)
  expect(usuario.email).to eq(@email)
  expect(usuario.id_plataforma).to eq(ID_PLATAFORMA_PRUEBA)
end

Dado('que existe un usuario {string}') do |nombre_de_usuario|
  crear_y_guardar_usuario(nombre_de_usuario)
end

Entonces('la registracion falla') do
  expect(@response.status).to eq(409)
  repo_usuarios = RepositorioUsuarios.new
  expect(repo_usuarios.all.size).to eq(1)
  usuario = repo_usuarios.find_by_nombre(@nombre_de_usuario)
  expect(usuario.email).not_to eq(@email)
end

def crear_y_guardar_usuario(nombre_de_usuario)
  repo_usuarios = RepositorioUsuarios.new
  @usuario = Usuario.new(nombre_de_usuario, 'mail@existente.com', ID_PLATAFORMA_PRUEBA)
  repo_usuarios.save(@usuario)
end
