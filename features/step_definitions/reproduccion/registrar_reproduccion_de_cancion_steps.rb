Dado('que existe una cancion con id {int}') do |id|
  repo_canciones = RepositorioContenido.new
  autor = Autor.new('Michael Jackson', '12345678')
  RepositorioAutores.new.save(autor)
  info_cancion = InformacionContenido.new('Thriller', autor, 1982, 42, 'Pop')
  @cancion = Cancion.new(info_cancion, id)
  repo_canciones.save(@cancion)
end

Cuando('reproduce una cancion con id {int}') do |id_cancion|
  @id_cancion = id_cancion
  request_body = { 'nombre_usuario' => @usuario.nombre }.to_json
  @response = Faraday.post("/canciones/#{id_cancion}/reproduccion", request_body, { 'Content-Type' => 'application/json' })
end

Entonces('se registra la reproduccion') do
  expect(@response.status).to eq(201)
  reproducciones_cancion = RepositorioReproducciones.new.get_reproducciones_cancion(@id_cancion)
  expect(reproducciones_cancion.contiene_reproduccion_de?(@usuario)).to be true
end
