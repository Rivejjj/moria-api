Dado('existe una cancion con id: {int}') do |id|
  repo_canciones = RepositorioContenido.new
  info_cancion = InformacionCancion.new('Thriller', 'Michael Jackson', 1982, 42, 'Pop')
  cancion = Cancion.new(info_cancion, id)
  repo_canciones.save(cancion)
end

Cuando('reproduce una cancion con id: {int}') do |id_cancion|
  @id_cancion = id_cancion
  request_body = { 'nombre_usuario' => @nombre_de_usuario }.to_json
  @response = Faraday.post("/canciones/#{id_cancion}/reproduccion", request_body, { 'Content-Type' => 'application/json' })
end

Entonces('se registra la reproduccion') do
  expect(@response.status).to eq(201)
  repo_usuarios = RepositorioUsuarios.new
  usuario = repo_usuarios.find_by_nombre(@nombre_de_usuario)
  expect(usuario.reprodujo_cancion?(@id_cancion)).to eq true
end
