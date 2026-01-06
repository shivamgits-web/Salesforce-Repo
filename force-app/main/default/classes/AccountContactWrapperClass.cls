public class AccountContactWrapperClass {
    
    public Account acc {get; set;}
    public List<Contact> conlist {get; set;}
    
    public AccountContactWrapperClass(Account acc, List<Contact> conlist){
        this.acc = acc;
        this.conlist = conlist; 
    }
    
    public static List<AccountContactWrapperClass> getAccountContact(){
        List<AccountContactWrapperClass> wrapperList =new List<AccountContactWrapperClass>();
        List<Account> accList = [select id, Name, (Select id, Name from contacts) from Account LIMIT 10];
        
        for(Account acc: accList){
            wrapperList.add(new AccountContactWrapperClass(acc, acc.contacts));
        }
        return wrapperList;
    }
}