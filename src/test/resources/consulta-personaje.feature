@REQ_TA
Feature: TA Automatización de pruebas para creacion de personajes de Marvel - Marvel Characters API

  Background:
    * configure ssl = true
    * header Content-Type = 'application/json'
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters'

  @id:1 @ConsultaPersonaje @ConsultarPersonajesValida
  Scenario: T-API-TA.CA01-Respuesta exitosa - karate
    When method GET
    Then status 200
    And match response == '#[]'
    And match each response == { id: '#number', name: '#string', alterego: '#string', description: '#string', powers: '#[] #string' }

  @id:2 @ConsultaPersonaje @ConsultarPersonajePorIdValida
  Scenario: T-API-TA.CA05-Consulta de personaje por id exitoso - karate
    And path '1228'
    When method GET
    Then status 200
    And match response == { id: '#number', name: '#string', alterego: '#string', description: '#string', powers: '#[] #string' }

  @id:3 @ConsultaPersonaje @ConsultarPersonajePorIdNoValida
  Scenario: T-API-TA.CA06-Consulta de personaje por id no válido - karate
    And path '99999999'
    When method GET
    Then status 404