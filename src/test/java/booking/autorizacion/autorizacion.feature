Feature:

  Background:
    * url url_base
    * header Content-Type = 'application/json'

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
    * print response