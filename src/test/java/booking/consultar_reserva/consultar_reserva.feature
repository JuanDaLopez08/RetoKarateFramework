Feature:Pruebas de la api para consultar reservas por parámetros como id, nombre y apellido o fechas

  Yo como usuario del sistema
  Quiero consumir la API de reservas
  Para consultar la información de las reservas de manera eficiente

  Background:
    Given headers headers
    * url url_base
    * path 'booking'
    * def crear_reserva = call read('classpath:booking/crear_reserva/crear_reserva.feature@CrearReservaExitosa')


  @ObtenerTodasLasReservas
  Scenario: Obtener todos los identificadores de las reservas exitosamente
    When method GET
    Then status 200
    And match response == "#array"
    * def reservas = response
    * if(reservas.length > 0) karate.match(reservas[0].bookingid, '#number')


  @ObtenerReservaPorNombre&Apellido
  Scenario: Obtener todos los identificadores de las reservas por nombre y apellido exitosamente
    * def nombre = crear_reserva.response.booking.firstname
    * def apellido = crear_reserva.response.booking.lastname
    * param fistname = nombre
    * param lastname = apellido
    When method GET
    Then status 200
    And match response == "#array"
    And match response[0].bookingid == "#number"


  @ObtenerReservaPorFechaCheckin&Chechout
  Scenario: Obtener reservas por fecha check in y fecha check out
    * def checkin = crear_reserva.response.booking.bookingdates.checkin
    * def checkout = crear_reserva.response.booking.bookingdates.checkout
    * param checkin = checkin
    * param checkout = checkout
    When method GET
    Then status 200
    And match response == "#array"
    And match response[0].bookingid == "#number"


  @ConsultaReservaPorId
  Scenario: Obtener reserva por identificador único de reserva
    * def id_respuesta = crear_reserva.response.bookingid
    * def id_reserva = typeof  id !== 'undefined' ? id : id_respuesta
    And path id_reserva
    When method GET
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
  Scenario: Obtener reserva por identificador único de reserva y validación de tipo de dato
    * def id_respuesta = crear_reserva.response.bookingid
    * def id_reserva = typeof  id !== 'undefined' ? id : id_respuesta
    And path id_reserva
    When method GET
    Then status 200
    And match response == "#object"


  @ConsultarIdRervaEliminada
  Scenario: Consultar una reserva cuando ya fue eliminada
    * def id_respuesta = crear_reserva.response.bookingid
    * def id_reserva = typeof  id !== 'undefined' ? id : id_respuesta
    * def eliminar_reserva = karate.call('classpath:booking/eliminar_reserva/eliminar_reserva.feature@EliminarReservaPorId', {id:id_respuesta})
    * path id_reserva
    When method GET
    Then status 404
    And match response == "Not Found"




