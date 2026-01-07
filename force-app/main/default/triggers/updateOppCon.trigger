trigger updateOppCon on Contact (After insert, After Update, Before Insert) {
    
    if((Trigger.isAfter && Trigger.isInsert) || (Trigger.isAfter && Trigger.isUpdate)){
        ContactHelperClass.updateRelatedOpp(trigger.New);
    }
    
    if(Trigger.isBefore && Trigger.isInsert){
        //contactHandlerClass.duplicateContactPrevent(Trigger.New);
        AccountRecordHandlerClass.contactInsert(trigger.New);
    }

}