global class EventResponseEmailHandler implements Messaging.InboundEmailHandler {
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope env) {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
        
        system.debug('emailSubject'+email.subject);
        String eventId = extractEventIdFromBody(email.plainTextBody); 
        String response = extractResponseFromBody(email.plainTextBody);
        system.debug('eventId'+eventId);
        system.debug('response'+response);
        
        if (eventId != null && response != null) {
            
            Event ev = [SELECT Id,OwnerId, IsAllDayEvent FROM Event WHERE Id = :eventId LIMIT 1];
            
            if (ev != null) {
                if (response == 'yes') {
                    ev.IsAllDayEvent =true;
                } 
                update ev;
            }
        }

        return result;
    }
    
    private String extractEventIdFromBody(String emailBody) {
        
        Pattern p = Pattern.compile('event_id=([a-zA-Z0-9]+)');
        Matcher m = p.matcher(emailBody);
        return m.find() ? m.group(1) : null;
    }

    private String extractResponseFromBody(String emailBody) {
       
        Pattern p = Pattern.compile('response=(yes|no)');
        Matcher m = p.matcher(emailBody);
        return m.find() ? m.group(1) : null;
    }
}