public class futureExample {
    
    @future
    public static void myClass(){
       system.debug('Inside Future Method ');        
    }
    
    // When we are creating Account, automatically Opportunity is Created.
    @future
    public static void creteOpp(Set<Id> acc){
        
        List<Opportunity> opplist = new List<Opportunity>();
        for(Id ac: acc){
            
           Opportunity opp=new Opportunity();
           opp.Name= 'Opp N1';
           opp.StageName ='Prospecting';
           opp.CloseDate=System.Today();
           Opp.AccountId= ac;
           opplist.add(opp);
          
        }
        insert opplist;
        
    }

}