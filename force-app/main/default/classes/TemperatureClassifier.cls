public class TemperatureClassifier {
    public Static String classifyTemperature(Decimal Temp){
        
        String str1 = 'Cold';
        String str2 = 'Moderate';
        String str3 = 'Hot';
        
        if(Temp < 10 ){
            return str1;
        }else if(Temp > 10 && Temp < 29){
            return str2;
        }else{
            return str3;
        }
        
    }
}

//String Tempt = TemperatureClassifier.classifyTemperature(30);
//system.debug('Tempreture is '+ Tempt);