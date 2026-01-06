public class AccountRecordHandlerClass {
    // Make the all contact Active
    public static void contactInsert(List<Contact> conList){
        
        Map<Id, List<Contact>> contactMap=new Map<Id, List<Contact>>(); 
        for(Contact con: conlist){
            if(!contactMap.containsKey(con.AccountId)){
                 contactMap.put(con.AccountId, new List<Contact>());
            }
            contactMap.get(con.AccountId).add(con);
        }
        system.debug('contactMap-->>'+contactMap);
        for(Id acId : contactMap.KeySet()){
            List<Contact> listContactForAccountId = contactMap.get(acId);
            Integer count = 0;
            for(Contact con: listContactForAccountId){
                if(count < 2 && con.createdDate < system.Now().addDays(-7)){
                  con.IsActive__c = true;
                  count++;
                }
            } 
        }
        
    }
}