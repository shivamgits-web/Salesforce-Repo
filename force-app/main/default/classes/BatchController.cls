public class BatchController {
	 @AuraEnabled
    public static void executeBatch() {
        batchClass myBatch = new batchClass();
        Database.executeBatch(myBatch, 200); // Adjust batch size if needed
    }
}