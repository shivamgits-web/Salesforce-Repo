public class AccountTriggerHandler {

    private List<Account> newList;
    private List<Account> oldList;
    private Map<Id, Account> newMap;
    private Map<Id, Account> oldMap;

    public AccountTriggerHandler(List<SObject> newList, List<SObject> oldList, Map<Id, SObject> newMap, Map<Id, SObject> oldMap) {
        this.newList = (List<Account>)newList;
        this.oldList = (List<Account>)oldList;
        this.newMap = (Map<Id, Account>)newMap;
        this.oldMap = (Map<Id, Account>)oldMap;
    }

    public void beforeInsert() {
        for (Account acc : newList) {
            acc.Description = 'Auto-set by Trigger Framework on insert';
        }
    }

    public void beforeUpdate() {
        for (Account acc : newList) {
            Account oldAcc = oldMap.get(acc.Id);
            if (acc.Name != oldAcc.Name) {
                acc.Description = 'Name changed, updated by trigger';
            }
        }
    }

    public void afterInsert() {
        // Example: Send a welcome email or create related records
    }

    public void afterUpdate() {
        // Example: Log updates or callout
    }
}