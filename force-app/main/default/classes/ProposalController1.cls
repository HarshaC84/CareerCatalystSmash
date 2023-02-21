public class ProposalController1 {
    public Proposal__c prlist{get;set;}
    // public Proposal__c getPrId{get;set;}
    //List<Proposal__c> PL=new list<Proposal__c>();
    
    public ProposalController1(ApexPages.StandardController controller){
        prlist = [SELECT id,Name,ProposalNameDup__c,Campaign__c,Account__c,Probability__c,Finance_Bucket__c,Proposal_Type__c,Comments1__c,Region__c ,Region1__c,Total_Number_Of_Proposals1__c,Total_Amount_Asked__c,SMASH_Site_Interest__c,Contact__c,Development_Team_Point_Person_1__c,Status__c,Linked_Gift__c,Development_Team_Point_Person_2__c,Comments__c,Deadline__c,Date_Asked__c,Amount_Asked__c,Date_Expected__c,Amount_Expected__c,Date_Approved__c,Amount_Approved__c,IsDecline__c FROM Proposal__c WHERE Id = :ApexPages.currentPage().getParameters().get('id')];
    } 
  
    //Account__c
    /* this.prlist=(Proposal__c)controller.getrecord();
prlist =  [SELECT id,Name,Campaign__c,Proposal_Type__c,Account__c,Contact__c,Development_Team_Point_Person_1__c,Status__c,Linked_Gift__c,Development_Team_Point_Person_2__c,Comments__c,Deadline__c,Date_Asked__c,Amount_Asked__c,Date_Expected__c,Amount_Expected__c,Date_Approved__c,Amount_Approved__c,Total_Number_Of_Proposals__c,Total_Amount_Asked__c FROM Proposal__c where id=:getPrId];
}*/
    
    public PageReference save()
    {
     /*  If(prlist.Status__c =='Declined'){
         ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Record can not be edited as the Status Declined'));
   return null;
} */
        update prlist;
        PageReference pp=new Pagereference('/'+prlist.id);
         pp.setRedirect(true);
         return pp;
    }
    
   
    
    /*public void  displayProposals(){
da=true;
}
public PageReference redirect(){
system.debug('Selected'+selectedPr);
pr = [select id from Proposal__c where id =:selectedPr];
PageReference p=new Pagereference('/'+pr.id);
p.setRedirect(true);
return p;
}*/
    
}