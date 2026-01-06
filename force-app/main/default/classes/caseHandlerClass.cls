public class caseHandlerClass {
    
    public static void caseCountMethod(List<Case> caseList) {
        // Step 1: Collect Account IDs from the case list
        Set<Id> accountIds = new Set<Id>();
        if (caseList != null && !caseList.isEmpty()) {
            for (Case ca : caseList) {
                if (ca.AccountId != null) {
                    accountIds.add(ca.AccountId);
                }
            }
        }
        
        // Step 2: Query the related Account records
        List<Account> accRecord = [SELECT Id FROM Account WHERE Id IN :accountIds];
        
        // Step 3: Aggregate results to get total cases and 'New' status cases for each Account
        List<AggregateResult> caseResults = [
            SELECT AccountId, 
                   COUNT(Id) totalCases
            FROM Case 
            WHERE AccountId IN :accountIds 
            GROUP BY AccountId
        ];
        
        List<AggregateResult> caseNewResults = [
            SELECT AccountId, 
                   COUNT(Id) totalNewCases
            FROM Case 
            WHERE AccountId IN :accountIds AND Status = 'New'
            GROUP BY AccountId
        ];

        // Step 4: Maps to store the aggregated case counts
        Map<Id, Decimal> totalCaseCountMap = new Map<Id, Decimal>();
        Map<Id, Decimal> newCaseCountMap = new Map<Id, Decimal>();

        for (AggregateResult ret : caseResults) {
            totalCaseCountMap.put((Id) ret.get('AccountId'), (Decimal) ret.get('totalCases'));
        }
        
        for (AggregateResult result : caseNewResults) {
            newCaseCountMap.put((Id) result.get('AccountId'), (Decimal) result.get('totalNewCases'));
        }

        // Step 5: Prepare the list of Account records to update
        List<Account> updateAccountRecords = new List<Account>(); 
        for (Account acc : accRecord) {
            Decimal totalCases = totalCaseCountMap.get(acc.Id);
            Decimal newCasesCount = newCaseCountMap.get(acc.Id);

            // Set the custom fields with the case counts
            //acc.NumberOfCaseCount__c = totalCases != null ? totalCases : 0;
            //acc.Number_of_New_Case__c = newCasesCount != null ? newCasesCount : 0;
            
            updateAccountRecords.add(acc);
        }

        // Step 6: Update the Account records if there are any to update
        if (!updateAccountRecords.isEmpty()) {
            try {
                update updateAccountRecords;
            } catch (DmlException e) {
                // Optional: Handle any errors during the update process
                System.debug('Error updating Accounts: ' + e.getMessage());
            }
        }
    }
}