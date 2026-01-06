public with sharing class AccountHospitalController {
    @AuraEnabled
    public static void updateAccountHospital(Id accountId, Id hospitalId) {
        if (accountId == null) {
            throw new AuraHandledException('Account Id is required.');
        }

        Account acc = [SELECT Id, Hospital_1__c FROM Account WHERE Id = :accountId LIMIT 1];
        acc.Hospital_1__c = hospitalId;
        update acc;
    }
}