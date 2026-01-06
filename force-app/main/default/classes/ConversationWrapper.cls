public class ConversationWrapper {
    /*public List<ConversationEntry> conversationEntries;

    public class ConversationEntry {
        public Integer clientDuration;
        public Long clientTimestamp;
        public String identifier;
        public String messageText;
        public List<String> relatedRecords;
        public Sender sender;
        public Long serverReceivedTimestamp;
    }

    public class Sender {
        public String appType;
        public String role;
        public String subject;
    }*/
    
    public List<cls_conversationEntries> conversationEntries;

    public class cls_conversationEntries {
        public Integer clientDuration;
        public Integer clientTimestamp;
        public String identifier;
        public String messageText;
        public List<Object> relatedRecords;
        public cls_sender sender;
        public Integer serverReceivedTimestamp;
    }

    public class cls_sender {
        public String appType;
        public String role;
        public String subject;
    }
}