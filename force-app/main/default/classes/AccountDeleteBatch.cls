public class AccountDeleteBatch implements Database.batchable<sobject>{
    
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([SELECT Id, LastName, FirstName, LastModifiedDate FROM Contact WHERE LastModifiedDate < LAST_N_DAYS:180]);
    }
    
    Public static void execute (Database.batchableContext bc,List<contact> conlist){
        delete conlist;
    }
    
    Public void finish(Database.batchableContext bc){
	       system.debug('processing complete');
	}
    

}