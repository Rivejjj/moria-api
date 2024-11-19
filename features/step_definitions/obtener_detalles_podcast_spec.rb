Cuando('el usuario obtiene los detalles del podcast con id {int}') do |id_podcast|
  @respuesta = Faraday.get("/contenidos/#{id_podcast}/detalles")
end

Entonces('se le informa los detalles del podcast') do
  expect(@respuesta.status).to eq 200
  podcast_respuesta = JSON.parse(@respuesta.body, symbolize_names: true)
  id_podcast = podcast_respuesta[:podcast]
  detalles_podcast = podcast_respuesta[:detalles]
  episodios = podcast_respuesta[:episodios]
  expect(id_podcast).to eq @podcast.id
  expect(detalles_podcast[:nombre]).to eq @podcast.nombre
  expect(detalles_podcast[:autor]).to eq @podcast.autor
  expect(detalles_podcast[:genero]).to eq @podcast.genero
  expect_episodios(episodios)
end

def expect_episodios(episodios_json, podcast)
  podcast.episodios.each do |episodio|
    detalles_episodio = episodios_json[episodio.numero_episodio]
    expect(detalles_episodio[:nombre]).to eq episodio.nombre
    expect(detalles_episodio[:duracion]).to eq episodio.duracion
  end
end
