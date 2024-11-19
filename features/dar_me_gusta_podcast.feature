# language: es
Característica: Dar me gusta a podcast

  Escenario: US41:1 - Usuario intenta dar me gusta a un podcast del cual reprodujo 2 episodios
    Dado que existe un usuario "Kevin"
    Y que existe un podcast con id 1
    Y existen 2 episodios del podcast con id 1
    Y reprodujo 2 episodios del podcast con id 1
    Cuando el usuario le da me gusta a un podcast con id 1
    Entonces el me gusta se registra 
    Y se le informa que la calificacion fue registrada
