class RepositorioContenidoDeUsuario
  def save(usuario)
    RepositorioPlaylistsDeUsuario.new.save(usuario)
    RepositorioReproduccionesDeUsuario.new.save(usuario)
    RepositorioMeGustasDeUsuario.new.save(usuario)
  end

  def delete_all
    RepositorioPlaylistsDeUsuario.new.delete_all
    RepositorioReproduccionesDeUsuario.new.delete_all
    RepositorioMeGustasDeUsuario.new.delete_all
  end

  def load_a_usuario(usuario)
    RepositorioPlaylistsDeUsuario.new.load(usuario)
    RepositorioReproduccionesDeUsuario.new.load(usuario)
    RepositorioMeGustasDeUsuario.new.load(usuario)
  end
end
