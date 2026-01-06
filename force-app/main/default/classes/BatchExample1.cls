public class BatchExample1 implements Database.Batchable<sObject>{
    
    // Start -->> Queries All the records for Processing
    public database.queryLocator start(Database.BatchableContext bc){
        
        string s='Select Id, Name from Account';
        return Database.getQueryLocator(s);
        
    }
    
    // Execute -->> Accept the Chunck/subset of data from the start method and Process it.
    public void execute(Database.BatchableContext bc, List<Account> acc){
        
        for(Account ac: acc){
            ac.Industry='Banking';
            ac.Rating='Hot';
        }
        update acc;
        
    }
    
    // Finish -->> Post Processing Work
    public void finish(Database.BatchableContext bc){
        
    }
    
    
    
    
    

}