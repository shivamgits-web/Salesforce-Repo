trigger sendEmailNotificationPerformanceReview on Performance_Review__c (after insert) {
    public Set<Id> reviewIds = new Set<Id>();

    for (Performance_Review__c perfReview : Trigger.new) {
        reviewIds.add(perfReview.Id);
    }

    if (!reviewIds.isEmpty()) {
        sendPerformanceNotification job = new sendPerformanceNotification(reviewIds);
        System.enqueueJob(job);
    }
}

// How to run this Batch
//Set<Id> reviewIds = new Set<Id>{'a085j00000LR4EdAAL'};
//sendPerformanceNotification notificationJob = new sendPerformanceNotification(reviewIds);
//System.enqueueJob(notificationJob);