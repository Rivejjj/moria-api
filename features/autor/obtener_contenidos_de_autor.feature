# language: es
Característica: Obtener contenidos de autor

  Escenario: US48:1 - Usuario intenta obtener los contenidos de un autor
    Dado que existe un autor con nombre "Michael Jackson"
    Y que existe una cancion de "Michael Jackson"
    Y que existe un podcast de "Michael Jackson"
    Cuando un usuario intenta obtener los contenidos del autor "Michael Jackson"
    Entonces obtiene los contenidos del autor

  @wip
  Escenario: US48:2 - Usuario intenta obtener lo contenidos de un autor que no existe
    Cuando un usuario intenta obtener los contenidos del autor "Michael Jackson"
    Entonces no obtiene los contenidos del autor
