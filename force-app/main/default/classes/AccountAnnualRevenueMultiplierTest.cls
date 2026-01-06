@istest
public class AccountAnnualRevenueMultiplierTest {
    @istest
    public static void method1(){
        
        Account Acc1=new Account();
        Acc1.Name='Shivam';
        Acc1.AnnualRevenue = 10000;
        insert Acc1;
        
        test.starttest();
        AccountAnnualRevenueMultiplier.multiplyAnnualRevenue(Acc1.id);
        Acc1.AnnualRevenue = 20000;
        update Acc1;
        test.stoptest();
        
    }
    

}