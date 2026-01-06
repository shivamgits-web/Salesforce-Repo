public class TicketPricing {
    public static String calculateTicketPrice(Integer Age){
        String str1 = 'Ticket Price is 5 Doller';
        String str2 = 'Ticket Price is 10 Doller';
        String str3 = 'Ticket Price is 7 Doller';
            
        if(Age <=12){
            return str1;
        }
        else if(Age > 12 && Age <= 64 ){
            return str2;
        }
        else 
        {
            return str3;
        }
}
    
}

//String TicketPrice = TicketPricing.calculateTicketPrice(65);
//system.debug('Ticket Price is '+ TicketPrice);