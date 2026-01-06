public class ContactHelperClass {
    
    public static void updateRelatedOpp(List<Contact> newCont){
        
        // Sab se Phyle NewCont se maine ContactId li jis per account Hai
        system.debug('New Contact is created'+newCont);
        
        Set<Id> updateConId=new Set<Id>();
       
        for(Contact con: newCont){
            updateConId.add(con.AccountId);
        }
        system.debug('Related Account Ids'+updateConId);
        
        // Jis Related Contact Update Karna hai uski Query Likhni Hai aur usmai Usak related Id pass karna.
        List<Opportunity> oppList=[Select Id, Name, StageName, AccountId from Opportunity where AccountId IN :updateConId];
        system.debug('Opp list is '+oppList);
        
        List<Opportunity> updateOppList =new List<Opportunity>();
        for(Opportunity opp:oppList){
            
            if(opp.StageName !='Closed Won'){
                opp.StageName='Closed Won';
                updateOppList.add(opp);
            }
        }
        update updateOppList;
        
    }

}