// Apex class: RestCallout
// Developer Name: Shivam Lachure

public class RestCallOut {
    
    public static void callme(String pin){
        
        HTTPRequest req = new HTTPRequest(); // Request
        req.setEndPoint('https://api.postalpincode.in/pincode/'+pin);
        req.setMethod('GET');

        HTTP ht=new HTTP(); // Send 
        HTTPResponse resp = ht.send(req);

        system.debug('Respone-->>'+resp.getBody());
        
        wrap output=new wrap();
        String out=resp.getBody();
        out=out.subString(1,out.length()-1);
        Output=(wrap)JSON.deserialize(out, wrap.class);  
        
        system.debug('Message-->>'+Output.message);
        system.debug('Status-->>'+Output.status);
        system.debug('PostOffice-->>'+Output.PostOffice[0].Name);
        system.debug('PostOffice-->>'+Output.PostOffice[0].District);
        system.debug('PostOffice-->>'+Output.PostOffice[0].Division);
             
    }



public class wrap{
     
    public string message;
    public string status;
    public List<PO> PostOffice;
    
}

public class po{
    
    public string Name;
    public string BranchType;
    public string DeliveryStatus;
    public string Circle;
    public string District; 
    public string Division;
    public string Block;
    public string State;
    public string Country; 
    public string Pincode;
    public string Region;
}
    
}