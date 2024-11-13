Cuando('el usuario le da me gusta a una cancion con id: {int}') do |_int|
  @request_body = { id_plataforma: @usuario.id_plataforma }
  @response = Faraday.post("/canciones/#{id_cancion}/megusta", request_body, { 'Content-Type' => 'application/json' })
end

Entonces('se registra el me gusta') do
  repo_usuarios = RepositorioUsuarios.new
  usuario = repo_usuarios.find_by_nombre(@usuario.nombre)
  expect(usuario.me_gustas).to include(@id_cancion)
end

Entonces('se le informa que la calificacion fue registrada') do
  expect(@response.status).to eq(201)
end
