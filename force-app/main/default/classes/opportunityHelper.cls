public class opportunityHelper {
    
    public static void oppInsert(List<Opportunity> oppList){
        
        for(Opportunity opp: oppList){
            if(opp.Amount<100){
                opp.Amount = 1000;
            }
        }
        
    }

}