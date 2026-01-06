public class ConversationService {

    public static void insertConversations(String jsonInput) {
        fromJSON parsed = fromJSON.parse(jsonInput);
        List<Conversation__c> conversationsToInsert = new List<Conversation__c>();

        if (parsed.conversationEntries != null) {
            for (fromJSON.cls_conversationEntries entry : parsed.conversationEntries) {
                if (entry.relatedRecords != null) {
                    for (String relatedId : entry.relatedRecords) {
                        Id recordId;
                        try {
                            recordId = Id.valueOf(relatedId);
                        } catch (Exception e) {
                            continue;
                        }
                        //if (recordId.getSObjectType() == Messaging_Session__c.SObjectType) {
                            Conversation__c conv = new Conversation__c();
                            conv.Message_Text__c = entry.messageText;
                            //conv.Messaging_Session__c = 'a0MJ4000005PULKMA4';                           
                            conversationsToInsert.add(conv);
                       //}
                    }
                }
            }
        }

        if (!conversationsToInsert.isEmpty()) {
            insert conversationsToInsert;
        }
    }
}