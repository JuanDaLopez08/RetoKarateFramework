Feature:

  Background:
    * url url_base
    * header Accept = 'application/json'
    * header Content-Type = 'application/json'
    * def informacion_random = Java.type('utilidades.DatosRandom')


  Scenario:
    * def nombre = informacion_random.nombreRandom()
    * def apellido = informacion_random.apellidoRandom()
    * def precio_total = informacion_random.precioRandom()
    * def pago_depositado = informacion_random.pagoDepositadoRandom()
    * def fecha_inicio = informacion_random.fechaRandom(2018,2019)
    * def fecha_final = informacion_random.fechaRandom(2020,2024)
    * def adicion = informacion_random.adicionales()
    And request
    """
    {
      "firstname":"#(nombre)",
      "lastname":"#(apellido)",
      "totalprice":"#(precio_total)",
      "depositpaid":"#(pago_depositado)",
      "bookingdates":{
        "checkin":"#(fecha_inicio)",
        "checkout":"#(fecha_final)"
      },
      "additionalneeds":"#(adicion)"
    }
    """
    * method POST
    Then status 200
    * print response
    And match response.bookingid == "#number"
    And match response.booking == "#object"
    And match response.booking.firstname == "#string"
    And match response.booking.firstname == "#(nombre)"
    And match response.booking.lastname == "#string"
    And match response.booking.lastname == "#(apellido)"
    And match response.booking.totalprice == "#number"
    And match response.booking.totalprice == "#(precio_total)"
    And match response.booking.depositpaid == "#boolean"
    And match response.booking.depositpaid == "#(pago_depositado)"
    And match response.booking.bookingdates == "#object"
    And match response.booking.bookingdates.checkin == "#regex ^\\d{4}-\\d{2}-\\d{2}$"
    And match response.booking.bookingdates.checkin == "#(fecha_inicio)"
    And match response.booking.bookingdates.checkout == "#regex ^\\d{4}-\\d{2}-\\d{2}$"
    And match response.booking.bookingdates.checkout == "#(fecha_final)"
    And match response.booking.additionalneeds == "#string"
    And match response.booking.additionalneeds == "#(adicion)"



