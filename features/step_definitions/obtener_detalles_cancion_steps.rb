Cuando('el usuario obtiene los detalles de la cancion con id {int}') do |id_cancion|
  @respuesta = Faraday.get("/contenidos/#{id_cancion}/detalles")
end

Entonces('se le informa los detalles de la cancion') do
  expect(@respuesta.status).to eq 200
  cancion_respuesta = JSON.parse(@respuesta.body, symbolize_names: true)[:cancion]
  expect(cancion_respuesta[:nombre]).to eq @cancion.nombre
  expect(cancion_respuesta[:autor]).to eq @cancion.autor
  expect(cancion_respuesta[:anio]).to eq @cancion.anio
  expect(cancion_respuesta[:duracion]).to eq @cancion.duracion
  expect(cancion_respuesta[:genero]).to eq @cancion.genero
end
