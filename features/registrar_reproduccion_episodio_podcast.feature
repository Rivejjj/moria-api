# language: es
Característica: Cargar reproduccion de episodio de podcast
  Escenario: US40:1 - Registracion de reproduccion de un episodio de un podcast para un usuario existente
      Dado que existe un usuario "Kevin"
      Y existe un episodio de un podcast con id 1
      Cuando reproduce un episodio de un podcast con id 1
      Entonces se registra la reproduccion del episodio del podcast
