public class customerClass {

    @AuraEnabled(cacheable=true)
    public static List<Customer__c> displayCustomerByAge(List<Customer__c> Customers,Integer searchItem, Integer minAge, Integer maxAge){
        List<customer__c> customerList=new List<Customer__c>();
        
        for(Customer__c c:Customers){
            if((minAge == null || c.Age__c < minAge) && (maxAge != null && c.Age__c <= 30)){
            String key='%'+searchItem+'%';
            customerList=[select name,Age__c,Region__c,Industry__c from Customer__c where Name like:key];
        }
            else{
            customerList=[select name,Age__c,Region__c,Industry__c from Customer__c];
               }
               
            if((minAge != null && maxAge == null && c.Age__c > 15)){
            String key='%'+searchItem+'%';
            customerList=[select name,Age__c,Region__c,Industry__c from Customer__c where Name like:key];
        }
            else{
            customerList=[select name,Age__c,Region__c,Industry__c from Customer__c];
               }
               
             if((minAge != null && maxAge != null && c.Age__c >= minAge && c.Age__c <= maxAge)){
            String key='%'+searchItem+'%';
            customerList=[select name,Age__c,Region__c,Industry__c from customer__c where Name like:key];
        }
            else{
            customerList=[select name,Age__c,Region__c,Industry__c from Customer__c];
               }
             
        }
        return customerList;
    }
}