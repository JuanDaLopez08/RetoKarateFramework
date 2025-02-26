package booking.crear_reserva;

import com.intuit.karate.junit5.Karate;

public class CrearReservaRunner {
    @Karate.Test
    Karate run() {
        return Karate.run("crear_reserva").relativeTo(getClass()).karateEnv("qa");
    }
}
