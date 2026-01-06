public with sharing class CSVControllerNew {

   
    public static String loadCSVData(Id contentDocumentId) {

        // Retrieve ContentVersion data for the given ContentDocumentId
        ContentVersion contentVersionObj = [SELECT Id, VersionData FROM ContentVersion WHERE ContentDocumentId = :contentDocumentId LIMIT 1];
        
        // List to store the Account records to insert
        List<Account> acclist = new List<Account>();
        
        // Convert the VersionData to String for parsing
        String data = contentVersionObj.VersionData.toString();

        // Split the CSV data into lines
        String[] csvFileLines = data.split('\n');
        
        // Loop through each line of the CSV starting from the second line (skipping header)
        for (Integer i = 1; i < csvFileLines.size(); i++) {

            // Split the line by commas to extract record fields
            String[] csvRecordData = csvFileLines[i].split(',');

            // Skip empty lines or improperly formatted rows
            if (csvRecordData.size() < 4 || csvRecordData[0].trim() == '') {
                continue; // Skip this iteration if data is invalid or empty
            }

            try {
                // Create a new Account object and populate its fields
                Account accObj = new Account();
                accObj.Name = csvRecordData[0].trim(); // Name field is mandatory
                accObj.Active__c = csvRecordData[1].trim(); // Active__c field
                accObj.RecordTypeId = csvRecordData[2].trim(); // RecordTypeId field
                accObj.TickerSymbol = csvRecordData[3].trim(); // TickerSymbol field

                // Add the Account object to the list
                acclist.add(accObj);

            } catch (Exception e) {
                // Log any issues with parsing or creating Account records
                System.debug('Error processing row ' + i + ': ' + e.getMessage());
                continue; // Skip to the next row
            }
        }

        // Insert the Account records in bulk
        try {
            insert acclist;
        } catch (DmlException e) {
            // Handle any errors that occur during DML operation
            System.debug('Error inserting accounts: ' + e.getMessage());
        }

        // Return the count of records inserted
        return String.valueOf(acclist.size());
    }
}