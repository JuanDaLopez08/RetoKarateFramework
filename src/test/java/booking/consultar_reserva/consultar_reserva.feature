Feature:Pruebas de la api para consultar reservas

  Background:
    * headers headers
    * url url_base
    * path 'booking'
   * def crear_reserva = call read('classpath:booking/crear_reserva/crear_reserva.feature@CrearReservaExitosa')

  @ObtenerTodasLasReservas
  Scenario: Obetener todos los identificadores de las reservas exitosamente
    * method GET
    Then status 200
    And match response == "#array"
    * def reservas = response
    * if(reservas.length > 0) karate.match(reservas[0].bookingid, '#number')


  @ObtenerReservaPorNombre&Apellido
  Scenario: Obetener todod los identificadores de las reservas por nombre y apellido exitosamente
    * def nombre = crear_reserva.response.booking.firstname
    * def apellido = crear_reserva.response.booking.lastname
    * param fistname = nombre
    * param lastname = apellido
    * method GET
    Then status 200
    And match response == "#array"
    And match response[0].bookingid == "#number"


  @ObtenerReservaPorFechaCheckin&Chechout
  Scenario: Obtener reservas por fecha checkin y fecha checkout
    * def checkin = crear_reserva.response.booking.bookingdates.checkin
    * def checkout = crear_reserva.response.booking.bookingdates.checkout
    * param checkin = checkin
    * param checkout = checkout
    * method GET
    Then status 200
    And match response == "#array"
    And match response[0].bookingid == "#number"


  @ConsultaReservaPorId
  Scenario: Obetener reserva por identificador unico de reserva
    * def id_respuesta = crear_reserva.response.bookingid
    * def id_reserva = typeof  id !== 'undefined' ? id : id_respuesta
    Given path id_reserva
    * method GET
    Then status 200
    And match response == "#object"
    And match response.firstname == crear_reserva.response.booking.firstname
    And match response.lastname == crear_reserva.response.booking.lastname
    And match response.totalprice == crear_reserva.response.booking.totalprice
    And match response.depositpaid == crear_reserva.response.booking.depositpaid
    And match response.bookingdates.checkin == crear_reserva.response.booking.bookingdates.checkin
    And match response.bookingdates.checkout == crear_reserva.response.booking.bookingdates.checkout
    And match response.additionalneeds == crear_reserva.response.booking.additionalneeds

  @ConsultarReservaPorId
  Scenario: Obetener reserva por identificador unico de reserva y validacion de tipo de dato
    * def id_respuesta = crear_reserva.response.bookingid
    * def id_reserva = typeof  id !== 'undefined' ? id : id_respuesta
    Given path id_reserva
    * method GET
    Then status 200
    And match response == "#object"


  @ConsultarIdRervaEliminada
  Scenario: Consultar una reserva cuando ya fue eliminada
    * def id_respuesta = crear_reserva.response.bookingid
    * def id_reserva = typeof  id !== 'undefined' ? id : id_respuesta
    * def eliminar_reserva = karate.call('classpath:booking/eliminar_reserva/eliminar_reserva.feature@EliminarReservaPorId', {id:id_respuesta})
    * path id_reserva
    * method GET
    Then status 404
    And match response == "Not Found"




