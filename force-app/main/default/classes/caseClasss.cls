public class caseClasss {
    @AuraEnabled(cacheable=true)
    public static List<Case> caseList(Id AccountId){
        
        return[select id,isSunday__c,isTuesday__c,Status from Case where AccountId =: AccountId];
        
    }

}