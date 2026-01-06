public class AccountHandlerCls {


	@AuraEnabled(cacheable=true)
	public static List<Account> accountList(){
        
		return [select Id, Name from account LIMIT 10];

	}

	@AuraEnabled
    public static List<Contact> contactList(String accountName){
        system.debug('accountName '+accountName);
		List<Contact> conlist = [select id, FirstName, LastName from Contact where Account.Name =:accountName];
		system.debug('conlist '+conlist);
		return conlist;
	}
	
}