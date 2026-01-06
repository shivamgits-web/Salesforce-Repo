public with sharing class GlobalLookupController {
    @AuraEnabled(cacheable=true)
    public static List<sObject> searchRecords(String searchKey) {
        searchKey = '%' + searchKey + '%';
        
        List<Account> accList = [
            SELECT Id, Name 
            FROM Account 
            WHERE Name LIKE :searchKey 
            LIMIT 10
        ];
        
        List<Lead> leadList = [
            SELECT Id, Name, Company 
            FROM Lead 
            WHERE Name LIKE :searchKey OR Company LIKE :searchKey
            LIMIT 10
        ];
        
        // Merge both
        List<sObject> finalList = new List<sObject>();
        finalList.addAll(accList);
        finalList.addAll(leadList);
        return finalList;
    }
}