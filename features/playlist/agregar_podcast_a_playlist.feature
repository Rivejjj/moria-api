# language: es
Característica: Agregar podcast a playlist
  Escenario: US49:1 - Usuario agrega un podcast a su playlist
    Dado que existe un usuario "Kevin"
    Y existe un podcast "JRE" con id 1
    Cuando el usuario agrega el podcast con id 1 a su playlist
    Entonces se agrega el podcast "JRE" a la playlist
