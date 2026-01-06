public class accountLWC {
    
    @AuraEnabled(cacheable=true)
    public static list<Account> acclist(String accName){
        return [SELECT Id, Name, Type, Phone FROM Account where Name=:accName];
    }

}