public class updateAccount {

   /*public static void accountBeforeInsert(List<Account> accList){
        for(Account acc: accList){
            if(acc.Industry=='Banking'){
                acc.Active__c='Yes'; 
            }else{
                acc.Active__c='No'; 
            }
        }
    }*/
    
    public static void createContact(List<Account> accRecord){
        
        Map<Id, Decimal> accountMap =new  Map<Id, Decimal>(); 
        if(!accRecord.IsEmpty()){
            for(Account ac: accRecord){
                if(ac.Number_of_Contacts__c != null){
                    accountMap.put(ac.Id, ac.Number_of_Contacts__c);
                }
            }
        }
        system.debug('accountMap->>>>'+accountMap);
        List<Contact> conList=new List<Contact>(); 
        if(!accRecord.IsEmpty()){
            for(Account ac: accRecord){
                if(accountMap.containsKey(ac.Id)){
                    for(Integer i=0; i<accountMap.get(ac.Id); i++){
                         Contact con=new Contact();
                         con.LastName = ac.Name + i;
                         con.Email = 'contact' + i + '@example.com';
                         conList.add(con);
                    }
                }
            }
            system.debug('conList->>>>'+conList);
            if(conList != null){
                insert conList;
            }
            
        }
        
        
        
    }
}