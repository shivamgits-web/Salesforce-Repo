global class ContactEmailService implements Messaging.InboundEmailHandler {
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();

        try {
            // Check if the email has attachments
            if (email.binaryAttachments != null && email.binaryAttachments.size() > 0) {
                for (Messaging.InboundEmail.BinaryAttachment attachment : email.binaryAttachments) {
                    if (attachment.mimeTypeSubType.contains('xml')) {  // Process only XML files
                        // Convert the attachment body to a String
                        String xmlContent = EncodingUtil.urlDecode(attachment.body.toString(), 'UTF-8');
                        System.debug('XML Content: ' + xmlContent);

                        // Parse the XML content and create the contact
                        parseAndCreateContact(xmlContent);
                    }
                }
            } else {
                System.debug('No attachments found in the email.');
            }

            result.success = true;
        } catch (Exception e) {
            System.debug('Error: ' + e.getMessage());
            result.success = false;
        }

        return result;
    }

    private void parseAndCreateContact(String xmlContent) {
        try {
           
            Dom.Document doc = new Dom.Document();
            doc.load(xmlContent);
            
            // Extract the contact data from XML
            Dom.XMLNode rootNode = doc.getRootElement();
            Dom.XMLNode dataExtractionNode = rootNode.getChildElement('CM-SFDataExtraction', null);
            Dom.XMLNode contactNode = dataExtractionNode.getChildElement('contact', null);

            // Extract contact fields from the contact node
            String firstName = contactNode.getChildElement('firstName', null).getText();
            String lastName = contactNode.getChildElement('LastName', null).getText();
            String phone = contactNode.getChildElement('Phone', null).getText();
            String email = contactNode.getChildElement('Email', null).getText();

            System.debug('Extracted Contact Data: FirstName=' + firstName + ', LastName=' + lastName + ', Phone=' + phone + ', Email=' + email);

            if (String.isNotBlank(firstName) && String.isNotBlank(lastName) && String.isNotBlank(email)) {
                
                   
                    FreshContact__c contactRecord = new FreshContact__c(
                        Name = firstName,
                        LastName__c = lastName,
                        Email__c = email,
                        Phone__c = phone
                    );
                    Database.upsert(contactRecord,false);
                    System.debug('Contact created successfully with ID: ' + contactRecord.Id);
                
            } else {
                System.debug('Missing required fields. Contact not created.');
            }

        } catch (Exception e) {
            System.debug('Error parsing XML: ' + e.getMessage());
        }
    }
}