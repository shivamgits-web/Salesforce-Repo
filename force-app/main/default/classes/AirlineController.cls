public with sharing class AirlineController {
    @AuraEnabled
    public static void saveAirline(String name, Id contactId) {
        Air_Lines__c airline = new Air_Lines__c(
            Name = name,
            Contact__c = contactId
        );
        insert airline;
    }
}