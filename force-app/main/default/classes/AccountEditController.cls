public class AccountEditController {

    public Account acc { get; set; }

    public AccountEditController(ApexPages.StandardController stdController) {
        acc = (Account)stdController.getRecord();
    }

    public PageReference saveAccount() {
        try {
            update acc;
            ApexPages.addMessage(
                new ApexPages.Message(
                    ApexPages.Severity.CONFIRM,
                    'Account updated successfully'
                )
            );
        } catch (Exception e) {
            ApexPages.addMessage(
                new ApexPages.Message(
                    ApexPages.Severity.ERROR,
                    e.getMessage()
                )
            );
        }
        return null;
    }
}