# language: es
Característica: Cargar cancion
  Escenario: US23:1 - Administrador da de alta una cancion
    Dado que no hay canciones registradas
    Y que existe un autor con nombre "Michael Jackson"
    Cuando el administrador carga la cancion "Beat it" hecha por "Michael Jackson" en 1983 con duracion de 378 segundos y genero "Pop"
    Entonces se da de alta la cancion
