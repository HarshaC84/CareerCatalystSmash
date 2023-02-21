public class ProposalCloneController {
  public Proposal__c prlist{get;set;}
    // public Proposal__c getPrId{get;set;}
    //List<Proposal__c> PL=new list<Proposal__c>();
    
   public ProposalCloneController(ApexPages.StandardController controller){
       
       prlist = [SELECT id,Name,ProposalNameDup__c,Campaign__c,Account__c,Probability__c,Finance_Bucket__c,Proposal_Type__c,Region__c,Comments1__c,Region1__c,Total_Number_Of_Proposals1__c,Total_Amount_Asked__c,SMASH_Site_Interest__c,Contact__c,Development_Team_Point_Person_1__c,Status__c,Linked_Gift__c,Development_Team_Point_Person_2__c,Comments__c,Deadline__c,Date_Asked__c,Amount_Asked__c,Date_Expected__c,Amount_Expected__c,Date_Approved__c,Amount_Approved__c,IsDecline__c FROM Proposal__c WHERE Id = :ApexPages.currentPage().getParameters().get('id')];
       
    } 
    
  
    //Account__c
    /* this.prlist=(Proposal__c)controller.getrecord();
prlist =  [SELECT id,Name,Campaign__c,Proposal_Type__c,Account__c,Contact__c,Development_Team_Point_Person_1__c,Status__c,Linked_Gift__c,Development_Team_Point_Person_2__c,Comments__c,Deadline__c,Date_Asked__c,Amount_Asked__c,Date_Expected__c,Amount_Expected__c,Date_Approved__c,Amount_Approved__c,Total_Number_Of_Proposals__c,Total_Amount_Asked__c FROM Proposal__c where id=:getPrId];
}*/
    
    public PageReference cloneAction()
    {
         Proposal__c p =new proposal__c();
         p = prlist.clone(false,false,false,false);
        insert p;
       
        PageReference pp=new Pagereference('/'+p.id);
         pp.setRedirect(true);
         return pp;
    }
    

}