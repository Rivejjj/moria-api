# language: es
Característica: Obtener detalles de una cancion

  Escenario: US5:1 - Usuario intenta obtener los detalles de un cancion
    Dado que existe una cancion con id 1
    Cuando el usuario obtiene los detalles de la cancion con id 1
    Entonces se le informa los detalles de la cancion
  
  @wip
  Escenario: US5:2 - Usuario intenta obtener los detalles de un cancion que no existe
    Cuando el usuario obtiene los detalles de la cancion con id 1
    Entonces no se le informa los detalles de la cancion
