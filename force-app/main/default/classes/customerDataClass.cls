public class customerDataClass {

    @AuraEnabled(cacheable=true)
    public static List<Customer__c> searchCustomers(String customerName, Integer minAge, Integer maxAge) {
        String cumlist = 'SELECT Name, Age__c, Industry__c, Region__c FROM Customer__c WHERE Name LIKE :customerName';
        if (minAge != null) {
            cumlist += ' AND Age__c >= :minAge';
        }
        if (maxAge != null) {
            cumlist += ' AND Age__c <= :maxAge';
        }
        return Database.query(cumlist);
    }

}