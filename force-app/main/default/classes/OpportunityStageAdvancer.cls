public class OpportunityStageAdvancer {

    public static void advanceStage(Id oppId){
        
        Opportunity oppValue = [SELECT Id, AccountId, Name, Description, Probability, stageName FROM Opportunity where Id =:oppId];
        Map<String, String> oppMap = new Map<String, String>();
        oppMap.put('Prospecting','Qualification');
        oppMap.put('Qualification','Needs Analysis');
        
        // ContaisKey check the left side of the Map Value 
        if(oppMap.containsKey(oppValue.stageName)){
            oppValue.stageName = oppMap.get(oppValue.stageName );
            // get ka function matlab 'Jo bhi ham key value pass karenge Get ke under wo uski Value lenga'
        }
        update oppValue; 
        
    }
}

// OpportunityStageAdvancer.advanceStage('0065j00001WlzWMAAZ');