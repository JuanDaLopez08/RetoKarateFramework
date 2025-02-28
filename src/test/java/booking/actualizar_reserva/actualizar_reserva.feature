Feature:Pruebas de la api para la actualización de reservas con todos los parámetros o parámetros parciales

  Yo como usuario del sistema
  Quiero consumir la API de reservas
  Para actualizar las reservas de manera eficiente y validar su actualización

  Background:
    Given headers headers
    * def token = karate.callSingle('classpath:utilidades/crear_token_autorizacion.feature')
    And header Cookie = 'token=' + token.response.token
    And url url_base
    * def informacion_random = Java.type('utilidades.DatosRandom')
    * def crear_reserva = call read('classpath:booking/crear_reserva/crear_reserva.feature@CrearReservaExitosa')
    * def id = crear_reserva.response.bookingid


  @ActualizarReservaTotal
  Scenario: Actualizar reserva exitosamente
    * def nombre = informacion_random.nombreRandom()
    * def apellido = informacion_random.apellidoRandom()
    * def precio_total = informacion_random.precioRandom()
    * def pago_depositado = informacion_random.pagoDepositadoRandom()
    * def fecha_inicio = informacion_random.fechaRandom(2018,2019)
    * def fecha_final = informacion_random.fechaRandom(2020,2024)
    * def adicion = informacion_random.adicionales()
    * def body_request = read("classpath:booking/crear_reserva/BodyRequest.json")
    And path 'booking/' + id
    And request body_request
    When method PUT
    Then status 200
    And match response == body_request


  @ActualizarReservaParcial
  Scenario: Actualizar una reserva parcialmente con nombre y apellido exitosamente
    * def reserva_inicial = karate.call('classpath:booking/consultar_reserva/consultar_reserva.feature@ConsultarReservaPorId', {id:id})
    * def nombre = informacion_random.nombreRandom()
    * def apellido = informacion_random.apellidoRandom()
    And path 'booking/' + id
    And request
      """
      {
        "firstname": "#(nombre)",
        "lastname": "#(apellido)"
      }
      """
    When method PATCH
    Then status 200
    And match response.firstname == nombre
    And match response.lastname == apellido
    * def reserva_actualizada = karate.call('classpath:booking/consultar_reserva/consultar_reserva.feature@ConsultarReservaPorId', {id:id})
    And match reserva_inicial.response.totalprice == reserva_actualizada.response.totalprice
    And match reserva_inicial.response.depositpaid == reserva_actualizada.response.depositpaid
    And match reserva_inicial.response.bookingdates.checkin == reserva_actualizada.response.bookingdates.checkin
    And match reserva_inicial.response.bookingdates.checkout == reserva_actualizada.response.bookingdates.checkout
    And match reserva_inicial.response.additionalneeds == reserva_actualizada.response.additionalneeds


  @ActualizarReservaConParametroFaltante
  Scenario Outline: Actualización de una reserva cuando falta un parámetro obligatorio
    * def nombre = informacion_random.nombreRandom()
    * def apellido = informacion_random.apellidoRandom()
    * def precio_total = informacion_random.precioRandom()
    * def pago_depositado = informacion_random.pagoDepositadoRandom()
    * def fecha_inicio = informacion_random.fechaRandom(2018,2019)
    * def fecha_final = informacion_random.fechaRandom(2020,2024)
    * def adicion = informacion_random.adicionales()
    * def body_request =
      """
      <requestBody>
      """
    And path 'booking/' + id
    And request body_request
    When method PUT
    Then status 400

    Examples:
      | requestBody                                                                                                                                                                                                      |
      | { "lastname": "#(apellido)", "totalprice": #(precio_total), "depositpaid": #(pago_depositado), "bookingdates": { "checkin": "#(fecha_inicio)", "checkout": "#(fecha_final)" }, "additionalneeds": "#(adicion)" } |
      | { "firstname": "#(nombre)", "totalprice": #(precio_total), "depositpaid": #(pago_depositado), "bookingdates": { "checkin": "#(fecha_inicio)", "checkout": "#(fecha_final)" }, "additionalneeds": "#(adicion)" }  |
      | { "firstname": "#(nombre)", "lastname": "#(apellido)", "depositpaid": #(pago_depositado), "bookingdates": { "checkin": "#(fecha_inicio)", "checkout": "#(fecha_final)" }, "additionalneeds": "#(adicion)" }      |
      | { "firstname": "#(nombre)", "lastname": "#(apellido)", "totalprice": #(precio_total), "bookingdates": { "checkin": "#(fecha_inicio)", "checkout": "#(fecha_final)" }, "additionalneeds": "#(adicion)" }          |
      | { "firstname": "#(nombre)", "lastname": "#(apellido)", "totalprice": #(precio_total), "depositpaid": #(pago_depositado), "additionalneeds": "#(adicion)" }                                                       |
      | { "firstname": "#(nombre)", "lastname": "#(apellido)", "totalprice": #(precio_total), "depositpaid": #(pago_depositado), "bookingdates": { "checkout": "#(fecha_final)" }, "additionalneeds": "#(adicion)" }     |
      | { "firstname": "#(nombre)", "lastname": "#(apellido)", "totalprice": #(precio_total), "depositpaid": #(pago_depositado), "bookingdates": { "checkin": "#(fecha_inicio)" }, "additionalneeds": "#(adicion)" }     |