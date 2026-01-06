public class contactHandlerClass {
    
    public static void duplicateContactPrevent(List<Contact> conlist) {
        
        Set<String> emailRecord = new Set<String>();
        Set<String> phoneRecord = new Set<String>();
        Map<String, Contact> existingContactsMap = new Map<String, Contact>();
        Map<String, Contact> existingContactsMp = new Map<String, Contact>();
        
        // Collect emails from incoming contacts
        if (conlist != null && !conlist.isEmpty()) {
            for (Contact con : conlist) {
                if (con.Email != null) {
                    emailRecord.add(con.Email.toLowerCase());// Using lowercase for case-insensitive matching
                }
                if(con.Phone != null){
                    phoneRecord.add(con.Phone);
                }
            }
        }
        
        // Query existing contacts with the same emails
        if (!emailRecord.isEmpty() || !phoneRecord.isEmpty()) {
            List<Contact> conData = [
                SELECT Id, Email, Phone 
                FROM Contact 
                WHERE Email IN :emailRecord OR Phone IN :phoneRecord
            ];
            
            // Store queried contacts in a map for quick lookup
            for (Contact existingCon : conData) {
                existingContactsMap.put(existingCon.Email.toLowerCase(), existingCon);
                existingContactsMp.put(existingCon.Phone.toLowerCase(), existingCon);
            }
        }
        
        // Check for duplicates in the incoming list and add errors
        for (Contact con : conlist) {
            if (con.Email != null && existingContactsMap.containsKey(con.Email.toLowerCase())) {
                con.addError('Email already exists in the system.');
            }
            if (con.Phone != null && existingContactsMp.containsKey(con.Phone)) {
                con.addError('Phone is already exists in the system.');
            }
        }
    }
}