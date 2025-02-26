package booking.autorizacion;

import com.intuit.karate.junit5.Karate;

public class AutorizacionRunner {

    @Karate.Test
    Karate run(){
        return Karate.run("autorizacion").relativeTo(getClass()).karateEnv("qa");
    }
}
