public class SubscriptionTriggerHandler {

    private List<Subscription__c> newList;
    private List<Subscription__c> oldList;
    private Map<Id, Subscription__c> newMap;
    private Map<Id, Subscription__c> oldMap;

    public SubscriptionTriggerHandler(List<SObject> newList, List<SObject> oldList, Map<Id, SObject> newMap, Map<Id, SObject> oldMap) {
        this.newList = (List<Subscription__c>)newList;
        this.oldList = (List<Subscription__c>)oldList;
        this.newMap = (Map<Id, Subscription__c>)newMap;
        this.oldMap = (Map<Id, Subscription__c>)oldMap;
    }

    public void beforeInsert() {
        SubscriptionHandler.updateLoaction(newList);
    }

    public void beforeUpdate() {
       
    }

    public void afterInsert() {
        
    }

    public void afterUpdate() {
        
    }
}