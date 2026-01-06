public with sharing class EventResponseHandlerClass {
    public Event event { get; set; }

    // Constructor to fetch the event based on the eventId
    public EventResponseHandlerClass() {
        String eventId = ApexPages.currentPage().getParameters().get('eventId');
        if (eventId != null) {
            event = [SELECT Id, Subject FROM Event WHERE Id = :eventId LIMIT 1];
        }
    }

    // Handle the Yes/No response from the email link
    @AuraEnabled
    public static String handleResponse() {
        RestRequest req = RestContext.request;
        String eventId = req.params.get('eventId');
        String response = req.params.get('response'); // 'yes' or 'no'

        if (eventId != null && response != null) {
            Event eventRecord = [SELECT Id, IsAllDayEvent FROM Event WHERE Id = :eventId LIMIT 1];

            if (response.toLowerCase() == 'yes') {
                eventRecord.IsAllDayEvent = true;
            } else if (response.toLowerCase() == 'no') {
                eventRecord.IsAllDayEvent = false;
            }

            update eventRecord;

            return 'Thank you for your response!';
        }
        return 'Invalid response.';
    }
}