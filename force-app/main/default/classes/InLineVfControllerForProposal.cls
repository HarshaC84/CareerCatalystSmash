public class InLineVfControllerForProposal {
   public Proposal__c acc {get;set;}
 //  public string accId {get;set;}
//   public String contId {get;set;}
   public InLineVfControllerForProposal (ApexPages.StandardController controller){
       acc = (Proposal__c) controller.getRecord();
       
       if(acc != null && acc.Id != null) {
           acc = [Select Id, Name,Status__c,Account__c,Proposal_Type__c,Contact__c,Linked_Gift__c from Proposal__c where Id =: acc.Id];
           // Account__c,
                       }}
                          }