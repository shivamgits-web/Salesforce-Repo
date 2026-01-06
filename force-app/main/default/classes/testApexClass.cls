public class testApexClass {

	@AuraEnabled(cacheable=true)
	public static List<Account> getAccountDate(String Name){

        String likeParam = Name+'%';
		string query = 'select id,Name from Account where Name LIKE : likeParam';
		List<Account> acclist= Database.query(query);
        return acclist;
	}

	@AuraEnabled(cacheable=true)
	public static List<Contact> getRelatedContactRecord(String AccountId){

		List<Contact> conlist = [select id,Name from Contact where AccountId =: AccountId];
        return conlist;
	}
}