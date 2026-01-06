@isTest
public class BatchExample1Test {
    
    
    @isTest
    public static void testBatchLogic(){
        
        // Step1 : Data Creation
        List<Account> acc=new List<Account>();
        for(Integer i=0;i<10;i++){
            acc.add(new account(name='Shivam Test Account'+i,AnnualRevenue=400, Industry='Chemical', Rating='Cold'));
         }
        insert acc;
        
        // Step2: Call the method and Pass the Data
        // Why we used the Test.startTest() & Test.stopTest() in async beacuse batch class run hone ke 
        // baad he wo valide data hai ya nahi wo check karenga.Timing issue is resolved
        Test.startTest();
              BatchExample1 b = new BatchExample1();
              Database.executeBatch(b);
        Test.stopTest();
        
        // Step3: Validate the Data
        List<Account> acclist=[select Id from Account where Industry='Banking' AND Rating='Hot'];
        system.assertEquals(acc.size(), acclist.size());
        
       }

}