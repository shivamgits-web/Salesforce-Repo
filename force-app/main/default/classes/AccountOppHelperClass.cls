public class AccountOppHelperClass {
    
    //When account is having any related opp. then show the opp amount on the Account object field Annual Reveneue.
    public decimal annualRevenue(Id accId){
        
        List<Account> acclist=[select Id,Name, AnnualRevenue, (select Id, Name, amount from Opportunities order by Amount desc limit 1) from Account where Id =:accId];
        if(acclist.size()>0){
            if(acclist[0].Opportunities.size()>0){
                return acclist[0].AnnualRevenue + acclist[0].Opportunities[0].amount;
            }
            else{
                return acclist[0].AnnualRevenue;
            }
            
        }
        else{
            return null;
        }
    }
    
    //write the method to count the No. of Open opportunity of an Account.
    public integer countOpenOpp(Id accIds){
        
        List<Account> acc = [select Id,Name, (select id from opportunities where isClosed=false) from Account where Id=: accIds];
        return acc[0].opportunities.size();
    }
    
    

}