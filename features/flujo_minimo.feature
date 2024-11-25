# language: es
@regression
Característica: Flujo minimo

  Escenario: Flujo minimo
    Cuando me registro
    Y cargo un autor
    Y cargo una cancion con el autor
    Y obtengo los detalles de la cancion
    Y obtengo los autores relacionados al autor
    Entonces estoy registrado
    Y hay un autor cargado
    Y hay una cancion cargada
    Y tengo los detalles de la cancion
    Y tengo los autores relacionados al autor
