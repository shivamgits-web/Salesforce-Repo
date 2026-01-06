public class fromJSON {
    public List<cls_conversationEntries> conversationEntries;

    public class cls_conversationEntries {
        public Integer clientDuration;
        public LONG clientTimestamp;
        public String identifier;
        public String messageText;
        public List<string> relatedRecords;
        public cls_sender sender;
        public LONG serverReceivedTimestamp;
    }

    public class cls_sender {
        public String appType;
        public String role;
        public String subject;
    }

    public static fromJSON parse(String json) {
        return (fromJSON) System.JSON.deserialize(json, fromJSON.class);
    }
}