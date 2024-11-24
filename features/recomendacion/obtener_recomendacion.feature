# language: es
Característica: Obtener recomendacion
  @wip
  Escenario: US9:1 - Recomendacion de canciones con mas de 5 canciones en playlist
    Dado que existe un usuario "Kevin"
    Y que tiene 6 canciones en su playlist
    Cuando pide una recomendacion
    Entonces obtiene las ultimas 5 canciones de su playlist
  @wip
  Escenario: US9:2 - Recomendacion de canciones sin canciones en playlist
    Dado que existe un usuario "Kevin"
    Y que tiene 0 canciones en su playlist
    Cuando pide una recomendacion
    Entonces obtiene las ultimas 0 canciones de su playlist
  
  Escenario: US9:3 - Persona no registrada pide recomendacion de canciones
    Dado que una persona no esta registrada
    Cuando pide una recomendacion
    Entonces la persona debe registrarse
