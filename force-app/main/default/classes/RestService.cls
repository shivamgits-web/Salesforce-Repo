@RestResource(urlMapping='/CreateAccount/*')
// We do not have to say to the third party system which class/Method they have to call
// Just give the urlMapping Name.
// * -->> End 
global class RestService {
    
    // In One webservice, only one get, post, delete, patch, put
    // User will pass name, rating, industry and website. Service will create an account and 
    // will return the id of the account
    @HTTPPOST
    global static string createAccounts(String inputName, String inputRating, String inputWebsite){
        
        account acc = new account(name=inputName,rating=inputRating, website=inputWebsite);
        Database.saveResult sr = Database.insert(acc);
        if(sr.isSuccess()){
            
            system.JSONGenerator js=JSON.createGenerator(true);
            js.writeStartObject();
            js.writeStringField('Status','Success');
            js.writeStringField('ID', acc.Id);
            js.writeEndObject();
            return js.getAsString();
        }
        else{
            
            system.JSONGenerator js=JSON.createGenerator(false);
            js.writeStartObject();
            js.writeStringField('Status','Validation Fail');
            js.writeEndObject();
            return js.getAsString();   
        }
        
    }

}