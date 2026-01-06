public class ConversationHandler {
    
    /**public static void parseAndInsert(String jsonInput) {
        ConversationWrapper wrapper = (ConversationWrapper) JSON.deserialize(jsonInput, ConversationWrapper.class);
        insertConversationRecord(wrapper.conversationEntries);
    }

    public static void insertConversationRecord(List<ConversationWrapper.ConversationEntry> entryList) {
        List<Conversation__c> recordsToInsert = new List<Conversation__c>();
        
        for (ConversationWrapper.ConversationEntry entry : entryList) {
            Conversation__c conv = new Conversation__c();
            conv.Message_Text__c = entry.messageText;
            if (entry.sender != null) {
                conv.Role__c = entry.sender.role;
            }
            recordsToInsert.add(conv);
        }
        
        if (!recordsToInsert.isEmpty()) {
            insert recordsToInsert;
        }
        
    }**/
    
    
}