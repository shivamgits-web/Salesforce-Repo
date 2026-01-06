public with sharing class accountHandlerClass {
    
    public static void updateRating(List<Account> acclist,Map<Id, Account> OldMap){
        List<Account> accountsWithChangedRating=new List<Account>(); 
        for(Account ac: acclist){
            if (ac.Rating !=null && ac.Rating != OldMap.get(ac.Id).Rating) {
                accountsWithChangedRating.add(ac);
            }
        }
        if (!accountsWithChangedRating.isEmpty()) {
              String jsonData = JSON.serialize(accountsWithChangedRating);
              SalesforceIntegrationClass.updateRecord(jsonData);
          }
    }
    
    // When Account CustomerPriority__c will change the account Related Oppertunity Should be create.
    public static void updateAccount(List<Account> acclist, Map<Id, Account> OldMap){
        
        set<Id> accountIds=new set<Id>(); 
        if(acclist != null && !acclist.isEmpty()){
            for(Account acc: acclist){
                if(acc.CustomerPriority__c != null && acc.CustomerPriority__c != OldMap.get(acc.Id).CustomerPriority__c){
                    accountIds.add(acc.Id);
                  }
            }
        }
        system.debug('accountIds '+accountIds);
        
        List<Opportunity> OpportunityRecords=[Select Id, Name, AccountId from Opportunity where AccountId IN:accountIds];
        List<Opportunity> opplist=new List<Opportunity>();
        
        if(OpportunityRecords != null && !OpportunityRecords.isEmpty()){
            for(Opportunity opp: OpportunityRecords){
                opp.Name='Updated 101';
                opplist.add(opp);
            }
        }
        //Database.update(opplist,false);
        innerClass.oppUpdate(opplist);
        system.debug('Opplist '+opplist);
    }
    
    
    

}