Dado('que tiene {int} canciones en su playlist') do |cantidad_canciones_en_playlist|
  repo_contenido = RepositorioContenido.new
  autor = Autor.new('Autor', '12345678')
  RepositorioAutores.new.save(autor)
  cantidad_canciones_en_playlist.times do |i|
    id_cancion = i + 1
    nombre_cancion = "Cancion#{id_cancion}"
    info_cancion = InformacionContenido.new(nombre_cancion, autor, 2020, 180, 'Rock')
    cancion = Cancion.new(info_cancion, id_cancion)
    repo_contenido.save(cancion)
    @usuario.agregar_a_playlist(cancion)
  end
  RepositorioUsuarios.new.save(@usuario)
end

Cuando('pide una recomendacion') do
  @response = Faraday.get("/usuarios/#{ID_PLATAFORMA_PRUEBA}/recomendacion")
end

Entonces('obtiene las ultimas {int} canciones de su playlist') do |cantidad_canciones_recomendadas|
  expect(@response.status).to eq 200
  recomendacion = JSON.parse(@response.body)['recomendacion']
  expect(recomendacion.length).to eq cantidad_canciones_recomendadas
  recomendacion.each_with_index do |cancion, i|
    id_cancion = cancion['id_cancion']
    expect(id_cancion).to eq @usuario.playlist.length - i
  end
end
