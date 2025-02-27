Feature:

  Background:
    * headers headers
    * url url_base
    * path 'booking'

  Scenario: Obetener todos los ids de reservas exitosamente
    * method GET
    Then status 200
    * print response


  Scenario: Obetener reservas por nombre y apellido
    * param fistname = 'Bud'
    * param lastname = 'Wehner'
    * method GET
    Then status 200

  Scenario: Obtener reservas por fecha checkin y fecha checkout
    * param checkin = '2018-05-30'
    * param checkout = '2021-12-24'
    * method GET
    Then status 200
    * print response

  @ConsultaReservaPorId
  Scenario: Obetener reserva por id
    * def id = id
    Given path id
    * method GET
    Then status 200
    * print 'AQUI ESTAMOS EN LA CONSULTA A LA RESERVA'
    * print response





