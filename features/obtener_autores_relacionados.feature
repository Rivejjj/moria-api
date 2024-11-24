# language: es
Característica: Obtener autores relacionados

  Escenario: US43:1 - Usuario intenta obtener los autores relacionados de un autor
    Dado que existe un autor con nombre "Michael Jackson"
    Cuando un usuario intenta obtener los autores relacionados a "Michael Jackson"
    Entonces obtiene 3 autores relacionados

