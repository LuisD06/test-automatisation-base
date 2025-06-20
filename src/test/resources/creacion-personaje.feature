@REQ_TA
Feature: TA Automatización de pruebas para creacion de personajes de Marvel - Marvel Characters API

  Background:
    * configure ssl = true
    * header Content-Type = 'application/json'
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters'

  @id:1 @CreacionPersonaje @CreacionDePersonajeValida
  Scenario: T-API-TA.CA02-Creación de personaje exitoso - karate
    And request { "name": "Spider Boby 4", "alterego": "Boby", "description": "Student", "powers": ["Armor", "Flight"] }
    When method POST
    Then status 201
    And match response == { id: '#number', name: 'Spider Boby 4', alterego: 'Boby', description: 'Student', powers: ['Armor', 'Flight'] }

  @id:2 @CreacionPersonaje @CreacionPersonajeDuplicado
  Scenario: T-API-TA.CA07-Creación de personaje duplicado - karate
    And request { "name": "Spider Boby 4", "alterego": "Boby", "description": "Student", "powers": ["Armor", "Flight"] }
    When method POST
    Then status 400

  @id:3 @CreacionPersonaje @CreacionPersonajeNoValida
  Scenario Outline: T-API-TA.CA08-Creación de personaje con datos inválidos - karate
    And request { "name": "<name>", "alterego": "<alterego>", "description": "<description>", "powers": <powers> }
    When method POST
    Then status 400
    Examples:
      | name   | alterego | description | powers                 |
      |        |          |             | ["", "Flight"]         |
      | Test   |          | desc        | ["Invisibility"]       |
      |        | Test     |             | ["", "Super Strength"] |
      | Test   | Test     | test        | []                     |