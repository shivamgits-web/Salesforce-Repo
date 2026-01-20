trigger OppertunityHandler on Opportunity (After update, After Insert) {
    
    if(Trigger.isAfter && Trigger.isUpdate){
        //OpportunityTriggerHandler.handleAccountUpdate(Trigger.New, Trigger.OldMap);
    }

    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)){
       //OpportunityTriggerHandler.updateInsertRating(Trigger.New, Trigger.OldMap);
    }
    
}