# language: es
Característica: Obtener detalles de un podcast
  Escenario: US8:1 - Usuario intenta obtener los detalles de un podcast
    Dado que existe un podcast con id 1
    Y existen 2 episodios del podcast con id 1
    Cuando el usuario obtiene los detalles del podcast con id 1
    Entonces se le informa los detalles del podcast

  Escenario: US8:2 - Usuario intenta obtener los detalles de un podcast que no existe
    Cuando el usuario obtiene los detalles del podcast con id 1
    Entonces no se le informa los detalles del podcast
