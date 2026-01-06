global class InsertEmployeesBatch implements Database.Batchable<Integer>, Database.Stateful {

    // Total records to insert
    global static final Integer TOTAL_RECORDS = 60000;

    // Start method
    global Iterable<Integer> start(Database.BatchableContext bc) {
        List<Integer> counterList = new List<Integer>();
        for (Integer i = 1; i <= TOTAL_RECORDS; i++) {
            counterList.add(i);
        }
        return counterList;
    }

    // Execute method (runs in batches)
    global void execute(Database.BatchableContext bc, List<Integer> scope) {
        List<Employees__c> empList = new List<Employees__c>();

        for (Integer i : scope) {
            empList.add(new Employees__c(
                Name = 'Shivam' + i,
                Rating__c = 'Average'
            ));
        }

        if (!empList.isEmpty()) {
            insert empList;
        }
    }

    // Finish method
    global void finish(Database.BatchableContext bc) {
        System.debug('✅ Employee batch insert completed successfully');
    }
}