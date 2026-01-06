global class batchClass implements Database.Batchable<SObject> {

    global Database.QueryLocator start(Database.BatchableContext BC) {
        
        String query = 'SELECT Id, Body, Name FROM StaticResource ORDER BY CreatedDate DESC LIMIT 1';
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<StaticResource> accList) {
        if (!accList.isEmpty()) {
            
            String staticResourceName = accList[0].Name;
            system.debug('staticResourceName'+staticResourceName);
            
            CSVControllerNewData.loadCSVDataFromStaticResourceData(staticResourceName);
        }
    }

    global void finish(Database.BatchableContext bc) {
       
    }

}