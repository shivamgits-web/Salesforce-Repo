public class AccountObjectHandlerClass {

	@AuraEnabled(cacheable=true)
	public static List<Account> accountRecord(){
		return [select Id, Name, Rating from Account LIMIT 10];
	}

	@AuraEnabled(cacheable=true)
	public static List<Account> getAccount(string searchKey){
        String key = '%' + searchKey + '%';
		List<Account> acclist = new List<Account>();
		if(key != null){
		   acclist = [select Id, Name, Rating from Account where Name LIKE :key LIMIT 10];
		}
		return acclist;
	}

}