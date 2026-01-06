public class PersonIdExtractor {

    public static void extractPersonIds(String xmlInput) {
        // Parse the XML input
        Dom.Document doc = new Dom.Document();
        doc.load(xmlInput);

        List<String> personIds = new List<String>();
        List<String> c2mAccountIds = new List<String>();

        Dom.XMLNode rootNode = doc.getRootElement();
        List<Dom.XMLNode> cmSfDataExtractionNodes = rootNode.getChildElements();

        for (Dom.XMLNode cmNode : cmSfDataExtractionNodes) {
            if (cmNode.getName() == 'CM-SFDataExtraction') {
                Dom.XmlNode personNode = cmNode.getChildElement('person', null);

                // Extract personId
                String personId = personNode.getChildElement('personId', null).getText();
                personIds.add(personId);

                // Extract c2mAccountIds from each C2MAccount node
                List<Dom.XMLNode> c2mAccountNodes = personNode.getChildElements();
                for (Dom.XMLNode c2mAccountNode : c2mAccountNodes) {
                    if (c2mAccountNode.getName() == 'C2MAccount') {
                        String c2mAccountId = c2mAccountNode.getChildElement('c2mAccountIds', null).getText();
                        c2mAccountIds.add(c2mAccountId);
                    }
                }
            }
        }

        // Log the extracted IDs
        System.debug('Person IDs: ' + personIds);
        System.debug('C2M Account IDs: ' + c2mAccountIds);

        // Create a new Account record
        Account newAccount = new Account();
        newAccount.Name = 'XML Data Account ' + DateTime.now().format('yyyyMMddHHmmss');
        newAccount.Description = 'Account created with XML Data Extraction';
        insert newAccount;

        System.debug('New Account Created: ' + newAccount.Id);

        // Create a dynamic attachment name using the Account name
        String dynamicAttachmentName = newAccount.Name + '_ExtractedData.xml';

        // Create an attachment for the XML input
        Attachment attachment = new Attachment();
        attachment.ParentId = newAccount.Id; // Link to the new Account
        attachment.Name = dynamicAttachmentName; // Dynamic attachment name
        attachment.Body = Blob.valueOf(xmlInput); // Convert XML string to Blob
        attachment.ContentType = 'text/xml';
        insert attachment;

        System.debug('Attachment Created: ' + attachment.Id + ' with Name: ' + dynamicAttachmentName);
    }
}