class RepositorioMeGustasContenido
  def save(me_gustas_contenido)
    changeset = changeset_sin_existentes(me_gustas_contenido)
    dataset.multi_insert(changeset) unless changeset.empty?
  end

  def delete_all
    dataset.delete
  end

  def get(id_contenido)
    reproducciones = get_reproducciones_contenido(id_contenido)
    me_gustas_contenido = MeGustasContenido.new(reproducciones)
    me_gustas = dataset.where(id_contenido:)
    me_gustas.each do |fila|
      usuario = RepositorioUsuarios.new.find(fila[:id_usuario])
      me_gustas_contenido.agregar_me_gusta_de(usuario)
    end
    me_gustas_contenido
  end

  def obtener_me_gustas_de(usuario)
    filas_usuario = dataset.where(id_usuario: usuario.id)
    contenido = RepositorioContenido.new.get_contenidos(filas_usuario.map { |fila| fila[:id_contenido] })
    MeGustasUsuario.new(usuario, contenido)
  end

  protected

  def dataset
    DB[:me_gustas]
  end

  def get_reproducciones_contenido(id_contenido)
    contenido = RepositorioContenido.new.get(id_contenido)
    if contenido.is_a?(Podcast)
      reproducciones = RepositorioReproducciones.new.get_reproducciones_podcast(id_contenido)
    elsif contenido.is_a?(Cancion)
      reproducciones = RepositorioReproducciones.new.get_reproducciones_cancion(id_contenido)
    end
    reproducciones
  end

  def obtener_filas_existentes(filas)
    dataset.where(Sequel.|(*filas))
  end

  def changeset_sin_existentes(me_gustas_contenido)
    me_gustas_a_insertar = changeset(me_gustas_contenido)
    me_gustas_existentes = obtener_filas_existentes(me_gustas_a_insertar)
    me_gustas_a_insertar.reject { |fila| me_gustas_existentes.include?(fila) }
  end

  def changeset(me_gustas_contenido)
    me_gustas_contenido.usuarios.map do |usuario|
      { id_usuario: usuario.id, id_contenido: me_gustas_contenido.contenido.id }
    end
  end
end
