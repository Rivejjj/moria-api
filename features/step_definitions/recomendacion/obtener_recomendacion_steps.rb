Cuando('pide una recomendacion') do
  @response = Faraday.get("/usuarios/#{ID_PLATAFORMA_PRUEBA}/recomendacion")
end

Entonces('obtiene una recomendacion vacia') do
  expect(@response.status).to eq 200
  recomendacion = JSON.parse(@response.body)['recomendacion']
  expect(recomendacion.length).to eq 0
end
