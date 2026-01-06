public with sharing class LookupSearchController {
    @AuraEnabled(cacheable=true)
    public static List<sObject> searchRecords(String objectName, String fieldName, String searchKey) {
        String soql = 'SELECT Id, ' + fieldName + ' FROM ' + objectName + 
                      ' WHERE ' + fieldName + ' LIKE :(\'%' + searchKey + '%\') LIMIT 10';
        return Database.query(soql);
    }
}