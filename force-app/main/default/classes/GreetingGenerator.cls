public class GreetingGenerator {
    public static String generateGreeting(Integer CurrentHour){
        
        String str1 = 'Morning';
        String str2 = 'Afternoon';
        String str3 = 'Evening';
        String str4 = 'Invalid Timing';
        
        
        if(CurrentHour >= 0 && CurrentHour <= 12){
            return str1;
        }else if(CurrentHour > 12 && CurrentHour <= 18){
            return str2;
        }else if(CurrentHour > 18 && CurrentHour <= 24){
            return str3;
        }else{
            return str4;
        }
            
        
    }

}

//String StrN = GreetingGenerator.generateGreeting(23);
//system.debug('Good'+' '+StrN+' '+'All !');