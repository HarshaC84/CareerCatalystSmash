public class ProposalController {
   public Proposal__c p{get;set;}
    
    
   // public set<id>accid{get;set;}
   // list<id>plist=new list<id>();
  //  public string noofProposals{get;set;}
    
    // public string pVal{get;set;}
  //  @AuraEnabled
 /*    public static Proposal__c save(Proposal__c p)
    {
        insert p;
        return p;
    }
    
   //  @AuraEnabled
    public static Id saveDetails(Proposal__c regForm1){
        // DML operation to save Account Details   
        INSERT regForm1;
        return regForm1.Id; 
    } 
    
    public String prVal{get;set;}
   public ProposalController(){
        p=new Proposal__c(); 
         
        }
     
    public ProposalController(ApexPages.StandardController controller) {
        this.p=(Proposal__c)controller.getrecord();
        system.debug('the proposal elements:'+p);
    }
    
    public PageReference save(){  
       
        insert P;
        
        
        PageReference pg = new PageReference('/'+P.id);
        pg.setRedirect(true);
        return pg;
    }   
    public PageReference cancel(){         
        
        PageReference pg = new PageReference('/lightning/o/Proposal__c/list');
        pg.setRedirect(true);
        return pg;
    }   
    
    
    
   
    /* public pageReference save(){
p=new Proposal__c();
insert P;
PageReference pg = new PageReference('/lightning/r/Proposal__c/='+p.id);
pg.setRedirect(true);
return pg;
}*/ 
    
     public ProposalController(ApexPages.StandardController controller){
        p = [SELECT id,Name,Campaign__c,Account__c,Proposal_Type__c,Region__c ,Region1__c,Total_Number_Of_Proposals1__c,Total_Amount_Asked__c,SMASH_Site_Interest__c,Contact__c,Development_Team_Point_Person_1__c,Status__c,Linked_Gift__c,Development_Team_Point_Person_2__c,Comments__c,Deadline__c,Date_Asked__c,Amount_Asked__c,Date_Expected__c,Amount_Expected__c,Date_Approved__c,Amount_Approved__c,IsDecline__c FROM Proposal__c WHERE Id = :ApexPages.currentPage().getParameters().get('id')];
    } 
  
    //Account__c
    /* this.prlist=(Proposal__c)controller.getrecord();
prlist =  [SELECT id,Name,Campaign__c,Proposal_Type__c,Account__c,Contact__c,Development_Team_Point_Person_1__c,Status__c,Linked_Gift__c,Development_Team_Point_Person_2__c,Comments__c,Deadline__c,Date_Asked__c,Amount_Asked__c,Date_Expected__c,Amount_Expected__c,Date_Approved__c,Amount_Approved__c,Total_Number_Of_Proposals__c,Total_Amount_Asked__c FROM Proposal__c where id=:getPrId];
}*/
    
    public PageReference save()
    {
  /*     If(p.Status__c =='Declined'){
          ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Record can not be edited as the Status Declined'));
   return null;
} */
        update p;
        PageReference pp=new Pagereference('/'+p.id);
         pp.setRedirect(true);
         return pp;
    }
    
   public PageReference newp(){         
        
        PageReference pg = new PageReference('/apex/proposalVf');
        pg.setRedirect(true);
        return pg;
    }  
    
    
    
}