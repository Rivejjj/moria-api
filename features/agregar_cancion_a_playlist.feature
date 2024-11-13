# language: es
Característica: Agregar canción a playlist

  Escenario: US16:1 - Usuario agrega una cancion a su playlist
    Dado que existe un usuario "Kevin"
    Y existe una cancion "Beat it" con id 1
    Cuando el usuario agrega la cancion con id 1 a su playlist
    Entonces se agrega la cancion "Beat it" a la playlist
  
  Escenario: US16:2 - Usuario agrega una cancion que no existe a su playlist
    Dado que existe un usuario "Kevin"
    Cuando el usuario agrega la cancion con id 1 a su playlist
    Entonces no se agrega la cancion a la playlist

  @wip
  Escenario: US16:3 - Persona no registrada agrega una cancion a su playlist
    Dado que una persona no esta registrada
    Y existe una cancion "Beat it" con id 1
    Cuando la persona agrega la cancion con id 1 a su playlist
    Entonces no se agrega la cancion a la playlist
