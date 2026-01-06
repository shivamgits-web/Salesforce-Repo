public class AccountHandler {
    
    public static void createNewAccount(){
        
        Account accNew = new Account();
        accNew.Name = 'New Company';
        insert accNew;
        system.debug('New Account is:'+accNew);
        
    }
    
    public static void createMultipleAccounts(){
        Account accNew1 = new Account();
        accNew1.Name = 'New Company1';
        
        Account accNew2 = new Account();
        accNew2.Name = 'New Company2';
        
        List<Account> accList = new List<Account>();
        accList.add(accNew1);
        accList.add(accNew2);
        insert accList;
    }
    
    public static void takeAccountsInput(Integer n){
        List<Account> listAcc = new List<Account>();
        for(Integer i=0;i<n;i++){
            Account acc = new Account();
            acc.Name  = 'New Account'+i;
            listAcc.add(acc);
        }
        insert listAcc;
    
}
    
    public static void UpdaAccount(String AccId){
        Account AccUpdate = [Select Id, Name, Industry from Account where Id=: AccId];
        AccUpdate.Industry = 'Agricultural';
        update AccUpdate;
    
}
}