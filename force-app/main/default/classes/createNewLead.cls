public class createNewLead {
    public static void createLead(List<Lead> leadRecord){
        for(Lead leadRec:leadRecord){
            leadRec.LeadSource = 'Web';
            leadRec.Rating = 'Hot';
        }
    }
}