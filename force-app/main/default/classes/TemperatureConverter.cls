public class TemperatureConverter {
    
    public static Decimal convertCelsiusToFahrenheit(Decimal Celsius){
        
        Decimal Fahrenheit = (Celsius * 9/5) + 32;
        
        return Fahrenheit;
        
    }

}