public class queueAbleApexClass implements Queueable {

    public List<Account> acc;
    public void execute(QueueableContext qc){
        
        /*List<Opportunity> opplist=new List<Opportunity>();
        
        for(Account ac: acc){
            
            opplist.add(new opportunity(name='Queueable Opp',StageName='Qualification', CloseDate=System.Today(),AccountId= ac.id));
        }
        insert opplist;*/
        
    }
}