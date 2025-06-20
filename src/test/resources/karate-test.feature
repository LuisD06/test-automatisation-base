@REQA_TA
Feature: TA Automatización de pruebas para aplicación de gestión de personajes de Marvel - Marvel Characters API

  Background:
    * configure ssl = true
    * header Content-Type = 'application/json'
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters'


  @id:1 @ConsultarTodosLosPersonajes @ConsultarPersonajesValida
  Scenario: T-API-TA.CA01-Respuesta exitosa - karate
    When method GET
    Then status 200
    And match response == '#[]'
    And match each response == { id: '#number', name: '#string', alterego: '#string', description: '#string', powers: '#[] #string' }
  @id:2 @CreacionDePersonaje @CreacionDePersonajeValida
  Scenario: T-API-TA.CA02-Creación de personaje exitoso - karate
    And request { "name": "Spider Boby 4", "alterego": "Boby", "description": "Student", "powers": ["Armor", "Flight"] }
    When method POST
    Then status 201
    And match response == { id: '#number', name: 'Spider Boby 4', alterego: 'Boby', description: 'Student', powers: ['Armor', 'Flight'] }
  @id:3 @EliminaciónDePersonajePorId @EliminaciónDePersonajePorIdValida
  Scenario: T-API-TA.CA03-Eliminación de personaje por id exitoso - karate
    And path '1085'
    When method DELETE
    Then status 204
  @id:4 @ActualizaciónDePersonajePorId @ActualizaciónDePersonajePorIdValida
  Scenario: T-API-TA.CA04-Actualización de personaje por id exitoso - karate
    And path '1228'
    And request { "name": "Marvel Gold Goblin", "alterego": "Boby Osborn", "description": "Student", "powers": ["Armor", "Speed"] }
    When method PUT
    Then status 200
    And match response == { id: '#number', name: 'Marvel Gold Goblin', alterego: 'Boby Osborn', description: 'Student', powers: ['Armor', 'Speed'] }

  @id:5 @ConsultaPersonaje @ConsultarPersonajePorIdValida
  Scenario: T-API-TA.CA05-Consulta de personaje por id exitoso - karate
    And path '1228'
    When method GET
    Then status 200
    And match response == { id: '#number', name: '#string', alterego: '#string', description: '#string', powers: '#[] #string' }

  @id:6 @ConsultaPersonaje @ConsultarPersonajePorIdNoValida
  Scenario: T-API-TA.CA06-Consulta de personaje por id no válido - karate
    And path '99999999'
    When method GET
    Then status 404

  @id:7 @CreacionPersonaje @CreacionPersonajeDuplicado
  Scenario: T-API-TA.CA07-Creación de personaje duplicado - karate
    And request { "name": "Spider Boby 4", "alterego": "Boby", "description": "Student", "powers": ["Armor", "Flight"] }
    When method POST
    Then status 400

  @id:8 @CreacionPersonaje @CreacionPersonajeNoValida
  Scenario: T-API-TA.CA08-Creación de personaje con datos inválidos - karate
    And request { "name": "", "alterego": "", "description": "", "powers": ["", "Flight"] }
    When method POST
    Then status 400

  @id:9 @ActualizaciónPersonaje @ActualizaciónPersonajeNoExistente
  Scenario: T-API-TA.CA09-Actualización de personaje no existente - karate
    And path '9999999'
    And request { "name": "Spider Boby 4", "alterego": "Boby", "description": "Student", "powers": ["Armor", "Flight"] }
    When method PUT
    Then status 404

  @id:10 @EliminaciónPersonaje @EliminaciónDePersonajeNoExistente
  Scenario: T-API-TA.CA10-Eliminación de personaje no existente - karate
    And path '9999999'
    When method DELETE
    Then status 404