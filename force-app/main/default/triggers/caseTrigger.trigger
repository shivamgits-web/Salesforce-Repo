trigger caseTrigger on Case (After insert) {
    
    if(Trigger.isInsert && Trigger.isAfter){
        
        caseHandlerClass.caseCountMethod(Trigger.New);
    }

}