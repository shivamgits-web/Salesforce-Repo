@RestResource(urlMapping='/eventresponse/*')
global with sharing class eventApexRest {
    
    @HttpPost
    global static String handleEventResponse(String event_id, String response) {
        system.debug('event_id'+event_id);
        system.debug('response'+response);
        
        if (String.isBlank(event_id)) {
            return 'Error: Event ID is required.';
        }
        
        // Query the event record based on the event_id
        Event eventRecord = [SELECT Id, Subject, OwnerId,IsAllDayEvent FROM Event WHERE Id = :event_id LIMIT 1];
        
        if (eventRecord == null) {
            return 'Error: Event not found.';
        }
        
        // Handle the response (Yes/No) and update the event accordingly
        if (response == 'yes') {
            // Update the Event with the response or take other actions
            eventRecord.IsAllDayEvent =true;  // Example status change, customize as needed
            update eventRecord;
        } 
        
        return 'Success: Event response recorded.';
    }
}