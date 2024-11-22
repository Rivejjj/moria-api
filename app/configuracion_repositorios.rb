class ConfiguracionRepositorios
  attr_reader :repositorio_usuarios, :repositorio_contenido, :repositorio_episodios, :repositorio_me_gustas_contenido, :repositorio_reproducciones, :repositorio_autores

  def initialize
    @repositorio_usuarios = RepositorioUsuarios.new
    @repositorio_contenido = RepositorioContenido.new
    @repositorio_episodios = RepositorioEpisodiosPodcast.new
    @repositorio_me_gustas_contenido = RepositorioMeGustasContenido.new
    @repositorio_reproducciones = RepositorioReproducciones.new
    @repositorio_autores = RepositorioAutores.new
  end
end
