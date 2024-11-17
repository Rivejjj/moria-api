class RepositorioMeGustasDeUsuario
  def save(usuario)
    db = DB[:me_gustas]
    usuario.me_gustas.each do |me_gusta|
      db.insert(id_usuario: usuario.id, id_contenido: me_gusta.id) unless me_gusta_de_usuario_ya_en_db?(me_gusta.id, usuario.id)
    end
  end

  def delete_all
    DB[:me_gustas].delete
  end

  def load(usuario)
    me_gustas = find_me_gustas(usuario)
    me_gustas.each do |contenido|
      usuario.me_gusta(contenido)
    end
  end

  protected

  def me_gusta_de_usuario_ya_en_db?(id_contenido, id_usuario)
    db_filtrado = DB[:me_gustas].where(id_usuario:, id_contenido:)
    !db_filtrado.first.nil?
  end

  def find_me_gustas(usuario)
    repositorio_contenido = RepositorioContenido.new
    me_gustas = DB[:me_gustas]
    me_gustas_filtrado = me_gustas.where(id_usuario: usuario.id)
    me_gustas = []
    me_gustas_filtrado.each do |fila|
      me_gustas << repositorio_contenido.find(fila[:id_contenido])
    end
    me_gustas
  end
end
