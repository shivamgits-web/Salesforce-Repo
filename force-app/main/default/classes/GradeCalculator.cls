public class GradeCalculator {
    
    public static String calculateGrade(Integer Markrs){
        String str1 = 'Grade is A';
        String str2 = 'Grade is B';
        String str3 = 'Grade is C';
        String str4 = 'Grade is D';
        String str5 = 'Grade is F';
        String str6 = 'Marks can not be greater than 90';
        
        if(Markrs >= 90 && Markrs <= 100){
            return str1;
        }
        else if(Markrs<90 && Markrs >=80){
            return str2;
        }
        else if(Markrs<80 && Markrs >=70){
            return str3;
        }
        else if(Markrs<70 && Markrs >=60){
            return str4;
        }
        else if(Markrs > 100){
            return str6;
        }
        else{
            return str5;
        }
        
        
    }

}