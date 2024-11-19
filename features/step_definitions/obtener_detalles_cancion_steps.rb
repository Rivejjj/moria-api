Cuando('el usuario obtiene los detalles de la cancion con id {int}') do |id_cancion|
  @respuesta = Faraday.get("/contenidos/#{id_cancion}/detalles")
end

Entonces('se le informa los detalles de la cancion') do
  expect(@respuesta.status).to eq 200
  cancion_respuesta = JSON.parse(@respuesta.body, symbolize_names: true)
  id_cancion = cancion_respuesta[:cancion]
  detalles_cancion = cancion_respuesta[:detalles]
  expect(id_cancion).to eq @cancion.id
  expect(detalles_cancion[:nombre]).to eq @cancion.nombre
  expect(detalles_cancion[:autor]).to eq @cancion.autor
  expect(detalles_cancion[:anio]).to eq @cancion.anio
  expect(detalles_cancion[:duracion]).to eq @cancion.duracion
  expect(detalles_cancion[:genero]).to eq @cancion.genero
end
