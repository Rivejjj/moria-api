# language: es
Característica: Agregar canción a playlist
  @wip
  Escenario: US16:1 - "Usuario agrega una cancion a su playlist"
    Dado que existe un usuario "Kevin"
    Y existe una cancion "Beat it" con id 1
    Cuando el usuario agrega la cancion con id 1 a su playlist
    Entonces se agrega la cancion "Beat it" a la playlist
