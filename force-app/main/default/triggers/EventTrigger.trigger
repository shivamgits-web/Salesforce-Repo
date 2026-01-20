trigger EventTrigger on Event (After insert) {
    
    if(Trigger.isAfter && Trigger.isInsert){
        EventTriggerHandler.sendEmailToAssignedUsers(Trigger.New);
    }

}