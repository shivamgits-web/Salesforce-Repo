public class FutureAccountExample {
    @future
    public static void method1(List<id> accids){
        
        List<account> acclist = [SELECT Id, Number_of_Contacts__c,
                                         (Select Id from Contacts) FROM Account];
        for(Account acc:acclist){
            acc.Number_of_Contacts__c = acc.Contacts.size();
        }
        if(!acclist.isEmpty()){
            update acclist;
            
        }
        
   }
}