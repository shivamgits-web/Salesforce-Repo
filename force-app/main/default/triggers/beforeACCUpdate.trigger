trigger beforeACCUpdate on Account (before insert, before update, after update, before delete) {
  
    if(Trigger.isBefore && Trigger.isUpdate) {
        updateAccRelatedOpp.beforeAccountUpdate(Trigger.New, Trigger.OldMap);
    }
    
     if(Trigger.isAfter && Trigger.isUpdate) {
        updateAccRelatedOpp.afterAccRelaOpp(Trigger.New, Trigger.OldMap);
    }
    
    if(trigger.isBefore && trigger.isInsert){
        updateAccRelatedOpp.accountInsert(Trigger.New);
    }
    
    if(trigger.isBefore && trigger.isDelete){
        updateAccRelatedOpp.AccountBeforeDelete(Trigger.Old);
    }
    
    
}