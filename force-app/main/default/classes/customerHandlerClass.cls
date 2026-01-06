public class customerHandlerClass {
    
    // 1. When user create a customer record, if industry is IT then age should be greater than 34, otherwise will
    // through the error.
    // 2. While creating the Customer record fill the duplicate customer field by Owner Name of the record.
    
    public static void customerValidate(List<Customer__c> custList){
        
                    Set<Id> ownerIds = new Set<Id>();
                    for(Customer__c custNew: custList){
                          ownerIds.add(custNew.OwnerId);
                          }
    
                 // Query to get User info based on the OwnerIds set
                 // Always it will give the list of record.
           
                 List<User> userInfoList = [SELECT Id, Name FROM User where Id IN :ownerIds];
                  
                 // Convert List<User> to Map<Id, User>
                 Map<Id, User> userInfoMap = new Map<Id, User>();
                 for(User user : userInfoList){
                          userInfoMap.put(user.Id, user);
                }

               for(Customer__c cust: custList){
                   if(cust.Industry__c == 'IT' && cust.Age__c < 34){
                           cust.Age__c.addError('Please enter the age greater than 34');
                   }
        
                User userInfoN = userInfoMap.get(cust.OwnerId); // Use OwnerId to get corresponding User
                     if(userInfoN != null){
                         cust.Duplicate_Customer__c = userInfoN.Name;
                   }
              }
}

    
    public static void customerData(List<Customer__c> custLists, Map<Id,Customer__c> oldMap){
        for(Customer__c cust : custLists){
            if(cust.Name != oldMap.get(cust.Id).Name){
                cust.addError('You can not change the customer Name.');
                
            }
        }
    }
    
    public static void deleteCustomer(List<Customer__c> custListOld){
        
        List<Messaging.singleEmailMessage> emailList=new List<Messaging.singleEmailMessage>(); 
        for(Customer__c custList:custListOld){
            Messaging.singleEmailMessage email=new Messaging.singleEmailMessage();
            email.setToAddresses(new string[] {userInfo.getUserEmail()});
            email.setSubject('Customer is deleted');
            email.setPlainTextBody('Hi,record is deleted');
            emailList.add(email);
        }
        Messaging.sendEmail(emailList);
        
    }
    
    
    
}