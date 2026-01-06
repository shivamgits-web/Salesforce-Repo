public class oppLWC {
    // For Wire Method
    @AuraEnabled(cacheable=true)
    public static List<opportunity> opplist(){
        return [SELECT Id, AccountId, Name, Description, StageName, Amount, Type FROM Opportunity LIMIT 5];
    }
    
    // For Imperative Method
    @AuraEnabled(cacheable=true)
    public static List<opportunity> oppImp(String oppName){
        return [SELECT Id, AccountId, Name, Description, StageName, Amount, Type FROM Opportunity where Name =:oppName LIMIT 5];
    }

     // For Combobox
    @AuraEnabled(cacheable=true)
    public static List<Account> comName(){
        return [SELECT Id,Name FROM Account LIMIT 5];
    }

    @AuraEnabled(cacheable=true)
    public static List<Contact> contactData(Id accId){
        return [SELECT Id, Name, Phone FROM Contact where AccountId =:accId LIMIT 5];
    }




}