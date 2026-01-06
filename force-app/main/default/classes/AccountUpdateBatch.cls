public class AccountUpdateBatch implements Database.batchable<sobject>{
     public Database.QueryLocator start(Database.BatchableContext bc) {
           return Database.getQueryLocator([SELECT Id, Name,(SELECT Id, CloseDate, AccountId FROM Opportunities) FROM Account]);
       }
    
    Public static void execute (Database.batchableContext bc,List<account> accList){
        for(Account acc:acclist){
           acc.Active__c = 'Yes';
        }
        update acclist;
    }
    
    Public void finish(Database.batchableContext bc){
	       system.debug('processing complete');
	}
}