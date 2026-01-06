public class PerformanceReportBatch implements Database.Batchable<SObject> {

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([
            SELECT Id, Employee_Performance_Score__c,Aggregated_performance_metrics__c
            FROM Employee__c
        ]);
    }

    public void execute(Database.BatchableContext bc, List<Employee__c> employeeList) {
        system.debug('Employee List is '+employeeList);
        
        Decimal totalPerformanceScore = 0;
        Integer totalEmployeeCount = 0;

        
        for (Employee__c emp : employeeList) {
            if (emp.Employee_Performance_Score__c != null) {
                totalPerformanceScore += emp.Employee_Performance_Score__c;
                totalEmployeeCount++;
            }
        }
         system.debug('Total Perfromance Score'+totalPerformanceScore);
         system.debug('Total Employee Count'+totalEmployeeCount);
        
        // Calculate the average score
        Decimal averageScore = totalEmployeeCount > 0 ? totalPerformanceScore / totalEmployeeCount : 0;
        
        system.debug('Average Score is'+averageScore);
        
        // Update all Employee__c records with the average score
        for (Employee__c emp : employeeList) {
            emp.Aggregated_performance_metrics__c = averageScore;
        }

        update employeeList;
    }

    public void finish(Database.BatchableContext bc) {
        System.debug('Batch Class is completed');
    }
}