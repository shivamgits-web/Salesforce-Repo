public class NumberChecker {
    
    public static String checkEvenOdd(Integer int1){
        String str1 = 'Number is Even';
        String str2 = 'Number is Odd';
        
        if(Math.mod(int1, 2) == 0){
            return str1;
        }
        else
        {
         return str2;   
        }
           
    }

}