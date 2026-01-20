trigger oppTrigger1 on Opportunity (before insert) {
    
    opportunityHelper.oppInsert(Trigger.New);

}