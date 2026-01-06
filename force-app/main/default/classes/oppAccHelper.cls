Public class oppAccHelper{

   public static void accountHelper(List<Account> accList) {
          // Collect the Account Ids being deleted
             Set<Id> accountIds = new Set<Id>();
             for (Account acc : accList) {
                 accountIds.add(acc.Id);
              }

        // Query and delete the related Opportunities
           List<Opportunity> opportunitiesToDelete = [SELECT Id FROM Opportunity WHERE AccountId IN :accountIds];
    
           if (!opportunitiesToDelete.isEmpty()) {
              delete opportunitiesToDelete;
              }
       }
    
}