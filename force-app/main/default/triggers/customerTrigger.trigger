trigger customerTrigger on Customer__c (before insert, before update, after delete) {
    
    if(Trigger.isBefore && Trigger.isInsert){
        customerHandlerClass.customerValidate(Trigger.New);
    }
    
    if(Trigger.isBefore && Trigger.isUpdate){
        customerHandlerClass.customerData(Trigger.New, Trigger.oldMap);
    }
    
    if(Trigger.isAfter && Trigger.isDelete){
        customerHandlerClass.deleteCustomer(Trigger.old);
    }

}