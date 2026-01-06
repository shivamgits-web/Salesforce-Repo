public with sharing class AccountController {
    public class LookupResult {
        @AuraEnabled public Id recordId { get; set; }
        @AuraEnabled public String recordName { get; set; }
        @AuraEnabled public String recordType { get; set; }

        public LookupResult() {}
        public LookupResult(Id recordId, String recordName, String recordType) {
            this.recordId = recordId;
            this.recordName = recordName;
            this.recordType = recordType;
        }
    }

    @AuraEnabled(cacheable=true)
    public static List<LookupResult> findRecords(String searchKey) {
        String searchTerm = '%' + String.escapeSingleQuotes(searchKey) + '%';
        List<LookupResult> results = new List<LookupResult>();

        for (Account acc : [
            SELECT Id, Name FROM Account
            WHERE Name LIKE :searchTerm
            LIMIT 5
        ]) {
            results.add(new LookupResult(acc.Id, acc.Name, 'Account'));
        }

        for (Lead lead : [
            SELECT Id, Name FROM Lead
            WHERE Name LIKE :searchTerm
            LIMIT 5
        ]) {
            results.add(new LookupResult(lead.Id, lead.Name, 'Lead'));
        }

        return results;
    }
}