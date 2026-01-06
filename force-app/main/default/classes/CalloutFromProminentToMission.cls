public class CalloutFromProminentToMission {
    
    public static void sendCalloutRequest(){
        
        Http ht=new Http();
        HttpRequest req=new HttpRequest();
        req.setEndPoint('callout:MissionProminent/services/data/v60.0/sobjects/Account');
        req.setMethod('POST');
        req.setHeader('Content-type','application/json');
        req.setBody('{"Name":"This is Data from Prominent Org"}');
        HttpResponse res = ht.send(req);
        system.debug('Res-->>'+res.getBody());
        
    }

}