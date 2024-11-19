class RepositorioContenidoDeUsuario
  def save(usuario)
    RepositorioPlaylistsDeUsuario.new.save(usuario)
    RepositorioReproduccionesDeUsuario.new.save(usuario)
  end

  def delete_all
    RepositorioMeGustasContenido.new.delete_all
    RepositorioPlaylistsDeUsuario.new.delete_all
    RepositorioReproduccionesDeUsuario.new.delete_all
  end

  def load_a_usuario(usuario)
    RepositorioPlaylistsDeUsuario.new.load(usuario)
    RepositorioReproduccionesDeUsuario.new.load(usuario)
  end
end
