# language: es
Característica: Top semanal
  Escenario: US44:1 - Usuario intenta obtener los 3 contenidos más reproducidos de la semana
    Dado que una cancion con id 1 fue reproducida por 3 usuarios esta semana
    Y que un episodio de un podcast con id 2 fue reproducido por 4 usuarios esta semana
    Y que un episodio de un podcast con id 3 fue reproducido por 1 usuarios esta semana
    Y que una cancion con id 4 fue reproducida por 5 usuarios esta semana
    Cuando un usuario intenta obtener el contenido mas escuchado de la semana
    Entonces obtiene el top de contenidos con ids 4, 2, 1

  Escenario: US44:2 - Usuario intenta obtener los 3 contenidos más reproducidos de la semana
    Dado que una cancion con id 1 fue reproducida por 3 usuarios esta semana
    Y que un episodio de un podcast con id 2 fue reproducido por 4 usuarios esta semana
    Y que un episodio de un podcast con id 3 fue reproducido por 1 usuarios esta semana
    Y que una cancion con id 4 fue reproducida por 5 usuarios la semana pasada
    Cuando un usuario intenta obtener el contenido mas escuchado de la semana
    Entonces obtiene el top de contenidos con ids 2, 1, 3
