Feature:

  Background:
    * headers headers
    * url url_base

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