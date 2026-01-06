@istest
public class createNewLeadTest {
    @istest
    public static void method1(){
        List<Lead> leadlist=new List<Lead>();
        
        Lead leadRec1=new Lead();
        leadRec1.LastName = 'Test2';
        leadRec1.Company = 'New Company';
        leadRec1.Status = 'Open - Not Contacted';
        leadRec1.LeadSource = 'Web';
        leadRec1.Rating = 'Hot';
        
        Lead leadRec2=new Lead();
        leadRec2.LastName = 'Test2';
        leadRec2.Company = 'Old Company';
        leadRec2.Status = 'Open - Not Contacted';
        leadRec2.LeadSource = 'Web';
        leadRec2.Rating = 'Hot';
        leadlist.add(leadRec1);
        leadlist.add(leadRec2);
        insert leadlist;
        
     
        test.starttest();
        createNewLead.createLead(leadlist);
        test.stoptest();
        
    }

}