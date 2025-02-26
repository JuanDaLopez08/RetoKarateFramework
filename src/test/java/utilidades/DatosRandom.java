package utilidades;

import net.datafaker.Faker;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.Random;

public class DatosRandom {
    static Faker faker = new Faker();

    public static String nombreRandom() {
        return faker.name().firstName();
    }

    public static String apellidoRandom() {
        return faker.name().lastName();
    }

    public static int precioRandom() {
        int numero = faker.random().nextInt();
        return numero < 0 ? -numero : numero;
    }

    public static boolean pagoDepositadoRandom() {
        return faker.random().nextBoolean();
    }

    public static String fechaRandom(int anoInicial, int anoFinal) {
        LocalDate fechaInicio = LocalDate.of(anoInicial, 1, 1);
        LocalDate fechaFin = LocalDate.of(anoFinal, 1, 1);

        long diasEntreFechas = ChronoUnit.DAYS.between(fechaInicio, fechaFin);

        Random random = new Random();
        long diasAleatorios = random.nextLong(diasEntreFechas + 1);

        LocalDate fechaAleatoria = fechaInicio.plusDays(diasAleatorios);

        return fechaAleatoria.toString();
    }

    public static String adicionales(){
        return faker.text().text(10);
    }
}
