trigger createNewLead on Lead (before insert) {
    if(Trigger.isBefore && Trigger.isInsert){
        createNewLead.createLead(trigger.New);
    }
}