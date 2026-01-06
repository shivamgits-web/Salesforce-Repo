public class AccountHandlerController {
    
    @InvocableMethod(label='Create Contact Record')
    Public static void createContact(List<Id> recordId){
        Set<Id> accountId =new Set<Id>(recordId);
        createContactRecord(accountId);
        
    }
    
    public static void createContactRecord(Set<Id> accIds) {
        if (accIds == null || accIds.isEmpty()) return;
        
        List<Contact> contactsToInsert = new List<Contact>();
        
        for (Id accId : accIds) {
            contactsToInsert.add(new Contact(
                AccountId = accId,
                LastName = 'REST Contact New'
            ));
        }
        system.debug('contactsToInsert -->>'+contactsToInsert);
        insert contactsToInsert;
        system.debug('Inserted Id'+contactsToInsert);
    }
    
    
}