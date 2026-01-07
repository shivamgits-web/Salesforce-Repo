trigger updateAccountTrigger on Account (before insert, after insert) {
    
    if(Trigger.isBefore && Trigger.isInsert){
        //updateAccount.accountBeforeInsert(Trigger.New);
    }
        
    if(Trigger.isAfter && Trigger.isInsert){
         updateAccount.createContact(Trigger.New);
     }
            
}