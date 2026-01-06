public class salesforceIntegrationClass {
    
@future(callout=true)
public static void getDetails(){
        
        HttpRequest req=new HttpRequest();
        req.setEndpoint('callout:Salesforce_to_Salesforce_Integration/services/apexrest/Account/');
        req.setMethod('GET');
        req.setHeader('Content-type','application/json; charset=UTF-8');
        req.setHeader('Accept','application/json');
        
        Http http=new Http(); 
        HttpResponse res=http.send(req);
        system.debug('Get Response is '+res.getBody());
        if(res.getStatusCode()==200){
            system.debug('Response is '+res.getBody());
        }
    }
    
    @future(callout=true)
    public static void createRecord(){
        
        HttpRequest req=new HttpRequest();
        req.setEndpoint('callout:Salesforce_to_Salesforce_Integration/services/apexrest/Account/');
        req.setHeader('Content-type','application/json; charset=UTF-8');
        req.setHeader('Accept','application/json');
        
        req.setBody('{"accountName":"Account Noob"}');
        req.setMethod('POST');
        
        Http http=new Http(); 
        HttpResponse res=http.send(req);
        system.debug('Get Response is '+res.getBody());
        if(res.getStatusCode()==200){
            system.debug('Response is '+res.getBody());
        }
    }
    @future(callout=true)
   public static void updateRecord(String jsonData) {
    // Deserialize the JSON string back into a list of Account objects
    system.debug('Class is Called');
    List<Account> acclist = (List<Account>) JSON.deserialize(jsonData, List<Account>.class);
    
    if (acclist != null && !acclist.isEmpty()) {
        for (Account acc : acclist) {
            // Ensure MemberRESNumber__c is not null before making the request
            Decimal memberRESNumber = acc.MemberRESNumber__c;
            
            if (memberRESNumber != null) {
                // Construct the request body
                Map<String, Object> requestBodyMap = new Map<String, Object>{
                    'MemberRESNumber__c' => memberRESNumber,
                    'Rating' => acc.Rating,
                    'AccountSource' => acc.AccountSource  // Assuming you want to update this too
                };
                
                String requestBody = JSON.serialize(requestBodyMap);
                
                HttpRequest req = new HttpRequest();
                req.setEndpoint('callout:Salesforce_to_Salesforce_Integration/services/apexrest/Account/' + memberRESNumber);
                req.setHeader('Content-type', 'application/json; charset=UTF-8');
                req.setHeader('Accept', 'application/json');
                req.setBody(requestBody);
                req.setMethod('PUT');  // Method is PUT to perform update
                
                try {
                    Http http = new Http();
                    HttpResponse res = http.send(req);
                    System.debug('PUT Response for MemberRESNumber ' + memberRESNumber + ': ' + res.getBody());

                    if (res.getStatusCode() != 200) {
                       System.debug('Failed with status code: ' + res.getStatusCode() + ' and body: ' + res.getBody());
                    }
                } catch (Exception e) {
                    
                    System.debug('HTTP callout failed: ' + e.getMessage());
                }
            }
        }
    }
}
    
    

}