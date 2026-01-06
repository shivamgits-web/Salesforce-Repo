public with sharing class AccountRecordTypeController {
    @AuraEnabled(cacheable=true)
    public static List<Map<String, String>> getAccountRecordTypes() {
        List<Map<String, String>> result = new List<Map<String, String>>();
        for (RecordType rt : [SELECT Id, Name FROM RecordType WHERE SObjectType = 'Account']) {
            result.add(new Map<String, String>{
                'label' => rt.Name,
                'value' => rt.Id
            });
        }
        return result;
    }
}