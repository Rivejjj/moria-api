# language: es
Característica: Registrar usuario

  Escenario: US1:1 - Una persona intenta registrarse en el sistema con un nombre de usuario no utilizado
    Dado que no hay usuarios en el sistema
    Cuando una persona se registra con el usuario "Kevin" y mail "kevin@mail.com"
    Entonces la registracion es exitosa

  Escenario: US1:2 - Una persona intenta registrarse en el sistema con un nombre de usuario utilizado
    Dado que existe un usuario "Kevin"
    Cuando una persona se registra con el usuario "Kevin" y mail "kevin@mail.com"
    Entonces la registracion falla
