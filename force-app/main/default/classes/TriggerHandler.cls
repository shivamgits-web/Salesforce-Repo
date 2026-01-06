public class TriggerHandler {

    public static void run(
        String objectName,
        Boolean isBefore,
        Boolean isAfter,
        Boolean isInsert,
        Boolean isUpdate,
        Boolean isDelete,
        List<SObject> newList,
        List<SObject> oldList,
        Map<Id, SObject> newMap,
        Map<Id, SObject> oldMap
    ) {
        if(objectName == 'Subscription__c') {
            SubscriptionTriggerHandler handler = new SubscriptionTriggerHandler(newList, oldList, newMap, oldMap);
            
            if (isBefore) {
                if (isInsert) handler.beforeInsert();
                if (isUpdate) handler.beforeUpdate();
            }
            if (isAfter) {
                if (isInsert) handler.afterInsert();
                if (isUpdate) handler.afterUpdate();
            }
        }

        
    }
}