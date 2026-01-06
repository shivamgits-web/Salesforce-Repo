/*public class QueueAssignmentHandler {
    
    public class QueueRequest {
        @InvocableVariable public Id queueId;
    }
    
    @InvocableMethod
    public static void assignQueue(List<QueueRequest> requests) {
        List<QueueSObject> qSObjs = new List<QueueSObject>();
        List<GroupMember> members = new List<GroupMember>();

        for (QueueRequest req : requests) {
            System.debug('queueId -->> ' + req.queueId);
            qSObjs.add(new QueueSObject(
                SobjectType = 'Subscription__c',
                QueueId = req.queueId
            ));

            User u = [SELECT Id FROM User WHERE Name = 'Shivam Lachure' LIMIT 1];
            members.add(new GroupMember(
                GroupId = req.queueId,
                UserOrGroupId = u.Id
            ));
        }

        insert qSObjs;
        insert members;
    }
}*/
/*public class QueueAssignmentHandler {
    
    public class QueueRequest {
        @InvocableVariable public Id queueId;
    }

    @InvocableMethod
    public static void assignQueue(List<QueueRequest> requests) {
        for (QueueRequest req : requests) {
             System.debug('queueId -->> ' + req.queueId);
            assignQueueAsync(req.queueId);
        }
    }

    @future
    public static void assignQueueAsync(Id queueId) {
        System.debug('queueId (async) -->> ' + queueId);

        List<QueueSObject> qSObjs = new List<QueueSObject>();
        List<GroupMember> members = new List<GroupMember>();

        qSObjs.add(new QueueSObject(
            SobjectType = 'Subscription__c',
            QueueId = queueId
        ));

        User u = [SELECT Id FROM User WHERE Name = 'Shivam Lachure' LIMIT 1];
        members.add(new GroupMember(
            GroupId = queueId,
            UserOrGroupId = u.Id
        ));

        insert qSObjs;
        insert members;
    }
}*/

public class QueueAssignmentHandler {

    public class QueueRequest {
        @InvocableVariable public Id queueId1;
        @InvocableVariable public Id queueId2;
    }

    @InvocableMethod
    public static void assignQueue(List<QueueRequest> requests) {
        Set<Id> queueIdSet = new Set<Id>();

        for (QueueRequest req : requests) {
            if (req.queueId1 != null) {
                queueIdSet.add(req.queueId1);
            }
            if (req.queueId2 != null) {
                queueIdSet.add(req.queueId2);
            }
        }
        system.debug('queueIdSet-->>'+queueIdSet);
        if (!queueIdSet.isEmpty()) {
            assignQueueAsync(new List<Id>(queueIdSet));
        }
    }

    @future
    public static void assignQueueAsync(List<Id> queueIds) {
        List<QueueSObject> qSObjs = new List<QueueSObject>();
        List<GroupMember> members = new List<GroupMember>();

        User u = [SELECT Id FROM User WHERE Name = 'Shivam Lachure' LIMIT 1];

        for (Id queueId : queueIds) {
            qSObjs.add(new QueueSObject(SobjectType = 'Subscription__c', QueueId = queueId));
            members.add(new GroupMember(GroupId = queueId, UserOrGroupId = u.Id));
        }

        insert qSObjs;
        insert members;
    }
}