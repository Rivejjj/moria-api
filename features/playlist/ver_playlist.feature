# language: es
Característica: Ver playlist

  Escenario: US20:1 - Un usuario con tres canciones y un podcast en su playlist pide ver su playlist
    Dado que existe un usuario "Kevin"
    Y que tiene 3 canciones en su playlist
    Y que tiene 1 podcasts en su playlist
    Cuando pide ver la playlist
    Entonces obtiene todos los contenidos de su playlist

  @wip
  Escenario: US20:2 - Una persona no registrada pide ver su playlist
    Dado que una persona no esta registrada
    Cuando pide ver la playlist
    Entonces la persona debe registrarse
