Feature:Obtener autorizacion para utilizar las apis de actualizar y eliminar

  Background:
    * headers headers
    * url url_base

  @ignore
  Scenario:
    Given path 'auth'
    * request
      """
      {
        "username" : "admin",
        "password" : "password123"
      }
      """
    * method POST
    Then status 200
    And match response.token == "#string"