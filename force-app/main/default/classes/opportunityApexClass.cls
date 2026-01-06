public class opportunityApexClass {
    
	// For Wire Method
	@AuraEnabled(cacheable=true)
    public static List<opportunity> oppListRecord(){
        return [SELECT Id, AccountId, Name, Description, StageName, Amount, Type FROM Opportunity LIMIT 5];
    }

    // For Imperative Method
	@AuraEnabled
    public static List<opportunity> getAccount(String oppName){
        return [SELECT Id, AccountId, Name, Description, StageName, Amount, Type FROM Opportunity where Name =:oppName];
    }




}