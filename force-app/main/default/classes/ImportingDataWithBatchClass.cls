global class ImportingDataWithBatchClass implements Database.Batchable<String> {
    private String staticResourceName;

    global ImportingDataWithBatchClass(String staticResourceName) {
        this.staticResourceName = staticResourceName;
    }

    global Iterable<String> start(Database.BatchableContext bc) {
        return new List<String>{'ProcessStaticResource'};
    }

    global void execute(Database.BatchableContext bc, List<String> scope) {
        try {
            // Fetch the static resource
            StaticResource sr = [SELECT Body FROM StaticResource WHERE Name = :staticResourceName ];
            system.debug('Static Resource '+sr);
            
            Blob fileBody = sr.Body;
            system.debug('FileBody '+fileBody);
            
            // Parse CSV
            List<Map<String, String>> parsedData = ExcelUtils.parse(fileBody);
            system.debug('parsedData '+parsedData);
            
            List<Account> accountsToInsert = new List<Account>();

            for (Map<String, String> row : parsedData) {
                Account acc = new Account();
                acc.Name = row.get('Name'); 
                acc.Active__c = row.get('Active__c');
                acc.RecordTypeId = row.get('RecordTypeId');
                acc.TickerSymbol = row.get('TickerSymbol');
                accountsToInsert.add(acc);
            }
            
            system.debug('accountsToInsert'+accountsToInsert);
            if (!accountsToInsert.isEmpty()) {
                insert accountsToInsert;
            }
            
        } catch (Exception e) {
            System.debug('Error processing static resource: ' + e.getMessage());
        }
        
    }

    global void finish(Database.BatchableContext bc) {
        System.debug('Batch process completed.');
    }
}