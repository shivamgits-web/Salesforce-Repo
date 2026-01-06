public with sharing class AccountLookupController {
    @AuraEnabled(cacheable=true)
    public static List<Account> searchAccounts(String searchKey) {
        String likeKey = '%' + searchKey + '%';
        return [
            SELECT Id, Name 
            FROM Account 
            WHERE Name LIKE :likeKey 
            ORDER BY Name 
            LIMIT 10
        ];
    }
}