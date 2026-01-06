@istest
public class SampleAccountClassTest {
    @istest
    public static void method(){
        
        Account acc=new Account();
        acc.Name='Industry Account';
        acc.Industry='Banking';
        insert acc;
        
        test.startTest();
        SampleAccountClass.sample();
        acc.Industry='Agricultural';
        update acc;
        test.stoptest();
    }

}