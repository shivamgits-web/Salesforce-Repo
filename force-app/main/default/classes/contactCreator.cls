public class contactCreator {
    
    public static void contactNewCon(String LastName, String Email){
        
        Contact con = new Contact();
        con.LastName = LastName;
        con.Email = Email;
        insert con;
       }

}