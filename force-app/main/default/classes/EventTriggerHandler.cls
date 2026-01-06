public class EventTriggerHandler {
    public static void sendEmailToAssignedUsers(List<Event> newEvents) {
        
        Map<Id, String> ownerEmails = new Map<Id, String>();
        Set<Id> ownerIds = new Set<Id>();
        
        for (Event eventRecord : newEvents) {
            if (eventRecord.OwnerId != null) {
                ownerIds.add(eventRecord.OwnerId);
            }
        }

        if (!ownerIds.isEmpty()) {
            for (User userRecord : [SELECT Id, Email FROM User WHERE Id IN :ownerIds AND Email != null]) {
                ownerEmails.put(userRecord.Id, userRecord.Email);
            }
        }

        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();

        for (Event ev : newEvents) {
            if (ev.OwnerId != null && ownerEmails.containsKey(ev.OwnerId)) {
                // Construct the URL to the Lightning component
                String baseUrl = 'https://developercom378-dev-ed.develop.lightning.force.com';
                String componentUrl = baseUrl + '/lightning/c/yourComponent?eventId=' + ev.Id;

                // Updated email body with button
                String emailBody = '<html>' +
                                   '<body>' +
                                   '<h2>Event Invitation</h2>' +
                                   '<p>You have a new event. Click the button below to update the checkbox:</p>' +
                                   '<a href="' + componentUrl + '" ' +
                                   'style="display:inline-block; padding:10px 20px; background-color:#0070d2; color:white; text-decoration:none; border-radius:5px;">Update Checkbox</a>' +
                                   '<p>Do you accept the invitation?</p>' +
                                   '<form action="https://developercom378-dev-ed.develop.my.salesforce.com/services/apexrest/eventresponse" method="post">' +
                                   '<input type="hidden" name="event_id" value="' + ev.Id + '" />' +
                                   '<button type="submit" name="response" value="yes">Yes</button>' +
                                   '<button type="submit" name="response" value="no">No</button>' +
                                   '</form>' +
                                   '</body>' +
                                   '</html>';

                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setToAddresses(new String[] { ownerEmails.get(ev.OwnerId) });
                email.setSubject('Event Invitation: ' + ev.Subject);
                email.setHtmlBody(emailBody);

                emails.add(email);
            }
        }

        if (!emails.isEmpty()) {
            try {
                Messaging.sendEmail(emails);
            } catch (Exception e) {
                System.debug('Error sending email: ' + e.getMessage());
            }
        }
    }
}