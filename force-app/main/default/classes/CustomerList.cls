public class CustomerList {

    @AuraEnabled(cacheable=true)
    public static list<Customer__c> custmlist(String keyword){
        String searchKey = '%' + keyword + '%';
        return [SELECT Id, Name, Email__c, Phone_Number__c FROM Customer__c where Name LIKE :searchKey];      
    }
    
    @AuraEnabled(cacheable=true)
    public static List<Customer__c> searchRecords(String searchTerm, String industry, String region) {
        String searchKey = '%' + searchTerm + '%';
        String industryQuery = String.isNotBlank(industry) ? 'AND Industry__c = :industry' : '';
        String regionQuery = String.isNotBlank(region) ? 'AND Region__c = :region' : '';
        String queryString = 'SELECT Id, Name, Phone_Number__c, Industry__c, Region__c FROM Customer__c WHERE Name LIKE :searchKey ' + industryQuery + ' ' + regionQuery;
        return Database.query(queryString);
    }

    
   @AuraEnabled(cacheable=true)
    public static List<Customer__c> searchCustomers(String customerName, Integer minAge, Integer maxAge) {
        String cumlist = 'SELECT Name, Age__c, Industry__c, Region__c FROM Customer__c WHERE Name LIKE :customerName';
        if (minAge != null) {
            cumlist += ' AND Age__c >= :minAge';
        }
        if (maxAge != null) {
            cumlist += ' AND Age__c <= :maxAge';
        }
        System.debug('Search Customer Returns'+Database.query(cumlist));
        return Database.query(cumlist);

    }


}