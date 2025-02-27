package booking.actualizar_reserva;

import com.intuit.karate.junit5.Karate;

public class ActualizarReservaRunner {

    @Karate.Test
    Karate run() {
        return Karate.run("actualizar_reserva").relativeTo(getClass()).karateEnv("qa");
    }
}
