# language: es
Característica: Obtener recomendacion
  Escenario: US45:1 - Usuario intenta obtener una una recomendación de contenido según el género que más le gusta
    Dado que existe un usuario "Kevin"
    Y que existen 3 canciones del genero "rock" y a 2 le dio me gusta
    Y que existen 2 canciones del genero "pop" y a 1 le dio me gusta
    Y que existen 1 podcasts del genero "rock" y a 0 le dio me gusta
    Cuando el usuario intenta obtener una recomendacion segun el genero que mas le gusta
    Entonces obtiene una cancion de genero "rock" a la que no le dio me gusta
    Y obtiene un podcast de genero "rock" al que no le dio me gusta

  Escenario: US45:2 - Usuario intenta obtener una una recomendación de contenido según el género que más le gusta habiendo dado me gusta a todos los contenidos de ese genero
    Dado que existe un usuario "Kevin"
    Y que existen 2 canciones del genero "rock" y a 2 le dio me gusta
    Y que existen 1 podcasts del genero "rock" y a 1 le dio me gusta
    Y que existen 1 canciones del genero "pop" y a 0 le dio me gusta
    Y que existen 1 podcasts del genero "pop" y a 0 le dio me gusta
    Cuando el usuario intenta obtener una recomendacion segun el genero que mas le gusta
    Entonces obtiene una cancion de las ultimas cargadas a la que no le dio me gusta 
    Y obtiene un podcast de los ultimos cargados al que no le dio me gusta

  Escenario: US45:3 - Usuario intenta obtener una una recomendación de contenido según el género que más le gusta siendo distintos los generos mas gustados entre podcast y cancion
    Dado que existe un usuario "Kevin"
    Y que existen 3 canciones del genero "rock" y a 2 le dio me gusta
    Y que existen 2 podcasts del genero "pop" y a 1 le dio me gusta
    Y que existen 1 podcasts del genero "rock" y a 0 le dio me gusta
    Cuando el usuario intenta obtener una recomendacion segun el genero que mas le gusta
    Entonces obtiene una cancion de genero "rock" a la que no le dio me gusta
    Y obtiene un podcast de genero "rock" al que no le dio me gusta

