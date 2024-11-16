# language: es
Característica: Dar me gusta a cancion

    Escenario: US2:1 Usuario le da me gusta a una cancion
        Dado que existe un usuario "Kevin"
        Y existe una cancion con id 1
        Y reprodujo la cancion con id 1
        Cuando el usuario le da me gusta a una cancion con id 1
        Entonces se registra el me gusta
        Y se le informa que la calificacion fue registrada

    Escenario: US2:2 Persona no registrada le da me gusta a una cancion
        Dado que una persona no esta registrada
        Cuando la persona le da me gusta a una cancion con id 1
        Entonces la persona debe registrarse

