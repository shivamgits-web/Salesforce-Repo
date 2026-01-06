public class StringReverserClass {
    
    public static string reverseString(String stg){
        
        string reversedString = '';
        for(Integer i=stg.length()-1;i>=0;i--){
             reversedString += stg.substring(i, i + 1);
        }
        system.debug('Reverse String '+reversedString);
        return reversedString;
    }

}