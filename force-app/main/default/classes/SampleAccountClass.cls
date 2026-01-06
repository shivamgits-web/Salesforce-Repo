public class SampleAccountClass {
    public static void sample(){
        List<Account> listAcc = [SELECT Id, Name, Type, BillingCity, Phone, Rating, AnnualRevenue FROM Account where Industry = 'Banking'];
        //List<Account> Aclist = new List<Account>();
        for(Account acclist : listAcc){
            //if(acclist.AnnualRevenue == Null || acclist.AnnualRevenue != 10000){
                acclist.Industry='Agricultural';
                //listAcc.add(acclist);
           // }
         }
         update listAcc;
        system.debug('Updated Account Records are'+listAcc);
    }
         
}