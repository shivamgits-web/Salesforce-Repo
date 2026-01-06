public class OppHelper {
    
    public static void oppUpdate(List<Opportunity> opplist, Map<Id,Opportunity> oldMap){
        
        List<Opportunity> opId = new List<Opportunity>();
        for(Opportunity opp: oppList){
            if(oldMap.get(opp.Id).AccountId != Null){
                opId.add(opp);
            }
        }
    }

}