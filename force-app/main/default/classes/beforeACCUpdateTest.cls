@isTest
public class beforeACCUpdateTest {
   @isTest
   public static void method1(){
       
        Account acc=new Account();
        acc.Name = 'Test Account 1';
        acc.Active__c = 'Yes';
        insert acc;
               
    }
}