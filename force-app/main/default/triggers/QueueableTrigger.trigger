trigger QueueableTrigger on Account (After insert) {
    
    queueAbleApexClass qc= new queueAbleApexClass();
    qc.acc = trigger.New;
    Id jobId=system.enqueueJob(qc);
    system.debug('JobId ---->>'+JobId);

}