public class updateParentAccount implements Queueable{
    // In Account Object, In Parent Account Field we are passing the record Id.
    public List<account> accList=new List<account>();
    public Id parentId;
    public updateParentAccount(List<account> accs,Id parentAccountId){
           this.accList=accs;
           this.parentId=parentAccountId;
     }
    
    public void execute(QueueableContext qc){
           for(Account acc:this.accList){
               acc.parentId=this.parentId;
               acc.SLA__c='Gold';
               acc.SLAExpirationDate__c=system.today();
               acc.SLASerialNumber__c='a123';
           }
          system.debug('accList=>'+this.accList);
          if(!this.accList.isEmpty()){
                    update this.accList;
          }
   }

}