public class sendPerformanceNotification implements Queueable {

    public Set<Id> reviewIds;

    public sendPerformanceNotification(Set<Id> perfReviewIds){
        this.reviewIds = perfReviewIds;
    }

    public void execute(QueueableContext qc) {
        try {
            List<Performance_Review__c> perfReviewData = [
                SELECT Id, Name, Review_Date__c, Employees__c, Rating__C,
                       Employees__r.Name, Employees__r.Email__c
                       FROM Performance_Review__c
                       WHERE Id =:this.reviewIds
            ];

            system.debug(perfReviewData);

            Map<Id, Messaging.SingleEmailMessage> emailMap = new Map<Id, Messaging.SingleEmailMessage>();

            for (Performance_Review__c review : perfReviewData) {
                system.debug('Empolyee Emails is'+review.Employees__r.Email__c);
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setToAddresses(new String[]{review.Employees__r.Email__c});
               
                email.setSubject('Performance Review Completed');
                email.setPlainTextBody('Dear ' + review.Employees__r.Name + ',\n\n Your Performance Review is Completed. Please check it. Best of Luck! ');

                emailMap.put(review.Id, email);
            }

            List<Messaging.SendEmailResult> emailResults = Messaging.sendEmail(emailMap.values());

            for (Messaging.SendEmailResult result : emailResults) {
                if (!result.isSuccess()) {
                    System.debug('If Email failed to send: ' + result.getErrors()[0].getMessage());
                }
            }
        } catch (Exception e) {
            System.debug('An error occurred: ' + e.getMessage());
        }
    }
}