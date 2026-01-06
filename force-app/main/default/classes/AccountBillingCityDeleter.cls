public class AccountBillingCityDeleter {
    
    public static void deleteAccountBillingCity(String AccId){
        Account acc = [Select Id, Name, BillingCity From Account where Id=: AccId];
        if(acc.BillingCity != Null){
            acc.BillingCity = Null;
            update acc;
          }
    }
    
    public static void changeAccountIndustry(String AccId){
        Account acc = [Select Id, Name, BillingCity, Industry From Account where Id=: AccId];
        if(acc.Industry != Null || acc.Industry != 'Agricultural'){
            acc.Industry ='Agricultural';
            update acc;
          }
    }
    
    public static void updateCloseDate(String oppId){
        Opportunity opp = [Select Id, closeDate from Opportunity where Id =: oppId];
        if(opp.closeDate != NUll){
            Date nextMonth = opp.CloseDate.addMonths(1);
            opp.closeDate = nextMonth;
            update opp;
        }
         
    }
    
    public static void incrementNumberOfEmployees(Id AccId){
        Account Acclist =[SELECT Id, Name, Type, Phone, AccountNumber, Industry, NumberOfEmployees FROM Account where Id =: AccId];
        if(Acclist != Null){
            Acclist.NumberOfEmployees += 10;
            update Acclist;
        }
        
    } 
    
}