# language: es
Característica: Cargar autor
  Escenario: US42:1 - Administrador carga un autor
    Dado que no hay autores registrados
    Cuando el administrador carga el autor "Joe Rogan" con id_externo "0bawsIe2P8ykB6psGv81P9"
    Entonces se da de alta el autor
