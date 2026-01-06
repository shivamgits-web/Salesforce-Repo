public class AccountHandleTodayClass {
	@AuraEnabled
	public static Account createAccount(String accountName, String caseOrigin){
       	system.debug('accountName >>>'+accountName);
		Account acc=new Account();
		acc.Name = accountName;
		acc.Active__c = 'Yes';
		acc.RecordTypeId = '0125j000000jFb5AAE';
		insert acc;
		system.debug('Account Create >>>'+acc);

		Contact con=new Contact();
		con.LastName = accountName;
		con.AccountId = acc.Id;
		insert con;

		Case ca=new Case();
		ca.AccountId = acc.Id;
		ca.ContactId = con.Id;
		ca.Origin = caseOrigin;
        ca.Status = 'New';
		insert ca;

		return acc;
		
	}
}