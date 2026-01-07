trigger SubscriptionTrigger on Subscription__c (before insert, before update, after insert, after update) {
    TriggerHandler.run('Subscription__c', Trigger.isBefore, Trigger.isAfter, Trigger.isInsert, Trigger.isUpdate, Trigger.isDelete, Trigger.new, Trigger.old, Trigger.newMap, Trigger.oldMap);
}