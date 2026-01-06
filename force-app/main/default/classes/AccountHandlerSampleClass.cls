public class AccountHandlerSampleClass {
    
    @AuraEnabled(cacheable=true) 
    public static List<Opportunity> accountList(Id AccountId){
        
        List<Opportunity> oppList=[select Id, AccountId, Name, Account.Name from Opportunity where AccountId =: AccountId];
        return oppList;
    }

}