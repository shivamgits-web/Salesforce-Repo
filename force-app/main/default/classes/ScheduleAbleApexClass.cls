public class ScheduleAbleApexClass implements schedulable{
    
    public void execute(SchedulableContext sc){
        Database.executeBatch(new TestScheduleBatch());
    }
}