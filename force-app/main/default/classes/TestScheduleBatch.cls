public class TestScheduleBatch implements Database.Batchable<sObject>{
    
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([SELECT Id, Name, Annual_Fees__c, Class__c FROM Student__c]);
        // It will hit the exception even though 10 million record fetch
    }
    
    public void execute(Database.BatchableContext bc, List<Student__c> acclist){
        system.debug('New Account list '+acclist);
        
        List<Student__c> accUpdated=new List<Student__c>();
        
        for(Student__c acc: acclist){
              acc.Class__c = 10;
              accUpdated.add(acc);
         }
        
        system.debug('Updated Account'+accUpdated);
        Database.SaveResult[] srList = Database.update(accUpdated, false);
        for (Database.SaveResult sr : srList) {
            if (sr.isSuccess()){
                   System.debug('Successfully inserted Invoice. Invoice ID: ' + sr.getId());
             } else {
                    for(Database.Error objErr : sr.getErrors()){
                               System.debug('The following error has occurred.');
                               System.debug(objErr.getStatusCode() + ': ' + objErr.getMessage());
                               System.debug('Invoice oject field which are affected by the error:'+ objErr.getFields());
                       }
             } 
            
       }
    }
    
    public void finish(Database.BatchableContext bc){
        system.debug('Batch Job is completed');
    }
    
}