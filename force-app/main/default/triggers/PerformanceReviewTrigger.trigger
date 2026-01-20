trigger PerformanceReviewTrigger on Performance_Review__c (Before insert, before update, After Update, After Insert) {
    
    if (Trigger.isBefore && Trigger.isInsert) {
            PerformanceManager.calculateOverallScor(Trigger.new);
        } 
    
   if (Trigger.isBefore && Trigger.isUpdate) {
            PerformanceManager.calculateOverallScor(Trigger.new);
        } 
    
         
}