public class accountControllerForLWC {

    @AuraEnabled(cacheable=true)
    public static List<Account> fetchAccount(){
        return [select Id,Name,Rating, Industry,Type from Account LIMIT 5];
    }

     @AuraEnabled(cacheable=true)
    public static List<Account> fetchAccountByType(String accType){
        return [select Id,Name,Rating, Industry, Type from Account where type =: accType];
    }



}