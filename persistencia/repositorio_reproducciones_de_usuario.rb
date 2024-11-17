class RepositorioReproduccionesDeUsuario
  def save(usuario)
    save_reproducciones_de_canciones(usuario)
    save_reproducciones_de_episodio(usuario)
  end

  def delete_all
    DB[:reproducciones_canciones].delete
    DB[:reproducciones_episodios].delete
  end

  def load(usuario)
    reproducciones = find_reproducciones(usuario)
    reproducciones.each do |contenido|
      usuario.agregar_reproduccion(contenido)
    end
  end

  protected

  def save_reproducciones_de_canciones(usuario)
    canciones = usuario.reproducciones.select(&:es_una_cancion?)
    db_reproducciones = DB[:reproducciones_canciones]
    canciones.each do |cancion|
      db_reproducciones.insert(id_usuario: usuario.id, id_contenido: cancion.id) unless reproduccion_cancion_ya_en_db?(cancion.id, usuario.id)
    end
  end

  def reproduccion_cancion_ya_en_db?(id_contenido, id_usuario)
    !DB[:reproducciones_canciones].where(id_usuario:, id_contenido:).first.nil?
  end

  def reproduccion_episodio_ya_en_db?(id_episodio, id_usuario)
    !DB[:reproducciones_episodios].where(id_usuario:, id_episodio:).first.nil?
  end

  def save_reproducciones_de_episodio(usuario)
    episodios = usuario.reproducciones.reject(&:es_una_cancion?)
    db_reproducciones = DB[:reproducciones_episodios]
    episodios.each do |episodio|
      db_reproducciones.insert(id_usuario: usuario.id, id_episodio: episodio.id) unless reproduccion_episodio_ya_en_db?(episodio.id, usuario.id)
    end
  end

  def find_reproducciones(usuario)
    find_reproducciones_canciones(usuario) + find_reproducciones_episodios(usuario)
  end

  def find_reproducciones_en_repositorio(repo, db_reproducciones, columna, usuario)
    reproducciones_filtrado = db_reproducciones.where(id_usuario: usuario.id)
    reproducciones = []
    reproducciones_filtrado.each do |fila|
      reproducciones << repo.find(fila[columna])
    end
    reproducciones
  end

  def find_reproducciones_canciones(usuario)
    find_reproducciones_en_repositorio(RepositorioContenido.new, DB[:reproducciones_canciones], :id_contenido, usuario)
  end

  def find_reproducciones_episodios(usuario)
    find_reproducciones_en_repositorio(RepositorioEpisodiosPodcast.new, DB[:reproducciones_episodios], :id_episodio, usuario)
  end
end
