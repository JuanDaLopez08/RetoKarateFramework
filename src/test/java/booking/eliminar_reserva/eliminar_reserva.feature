Feature:

  Background:
    * headers headers
    * def token = karate.callSingle('classpath:utilidades/crear_token_autorizacion.feature')
    * header Cookie = 'token=' + token.response.token
    * url url_base
    * def crear_reserva = call read('classpath:booking/crear_reserva/crear_reserva.feature@CrearReservaExitosa')


  @EliminarReservaPorId
  Scenario: Eliminar una reserva exitosamente
    * def id_respuesta = crear_reserva.response.bookingid
    * def id_reserva = typeof  id !== 'undefined' ? id : id_respuesta
    Given path 'booking'
    And path id_reserva
    When method DELETE
    Then status 201
    And match response == 'Created'


  @EliinarUnaReserva&Buscarla
  Scenario: Eliminar una reserva y buscar si se elimino correctamente
    * def id = crear_reserva.response.bookingid
    Given path 'booking'
    And path id
    When method DELETE
    Then status 201
    And match response == 'Created'
    * def buscar_reserva = karate.call('classpath:booking/consultar_reserva/consultar_reserva.feature@ConsultarIdRervaEliminada', {id:id})


  @ElimianarUnaReservaInexistente
  Scenario: Buscar una reserva que no existe
    * def id = crear_reserva.response.bookingid
    * def eliminar_reserva = karate.call('classpath:booking/eliminar_reserva/eliminar_reserva.feature@EliminarReservaPorId', {id:id})
    Given path 'booking'
    And path id
    When method DELETE
    Then status 405
    And match response == 'Method Not Allowed'
