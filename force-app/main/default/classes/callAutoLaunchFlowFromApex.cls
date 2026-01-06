public class callAutoLaunchFlowFromApex {
    
    public static void callContactFlow(Id AccountId){
        Map<String, Object> flowInputs = new Map<String, Object>();
        flowInputs.put('recordId',AccountId);

        // Create a new flow instance
       Flow.Interview flowInstance = new Flow.Interview.AutoLaunchedFlowToUpdateContacts(flowInputs);

       // Start the flow
       flowInstance.start();        
    }
}