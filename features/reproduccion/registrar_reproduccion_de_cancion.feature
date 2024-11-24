# language: es
  Característica: Registracion de reproduccion de cancion

  Escenario: US31:1 - "Registracion de reproduccion de cancion para un usuario existente"
    Dado que existe un usuario "Kevin"
    Y que existe una cancion con id 1
    Cuando reproduce una cancion con id 1
    Entonces se registra la reproduccion
