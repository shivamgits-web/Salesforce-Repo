public class StudentTrigger {
        
    public static void accountBeforeInsert(List<Account> accList){
        for(Account acc: accList){
            if(acc.Industry=='Banking'){
                acc.Active__c='Yes'; 
            }else{
                acc.Active__c='No'; 
            }
        }
    }
}