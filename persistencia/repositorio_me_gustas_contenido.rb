class RepositorioMeGustasContenido
  def save(me_gustas_contenido)
    me_gustas_contenido.usuarios.each do |usuario|
      DB[:me_gustas].insert(id_usuario: usuario.id, id_contenido: me_gustas_contenido.contenido.id)
    end
  end

  def delete_all
    DB[:me_gustas].delete
  end

  def get(id_contenido)
    reproducciones = get_reproducciones_contenido(id_contenido)
    me_gustas_contenido = MeGustasContenido.new(reproducciones)
    me_gustas = DB[:me_gustas].where(id_contenido:)
    me_gustas.each do |fila|
      usuario = RepositorioUsuarios.new.find(fila[:id_usuario])
      me_gustas_contenido.agregar_me_gusta_de(usuario)
    end
    me_gustas_contenido
  end

  def obtener_me_gustas_de(usuario)
    filas_usuario = DB[:me_gustas].where(id_usuario: usuario.id)
    me_gustas = []
    filas_usuario.each do |fila|
      me_gustas << get(fila[:id_contenido])
    end
    me_gustas
  end

  protected

  def get_reproducciones_contenido(id_contenido)
    contenido = RepositorioContenido.new.get(id_contenido)
    if contenido.is_a?(Podcast)
      reproducciones = RepositorioReproducciones.new.get_reproducciones_podcast(id_contenido)
    elsif contenido.is_a?(Cancion)
      reproducciones = RepositorioReproducciones.new.get_reproducciones_cancion(id_contenido)
    end
    reproducciones
  end
end
