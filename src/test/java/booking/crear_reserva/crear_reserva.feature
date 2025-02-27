Feature:

  Background:
    * headers headers
    * url url_base
    * path 'booking'
    * def informacion_random = Java.type('utilidades.DatosRandom')


    @CrearReservaExitosa
  Scenario:
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

    * method POST
    Then status 200
      * print 'AQUI ESTAMOS EN LA CREACION DE LA RESERVA'
    * print response
    And match response == body_response_schema
    And match response.booking == body_request








