trigger ContactTriggerToday on Contact (Before insert) {
    
    if(Trigger.isBefore && Trigger.isInsert){
        AccountRecordHandlerClass.contactInsert(Trigger.New);
    }

}