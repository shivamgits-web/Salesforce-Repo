public class LWCInlineCtrl {
    
    @AuraEnabled
    public static List<Contact> getContacts() {
        return [SELECT Id, Name, FirstName, LastName, Phone, Email 
                FROM Contact 
                limit 20];
    }
    
}