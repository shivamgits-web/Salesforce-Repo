public class contactManager {
    
    public static Map<String,List<Contact>> conAccManager(List<Contact> conlist) {
        Map<String,List<Contact>> conMap =new Map<String,List<Contact>>();
          
        for (Contact confor:conlist) {
            String accName=confor.Account.name;
            // Include the Account field in the SOQL query
            List<Contact> conList2=[SELECT Id,FirstName,Account.Name FROM Contact WHERE Account.Name =:accName];
            conMap.put(accName, conList2);
        }
        System.debug(conMap);
        return conMap;
    }
}

//List<Contact> accList = [Select Id,firstName,Account.Name from Contact];
//Map<String,List<Contact>> mapCon = contactManager.conAccManager(accList);