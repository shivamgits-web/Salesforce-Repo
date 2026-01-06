public class DailyOppProcessor implements Schedulable{
    Public void execute(SchedulableCOntext sc){
       List<Opportunity> oppList=[Select id,leadSource from Opportunity];
                for(Opportunity opp:oppList){
                        opp.leadsource='Web';
                     }
               if(!oppList.isEmpty()){
                     Update oppList;
                   }
               }
           }