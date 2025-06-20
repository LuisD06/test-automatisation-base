@REQ_TA
Feature: TA Automatización de pruebas para eliminación de personajes de Marvel - Marvel Characters API

  Background:
    * configure ssl = true
    * header Content-Type = 'application/json'
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters'


  @id:1 @EliminacionPersonaje @EliminacionDePersonajePorIdValida
  Scenario: T-API-TA.CA03-Eliminación de personaje por id exitoso - karate
    And path '2734'
    When method DELETE
    Then status 204

  @id:2 @EliminacionPersonaje @EliminacionDePersonajeNoExistente
  Scenario: T-API-TA.CA10-Eliminación de personaje no existente - karate
    And path '9999999'
    When method DELETE
    Then status 404