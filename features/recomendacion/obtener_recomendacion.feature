# language: es
Característica: Obtener recomendacion

  Escenario: US9:2 - Recomendacion sin contenido
    Dado que existe un usuario "Kevin"
    Y que no hay canciones registradas
    Y que no hay podcasts registrados
    Cuando pide una recomendacion
    Entonces obtiene una recomendacion vacia
  
  Escenario: US9:3 - Persona no registrada pide recomendacion de canciones
    Dado que una persona no esta registrada
    Cuando pide una recomendacion
    Entonces la persona debe registrarse
