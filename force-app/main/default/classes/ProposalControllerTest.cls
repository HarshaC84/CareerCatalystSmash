@isTest(SeeAllData=true)
public class ProposalControllerTest {
    

    @isTest
    public static void method1(){
          Account a=new Account();
        a.Name='test';
        insert a;
        
        Contact c=new Contact();
        c.LastName='test';
        insert c;
        
        campaign cc = new campaign();
        cc.Name ='test';
        insert cc;
        
                Profile pp = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        
        User u = new User(Alias = 'standt', Email='standarduser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = pp.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='harshasenapathi123@testorg.com');
        insert u; 
        
         
        opportunity opp = new opportunity();
        opp.name='Homer and Marge 2020-07-30';
        opp.StageName='Closed won';
        opp.CloseDate=system.today()+1;
        insert opp;
        
        
        Proposal__c p1 =new Proposal__c();
        p1.ProposalNameDup__c='test@1';
         p1.Proposal_Type__c='Individual';
        p1.Campaign__c=cc.Id;
        p1.Contact__c=c.Id;
        p1.Region__c='West';
        p1.Region1__c='West';
        p1.Total_Number_Of_Proposals1__c=3;
        p1.Total_Amount_Asked__c=100;
       p1.Comments__c='some comments';
        p1.Status__c ='Qualification';
        p1.Linked_Gift__c=opp.Id;
        p1.Development_Team_Point_Person_2__c=u.Id;
        p1.Date_Approved__c=Date.newInstance(2019, 10, 9);
        p1.Amount_Approved__c=290;
        p1.Deadline__c=Date.newInstance(2019, 14, 9);
       
        p1.Amount_Asked__c=100;
        p1.Date_Asked__c=Date.newInstance(2019, 1, 9);
        p1.Development_Team_Point_Person_1__c=u.Id;
        insert p1;
        
    
        PageReference pageRef = Page.ProposalController2VFpage;
        pageRef.getparameters().put('Id',p1.Id);  
        Test.setCurrentPage(pageRef);
        
     
		Apexpages.StandardController sc = new Apexpages.StandardController(p1);
        ProposalController1 ext = new  ProposalController1(sc);   
        ext.save();  
        //ext.cloneAction();


    }
    
}