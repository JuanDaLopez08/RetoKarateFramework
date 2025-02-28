Feature:Pruebas de la api de reservas

Yo como usuario del sistema
Quiero consumir la API de reservas
Para generar reservas de manera eficiente y validar su funcionamiento

  Background:
    Given headers headers
    * url url_base
    * path 'booking'
    And def informacion_random = Java.type('utilidades.DatosRandom')

  @CrearReservaExitosa
  Scenario: Crear un reserva de manera exitosa
    * def nombre = informacion_random.nombreRandom()
    * def apellido = informacion_random.apellidoRandom()
    * def precio_total = informacion_random.precioRandom()
    * def pago_depositado = informacion_random.pagoDepositadoRandom()
    * def fecha_inicio = informacion_random.fechaRandom(2018,2019)
    * def fecha_final = informacion_random.fechaRandom(2020,2024)
    * def adicion = informacion_random.adicionales()
    * def body_request = read("classpath:booking/crear_reserva/BodyRequest.json")
    * def body_response_schema = read("classpath:booking/crear_reserva/BodyResponseSchema.json")
    And request body_request

    When method POST
    Then status 200
    And match response == body_response_schema
    And match response.booking == body_request


  @CrearReservaConCampoFaltante
  Scenario Outline: Crear reserva cuando falta un campo obligatorio en el request
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
    And path 'booking'
    And request body_request
    When method POST
    Then status 404

    Examples:
      | requestBody                                                                                                                                                                                                      |
      | { "lastname": "#(apellido)", "totalprice": #(precio_total), "depositpaid": #(pago_depositado), "bookingdates": { "checkin": "#(fecha_inicio)", "checkout": "#(fecha_final)" }, "additionalneeds": "#(adicion)" } |
      | { "firstname": "#(nombre)", "totalprice": #(precio_total), "depositpaid": #(pago_depositado), "bookingdates": { "checkin": "#(fecha_inicio)", "checkout": "#(fecha_final)" }, "additionalneeds": "#(adicion)" }  |
      | { "firstname": "#(nombre)", "lastname": "#(apellido)", "depositpaid": #(pago_depositado), "bookingdates": { "checkin": "#(fecha_inicio)", "checkout": "#(fecha_final)" }, "additionalneeds": "#(adicion)" }      |
      | { "firstname": "#(nombre)", "lastname": "#(apellido)", "totalprice": #(precio_total), "bookingdates": { "checkin": "#(fecha_inicio)", "checkout": "#(fecha_final)" }, "additionalneeds": "#(adicion)" }          |
      | { "firstname": "#(nombre)", "lastname": "#(apellido)", "totalprice": #(precio_total), "depositpaid": #(pago_depositado), "additionalneeds": "#(adicion)" }                                                       |
      | { "firstname": "#(nombre)", "lastname": "#(apellido)", "totalprice": #(precio_total), "depositpaid": #(pago_depositado), "bookingdates": { "checkout": "#(fecha_final)" }, "additionalneeds": "#(adicion)" }     |
      | { "firstname": "#(nombre)", "lastname": "#(apellido)", "totalprice": #(precio_total), "depositpaid": #(pago_depositado), "bookingdates": { "checkin": "#(fecha_inicio)" }, "additionalneeds": "#(adicion)" }     |
      | { "firstname": "#(nombre)", "lastname": "#(apellido)", "totalprice": #(precio_total), "depositpaid": #(pago_depositado), "bookingdates": { "checkin": "#(fecha_inicio)", "checkout": "#(fecha_final)" } }        |




