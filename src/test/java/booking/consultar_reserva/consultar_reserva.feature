Feature:

  Background:
    * url url_base
    * header Accept = 'application/json'

  Scenario:
    * method GET
    Then status 200
    * print response


  Scenario:
    * param fistname = 'Josh'
    * param lastname = 'Allen'
    * method GET
    Then status 200

  Scenario:
    * param checkin = '2018-01-01'
    * param checkout = '2019-01-01'
    * method GET
    Then status 200
    * print response

  @Prueba
  Scenario:
    Given path '61'
    * method GET
    Then status 200
    * print response





