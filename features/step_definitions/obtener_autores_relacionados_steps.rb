Cuando('un usuario intenta obtener los autores relacionados a {string}') do |nombre_autor|
  @respuesta = Faraday.get("/autores/relacionados?nombre_autor=#{nombre_autor}")
end

Entonces('obtiene {int} autores relacionados') do |cantidad_autores_relacionados|
  expect(@respuesta.status).to eq 200
  autores_relacionados = JSON.parse(@respuesta.body, symbolize_names: true)[:relacionados]
  expect(autores_relacionados.size).to eq cantidad_autores_relacionados
end
