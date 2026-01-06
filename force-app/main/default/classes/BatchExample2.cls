public class BatchExample2 implements Database.Batchable<sObject>, Database.stateful{
    
    public Integer x=0;
    // Database.stateful return the from the chunk how many records are updated.
    public database.queryLocator start(Database.BatchableContext bc){
        
        string s='Select Id, Name From Account Where Id NOT IN (Select AccountId From Contact)';
        //string s='Select Id, Name, (select Id,Name from Contacts) From Account';
        return Database.getQueryLocator(s);
     }
    
    // Execute -->> Accept the Chunck/subset of data from the start method and Process it.
    public void execute(Database.BatchableContext bc, List<Account> acc){
        
           //List<Contact> conlist =new List<Contact>();
            //for(Account ac: acc){
              //   system.debug('Account records is-->>'+ac);
               //  if(ac.contacts.size()==0 ||ac.contacts.size()==null){
                 //     contact con=new contact();
                  //    con.LastName = ac.Name;
                  //    con.AccountId = ac.Id;
                     
                    //  conlist.add(con);
             //}
            //insert conlist;
       // }
       // x++;
       
        List<Contact> conlist =new List<Contact>();
        
        for(Account ac: acc){
            system.debug('Account Records-->>'+ac);
            contact con=new contact();
            con.LastName = ac.Name;
            con.AccountId = ac.Id;
            conlist.add(con);
            x++;
        }
        insert conlist;
      
        
     }
    
    // Finish -->> Post Processing Work
    public void finish(Database.BatchableContext bc){
        
        system.debug('Value of X is -->>'+x);
        
    }
    

}