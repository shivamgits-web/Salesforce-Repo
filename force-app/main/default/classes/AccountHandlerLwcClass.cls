public class AccountHandlerLwcClass {
    @AuraEnabled
    public static void createAccountContactCase(String accountNm, String emailAddress, String priority){
        
        if(accountNm != null && emailAddress != null && priority != null){
            
            system.debug('Email'+emailAddress);
            
            Account acc=new Account(Name = accountNm);
            insert acc;
            
            Contact con=new Contact(LastName = accountNm, Email=emailAddress, AccountId = acc.Id);
            insert con;
            
            Case cs=new Case(Priority = priority, accountId = acc.Id, ContactId = con.Id);
            insert cs;
        }
        
    }
    
    @AuraEnabled(cacheable=true)
    public static List<Account> accountList(){
        
        return [select Id,Name, Rating from Account LIMIT 10];
    }
    
    /*@AuraEnabled
public static void updateAccounts(String updatedValue) {
try {
List<Account> accList = (List<Account>) JSON.deserialize(updatedValue, List<Account>.class);
if (accList != null && !accList.isEmpty()) {
update accList;
}
} catch (Exception e) {
throw new AuraHandledException('Failed to update records: ' + e.getMessage());
}
}*/
    
    public class AccountWrapper {
        @AuraEnabled public String Id;
        @AuraEnabled public String Name;
        @AuraEnabled public String Rating;
    }
    
    @AuraEnabled
    public static void updateAccounts(String updatedValue) {
        try {
            List<AccountWrapper> wrapperList = (List<AccountWrapper>) JSON.deserialize(updatedValue, List<AccountWrapper>.class);
            
            Set<Id> accountIds = new Set<Id>();
            for (AccountWrapper wrap : wrapperList) {
                if (wrap.Id != null) {
                    accountIds.add(wrap.Id);
                }
            }
            
            Map<Id, Account> existingMap = new Map<Id, Account>([
                SELECT Id, Name, Rating FROM Account WHERE Id IN :accountIds
            ]);
            
            List<Account> accListToUpdate = new List<Account>();
            
            for (AccountWrapper wrap : wrapperList) {
                if (existingMap.containsKey(wrap.Id)) {
                    Account acc = existingMap.get(wrap.Id);
                    Boolean isChanged = false;
                    
                    if (wrap.Name != null && wrap.Name != acc.Name) {
                        acc.Name = wrap.Name;
                        isChanged = true;
                    }
                    
                    if (wrap.Rating != null && wrap.Rating != acc.Rating) {
                        acc.Rating = wrap.Rating;
                        isChanged = true;
                    }
                    
                    if (isChanged) {
                        accListToUpdate.add(acc);
                    }
                }
            }
            
            if (!accListToUpdate.isEmpty()) {
                update accListToUpdate;
            }
            
        } catch (Exception e) {
            throw new AuraHandledException('Failed to update records: ' + e.getMessage());
        }
        
    }
    
    
}