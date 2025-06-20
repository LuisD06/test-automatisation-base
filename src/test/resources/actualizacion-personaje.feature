@REQ_TA
Feature: TA Automatización de pruebas para aplicación de gestión de personajes de Marvel - Marvel Characters API

  Background:
    * configure ssl = true
    * header Content-Type = 'application/json'
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters'


  @id:1 @ActualizacionPersonaje @ActualizacionDePersonajePorIdValida
  Scenario: T-API-TA.CA04-Actualización de personaje por id exitoso - karate
    And path '1228'
    And request { "name": "Marvel Gold Goblin", "alterego": "Boby Osborn", "description": "Student", "powers": ["Armor", "Speed"] }
    When method PUT
    Then status 200
    And match response == { id: '#number', name: 'Marvel Gold Goblin', alterego: 'Boby Osborn', description: 'Student', powers: ['Armor', 'Speed'] }


  @id:2 @ActualizacionPersonaje @ActualizacionPersonajeNoExistente
  Scenario: T-API-TA.CA09-Actualización de personaje no existente - karate
    And path '9999999'
    And request { "name": "Spider Boby 4", "alterego": "Boby", "description": "Student", "powers": ["Armor", "Flight"] }
    When method PUT
    Then status 404

    @id:3 @ActualizacionPersonaje @ActualizacionDePersonajeConDatosInvalidos
    Scenario Outline: T-API-TA.CA11-Actualización de personaje con datos inválidos - karate
    And path '1228'
    And request { "name": "<name>", "alterego": "<alterego>", "description": "<description>", "powers": <powers> }
    When method PUT
    Then status 400
      Examples:
        | read('classpath:../data/personajes-no-validos.json') |


