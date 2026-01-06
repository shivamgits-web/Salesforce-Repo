public class UpdateEventController {
    @AuraEnabled
    public static void updateEventCheckbox(String eventId) {
        Event eventRecord = [SELECT Id, IsAllDayEvent FROM Event WHERE Id = :eventId LIMIT 1];
        eventRecord.IsAllDayEvent = true; // Set checkbox to true
        update eventRecord;
    }
}