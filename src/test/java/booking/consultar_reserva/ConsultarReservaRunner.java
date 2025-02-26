package booking.consultar_reserva;

import com.intuit.karate.junit5.Karate;

public class ConsultarReservaRunner {
    @Karate.Test
    Karate run(){
        return Karate.run("consultar_reserva").relativeTo(getClass()).karateEnv("qa");
    }
}
