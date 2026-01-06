public class SubscriptionHandler {
    
    public static void updateLoaction(List<Subscription__c> subList){
        set<Id> careProgramIds=new set<Id>();
        if(!subList.isEmpty()){
            for(Subscription__c sub: subList){
                careProgramIds.add(sub.Channel_Program__c);
            }
        }
        
        Map<String,String> careProgramMap =new Map<String,String>();
        if(!careProgramIds.isEmpty()){
            for(Care_Program__c cp: [select id, Location__c from Care_Program__c where ID IN :careProgramIds]){
                careProgramMap.put(cp.Id, cp.Location__c);
            }
        }
        
        for(Subscription__c sb: subList){
            sb.Care_Program_Location__c = careProgramMap.get(sb.Channel_Program__c);
        }
    }

}