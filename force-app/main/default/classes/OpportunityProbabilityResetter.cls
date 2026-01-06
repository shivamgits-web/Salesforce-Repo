public class OpportunityProbabilityResetter {
    
    public static void resetProbability(){
        List<Opportunity> oppList = [SELECT Id, StageName, Amount, Probability FROM Opportunity];
        List<Opportunity> opList = new List<Opportunity>();
        
        for(Opportunity opp : oppList){
            opp.Probability = 20;
            opList.add(opp);
        }
        update opList;
        
    }

}