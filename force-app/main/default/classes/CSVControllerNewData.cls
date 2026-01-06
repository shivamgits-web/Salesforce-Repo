public with sharing class CSVControllerNewData {

    
    public static String loadCSVDataFromStaticResourceData(String staticResourceName) {

        StaticResource staticResource = [SELECT Body FROM StaticResource WHERE Name = :staticResourceName LIMIT 1];
        String data = staticResource.Body.toString();
        List<Account> acclist = new List<Account>();
        String[] csvFileLines = data.split('\n');
        
        for (Integer i = 1; i < csvFileLines.size(); i++) {
            
            String[] csvRecordData = csvFileLines[i].split(',');

            if (csvRecordData.size() < 4 || csvRecordData[0].trim() == '') {
                continue;
            }

            try {
                Account accObj = new Account();
                accObj.Name = csvRecordData[0].trim(); 
                accObj.Active__c = csvRecordData[1].trim(); 
                accObj.RecordTypeId = csvRecordData[2].trim(); 
                accObj.TickerSymbol = csvRecordData[3].trim(); 
                acclist.add(accObj);

            } catch (Exception e) {
                System.debug('Error processing row ' + i + ': ' + e.getMessage());
                continue;
            }
        }

        try {
            system.debug('Record is inserted');
            system.debug('acclist');
            insert acclist;
        } catch (DmlException e) {
            System.debug('Error inserting accounts: ' + e.getMessage());
        }
        return String.valueOf(acclist.size());
    }
}