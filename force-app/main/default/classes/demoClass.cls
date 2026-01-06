public class demoClass {
    
    public static void showAccount(){
        List<Account> Acclist = [Select id, Name from Account];
        System.debug('Accounts records are: '+Acclist);
        
        List<String> frndsList = new List<string>();
        frndsList.add('Shivam');
        frndsList.add('Ganesh');
        frndsList.add('Shivam'); 
        System.debug('Friends Name List: '+frndsList); // Allowing the Duplicates Record
        
        Set<String> frndsSet = new Set<string>();
        frndsSet.add('Shivam');
        frndsSet.add('Ganesh');
        frndsSet.add('Pawan'); 
        System.debug('Friends Name Set 1: '+frndsSet); // Not Allowing the Duplicates Records
        System.debug('Friends Name Set:2: '+frndsSet+frndsList);
        
        Map<Integer, String> friendsMap = new Map<Integer, String>();
        friendsMap.put(1, 'Shivam');
        friendsMap.put(2, 'Shiva');
        friendsMap.put(3, 'Jay');
        friendsMap.put(4, 'Jaywant');
        
        System.debug('Friends Map 1 is '+friendsMap);
        
        friendsMap.put(1, 'Kumar');
        System.debug('Friends Map 2 is '+friendsMap);
        System.debug('Friends Map 3 is '+friendsMap.values());
        System.debug('Friends Map 4 is '+friendsMap.keySet());
        System.debug('Friends Map 5 is '+friendsMap.get(2));
        friendsMap.remove(2);
        System.debug('Friends Remove Map 6 is '+friendsMap);
        
        
    }

}