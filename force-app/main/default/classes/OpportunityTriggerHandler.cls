public class OpportunityTriggerHandler {
    
    public static void handleAccountUpdate(List<Opportunity> newList, Map<Id, Opportunity> oldMap) {
        
        set<Id> oppIds = new set<Id>();
        set<Id> oppId = new set<Id>();
        set<Id> oppOwnerId=new set<Id>();
        Map<Id, String> userMap=new Map<Id, String>();
        
        for (Opportunity opp : newList) {
            if (opp.AccountId != null && opp.AccountId != oldMap.get(opp.Id).AccountId) {
                oppIds.add(opp.Id);
            }
            if(opp.Urgent_Deal__c != Null && opp.Urgent_Deal__c == true && opp.Urgent_Deal__c != oldMap.get(opp.Id).Urgent_Deal__c){
                oppId.add(opp.Id);
                oppOwnerId.add(opp.OwnerId);
            }
        }
        
        system.debug('oppIds'+oppIds);
        if(!oppOwnerId.IsEmpty()){
            for(User us: [select id,Email from User where Id IN : oppOwnerId]){
                userMap.put(us.Id, us.Email);
            } 
        }
        
        if(!oppId.IsEmpty()){
            List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
            for(Opportunity op: [select id,Urgent_Deal__c,OwnerId from Opportunity where Id IN:oppId]){
                
                    Messaging.SingleEmailMessage email=new Messaging.SingleEmailMessage ();
                    email.setToAddresses(new String[] { userMap.get(op.OwnerId) });
                    email.subject = 'Test Message';
                    email.plainTextBody = 'This is the message body.';
                    mails.add(email);
                
            }
            if(!mails.IsEmpty()){
               Messaging.sendEmail(mails);
            }
        }
        
        if (!oppIds.isEmpty()) {
            //OpportunityCalloutService.processAccountUpdates(oppIds);
        }
        
    }
    
    /*public static void updateInsertRating(List<Opportunity> oppList, Map<Id,Opportunity> oldMap){
        
        set<Id> accIds=new set<Id>();
        Map<Id,String> updateAccountMap=new  Map<Id,String>(); 
        List<Account> updatedAccountList=new List<Account>();
        if(!oppList.isEmpty()){
            for(Opportunity opp: oppList){
                if(opp.Rating__c != null || (!oldmap.isEmpty() && opp.Rating__c != oldMap.get(opp.Id).Rating__c)){
                    accIds.add(opp.AccountId);
                    updateAccountMap.put(opp.AccountId, opp.Rating__c);
                }
            }
        }
        
        if(!accIds.isEmpty()){
            for(Account ac: [select id, Rating__c from Account where Id IN: accIds]){
                if(updateAccountMap.containsKey(ac.Id)){
                    ac.Rating__c = updateAccountMap.get(ac.Id);
                    updatedAccountList.add(ac);
                }
            }
            if(!updatedAccountList.isEmpty()){
                update updatedAccountList;
            }
        }
             
    }*/
}