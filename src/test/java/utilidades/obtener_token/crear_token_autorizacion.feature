Feature:Obtener autorizacion para utilizar las apis de actualizar y eliminar

  Background:
    * headers headers
    * url url_base

  @ignore
  Scenario: Obtener token para consumir apis
    Given path 'auth'
    * def body = read("classpath:utilidades/obtener_token/BodyRequestCredentials.json")
    And request body
    When method POST
    Then status 200
    And match response.token == "#string"