public class XMLProcessor {
    public static void processXML(String xmlContent) {
        // Parse the XML content
        Dom.Document doc = new Dom.Document();
        doc.load(xmlContent);

        // Get the root element
        Dom.XmlNode rootNode = doc.getRootElement();

        // Lists to hold Account and Contact records
        List<Account> accountList = new List<Account>();
        List<Contact> contactList = new List<Contact>();

        // Map to hold Account Name to Salesforce ID mappings
        Map<String, Id> accountNameToIdMap = new Map<String, Id>();

        // Process child elements of the root
        for (Dom.XmlNode childNode : rootNode.getChildElements()) {
            if (childNode.getName() == 'Account') {
                Account acc = new Account();
                for (Dom.XmlNode fieldNode : childNode.getChildElements()) {
                    String fieldName = fieldNode.getName();
                    String fieldValue = fieldNode.getText();

                    if (fieldName == 'Name') {
                        acc.Name = fieldValue;
                    } else if (fieldName == 'Active__c') {
                        acc.Active__c = fieldValue;
                    } else if (fieldName == 'RecordTypeId') {
                        acc.RecordTypeId = fieldValue;
                    } else if (fieldName == 'TickerSymbol') {
                        acc.TickerSymbol = fieldValue;
                    }
                }
                accountList.add(acc);
            } else if (childNode.getName() == 'Contact') {
                Contact contact = new Contact();
                String accountName = null; // Temporarily store the account name here

                for (Dom.XmlNode fieldNode : childNode.getChildElements()) {
                    String fieldName = fieldNode.getName();
                    String fieldValue = fieldNode.getText();

                    if (fieldName == 'FirstName') {
                        contact.FirstName = fieldValue;
                    } else if (fieldName == 'LastName') {
                        contact.LastName = fieldValue;
                    } else if (fieldName == 'Email') {
                        contact.Email = fieldValue;
                    } else if (fieldName == 'Phone') {
                        contact.Phone = fieldValue;
                    } else if (fieldName == 'AccountId') {
                        accountName = fieldValue; 
                    }
                }
                // Add contact to the list, but AccountId is not set yet
                contactList.add(contact);
            }
        }
        //system.debug('accountName'+accountName);
        
        // Insert Account records
        if (!accountList.isEmpty()) {
            try {
                insert accountList;
                // Populate Account Name to ID map
                for (Account acc : accountList) {
                    accountNameToIdMap.put(acc.Name, acc.Id);
                }
                System.debug('Accounts inserted: ' + accountList);
            } catch (DmlException e) {
                System.debug('Error inserting accounts: ' + e.getMessage());
                return;
            }
        }

        System.debug('accountNameToIdMap: ' + accountNameToIdMap);

        // Update Contact records with the correct AccountId (from Account Name to ID map)
        for (Contact contact : contactList) {
           
            String accountName = contact.AccountId; 
            system.debug('accountNameNew '+accountName);
            
            if (accountName != null && accountNameToIdMap.containsKey(accountName)) {
                contact.AccountId = accountNameToIdMap.get(accountName); // Assign the Salesforce Account ID
            } else {
                contact.AccountId = null; // Handle missing account case, if needed
            }
            
        }

        // Insert Contact records
        if (!contactList.isEmpty()) {
            try {
                upsert contactList;
                System.debug('Contacts inserted: ' + contactList);
            } catch (DmlException e) {
                System.debug('Error inserting contacts: ' + e.getMessage());
            }
        }
    }
}