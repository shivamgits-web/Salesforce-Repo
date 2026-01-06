public class oppProcessor implements Database.Batchable<sObject> {

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([Select id from opportunity]);
    }

    public void execute(Database.BatchableContext bc, List<opportunity> opps) {
        for(opportunity op : opps) {
            op.leadsource = 'Web';
            System.debug(op.Id);
        }
        System.debug('Inside Execute');
        update opps;
    }

    public void finish(Database.BatchableContext bc) {
        System.debug('Processing complete');
    }
}