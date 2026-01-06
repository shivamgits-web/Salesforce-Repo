@isTest
public class TestClass1 {
    
    
    
    // Creating test data
    @testSetup
    public static void createData(){
        // Create an Account record
        Account acc1 = new Account(name='Shivam Test Account', AnnualRevenue=400);
        Insert acc1;
        
        // Create Opportunity records related to the Account
        List<Opportunity> oppList = new List<Opportunity>();
        Opportunity opp1 = new Opportunity(name='Opp Shivam 1', CloseDate=System.today(), StageName='Closed Won', Amount=1000, AccountId=acc1.Id); 
        oppList.add(opp1);
        
        Opportunity opp2 = new Opportunity(name='Opp Shivam 2', CloseDate=System.today(), StageName='Closed Won', Amount=100, AccountId=acc1.Id); 
        oppList.add(opp2);
        
        insert oppList;
    }
    
    // Testing the annualRevenue method
    @isTest
    public static void testMethod1(){
        // Query for an Account record
        List<Account> accountRec = [SELECT Id, Name, AnnualRevenue FROM Account LIMIT 1];
        
        // Query for Opportunity records
        List<Opportunity> oppRec = [SELECT Id, Name, Amount FROM Opportunity];
        
        // Ensure that Account and Opportunity records exist
        System.assertNotEquals(0, accountRec.size(), 'No Account record found');
        System.assertNotEquals(0, oppRec.size(), 'No Opportunity record found');
        
        // Call the method under test
        AccountOppHelperClass valueHelp = new AccountOppHelperClass();
        Decimal annualReve = valueHelp.annualRevenue(accountRec[0].Id);
        
        // Validate the result
        System.assertEquals(accountRec[0].AnnualRevenue + oppRec[0].Amount, annualReve, 'Annual Revenue calculation is incorrect');
    }
    
    @isTest
    public static void testMethod2(){
        
       
        //1.Step: Create Data whose not any related opportunity
       
        Account acc2 =new Account(name='Shivam Test Account',AnnualRevenue=600);
        Insert acc2;
        
        //2.Step: Call the Class and Method
        //If method contain the static, then directly we call the class
        //else we have to create the instance of the class and call the method.
        
        AccountOppHelperClass valueHelp=new AccountOppHelperClass();
        Decimal annualReve = valueHelp.annualRevenue(acc2.Id);
        
        //3.Step: To validate the Result
        system.assertEquals(acc2.AnnualRevenue, annualReve);
        
    }
    
    @isTest
    public static void testMethod3(){
        
        //1.Step: Create Data 
        Account acc3 =new Account(name='Shivam Test Account 1',AnnualRevenue=400);
        Insert acc3;
         
        List<Opportunity> oppList =new List<Opportunity>();
        Opportunity opp1=new Opportunity(name='Opp Shivam 1',CloseDate=system.today(),StageName='Closed Won', Amount=1000,AccountId=acc3.Id); 
        oppList.add(opp1);
        
        Opportunity opp2=new Opportunity(name='Opp Shivam 2',CloseDate=system.today(),StageName='Closed Won', Amount=100, AccountId=acc3.Id); 
        oppList.add(opp2);
        
        Test.startTest();
          insert oppList;
       Test.stopTest();
        
        //2.Step: Call the Class and Method
        //If method contain the static, then directly we call the class
        //else we have to create the instance of the class and call the method.
        
        AccountOppHelperClass valueHelp=new AccountOppHelperClass();
        Integer oppCount = valueHelp.countOpenOpp(acc3.Id);

        
        //3.Step: To validate the Result
        system.assertEquals(oppList.size(), oppCount);
        
    }
   

}