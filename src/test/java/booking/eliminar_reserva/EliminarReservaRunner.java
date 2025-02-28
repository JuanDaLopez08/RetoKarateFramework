package booking.eliminar_reserva;

import com.intuit.karate.junit5.Karate;

public class EliminarReservaRunner {

    @Karate.Test
    Karate run(){
        return Karate.run("eliminar_reserva").relativeTo(getClass()).karateEnv("qa");
    }
}
