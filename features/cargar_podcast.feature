# language: es
Característica: Cargar podcast

  Escenario: US27:1 - Administrador carga un podcast
    Dado que no hay podcasts registrados
    Y que existe un autor con nombre "Joe Rogan"
    Cuando el administrador carga el podcast "JRE" hecho por "Joe Rogan" en 2023 con duracion de 360000 segundos y genero "Cultura"
    Entonces se da de alta el podcast
