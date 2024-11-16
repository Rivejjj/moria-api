#language: es
Característica: Cargar episodio de podcast

  Escenario: US39:1 - Administrador carga un episodio de un podcast
    Dado que no hay episodios de podcasts registrados
    Y existe un podcast con id 1
    Cuando el administrador carga el episodio numero 1 de un podcast con id 1 llamado "Episodio 1" con duracion de 3600 segundos
    Entonces se da de alta el episodio del podcast

  @wip
  Escenario: US39:2 - Administrador carga un episodio de un podcast que no existe
    Dado que no hay episodios de podcasts registrados
    Y que no hay podcasts registrados
    Cuando el administrador carga el episodio numero 1 de un podcast con id 1 llamado "Episodio 1" con duracion de 3600 segundos
    Entonces no se da de alta el episodio del podcast
