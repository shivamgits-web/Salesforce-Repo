public class updateAccRelatedOpp {
    
    public static void beforeAccountUpdate(List<Account> accList, Map<Id,Account> accMap){
        for(Account acc:accList){
            system.debug('New Account'+acc.phone);
            system.debug('Old Account'+accMap.get(acc.Id).phone);
            if(acc.phone != accMap.get(acc.Id).phone){
                acc.Description = 'Account Phone Number is Updated';
            }
            else{
                acc.Description = 'Account Phone Number is Not Updated';
            }
        }
    }
    // When we update the account phone then its related opp. phone no. is updated.
    public static void afterAccRelaOpp(List<Account> accList, Map<Id,Account> mapAcc) {
        //newAcc List mai hum Jo account update ho rhe use add kar rhe hai 
        List<Account> newAcc =new List<Account>(); 
        for(Account acc: acclist){
            if(acc.phone != mapAcc.get(acc.id).phone){
               newAcc.add(acc);    
            }
        }
        system.debug('Updated Phone field Accounts'+newAcc);
        
        List<Opportunity> updatedOppList =new List<Opportunity>(); 
        //opplist mai hum opportunity ko add kr rhe jo updated account ke related hai.
        List<Opportunity> oppList = [Select Id, Phone__c,Account.Phone,AccountId from Opportunity where AccountId IN:newAcc];
        system.debug('Opp list with Updated Accounts'+oppList);
        for(Opportunity newOpp : oppList){
            Opportunity oppN = new Opportunity();
            oppN.Id = newOpp.Id;
            oppN.Phone__c = newOpp.Account.Phone;
            updatedOppList.add(oppN);
        }
        system.debug('Updated Opp List-->>'+updatedOppList);
        update updatedOppList;
        //updatedOppList mai hum jo opp ka phone no. update huo hai usko add kiya maine. 
    }
    
    Public static void afterAccRelaOppUp(List<Account> acclist, Map<Id,Account> oldMap){
        Map<Id,Account> accMap =new Map<Id,Account>();
        for(Account acc:acclist){
            if(acc.phone != oldMap.get(acc.Id).phone){
                accMap.put(acc.Id,acc);
            }
        }
        
        set<Id> mapId = accMap.keySet();
        List<Opportunity> oppList = [Select Id, Phone__c,Account.Phone,AccountId from Opportunity where AccountId IN:mapId];
        List<Opportunity> oppUpdateList = new List<Opportunity>(); 
        for(Opportunity opp:oppList){
            Opportunity op = new Opportunity();
            op.Id = opp.Id;
            op.Phone__c = opp.Account.Phone;
            oppUpdateList.add(op);
        }
        update oppUpdateList;
        
    }
    
    public static void accountInsert(List<Account> accList){
        for(Account acc: accList){
            if(acc.Industry=='Banking'){
                acc.Rating='hot';
                acc.Active__c='Yes'; 
            }else{
                acc.Rating='warm';
                acc.Active__c='Yes'; 
            }
        }
    }
    
    public static void AccountBeforeDelete(List<Account> acclist){
        for(Account acc : acclist){
            if(acc.Active__c == 'Yes'){
                acc.addError('We can not delete the account when account is Active');
            }
            
        }
    }
}