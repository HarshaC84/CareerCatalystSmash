@isTest
public class ProposalRollupCount_Test {

    @isTest
    public static void testmethods()
    {
         Account a=new Account();
        a.Name='test';
        insert a;
        
        Contact c=new Contact();
        c.LastName='test';
        insert c;
        
        campaign cc = new campaign();
        cc.Name ='test';
        insert cc;
        
         Account a1=new Account();
        a1.Name='test1';
        insert a1;
        
        Contact c1=new Contact();
        c1.LastName='test1';
        insert c1;
        
        campaign cc1 = new campaign();
        cc1.Name ='test1';
        insert cc1;
        
        Profile pp = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        
        User u = new User(Alias = 'standt', Email='standarduser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = pp.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='harshasenapathi123@testorg.com');
        insert u; 

        
        proposal__c p = new proposal__c();
        p.Proposal_Type__c='organization';
        p.Account__c=a.id;
        p.Campaign__c=cc.Id;
        p.Contact__c=null;
        p.Status__c ='Qualification';
        p.Amount_Asked__c=100;
        p.Date_Asked__c=System.today();
        p.Development_Team_Point_Person_1__c=u.Id;
        insert p;
        
        proposal__c p1 = new proposal__c();
        p1.Proposal_Type__c='organization';
        p1.Account__c=a.id;
        p1.Campaign__c=cc.Id;
        p1.Contact__c=null;
        p1.Status__c ='Qualification';
        p1.Amount_Asked__c=100;
        p1.Date_Asked__c=System.today();
        p1.Development_Team_Point_Person_1__c=u.Id;
        insert p1;
       
      //  update p;
       proposal__c p9 = new proposal__c();
        p9.Proposal_Type__c='organization';
        p9.Account__c=a.id;
        p9.Campaign__c=cc.Id;
        p9.Contact__c=null;
        p9.Status__c ='Qualification';
        p9.Amount_Asked__c=100;
        p9.Date_Asked__c=Date.newInstance(2019, 1, 9);
        p9.Development_Team_Point_Person_1__c=u.Id;
        insert p9;
        update p9;
        
       
          proposal__c p7 = new proposal__c();
        p7.Proposal_Type__c='organization';
        p7.Account__c=a.id;
        p7.Campaign__c=null;
        p7.Contact__c=null;
        p7.Status__c ='Qualification';
        p7.Amount_Asked__c=100;
        p7.Date_Asked__c=System.today();
        p7.Development_Team_Point_Person_1__c=u.Id;
        insert p7;
        
        
     //   update p1;
        
          proposal__c p2 = new proposal__c();
        p2.Proposal_Type__c='organization';
        p2.Account__c=a1.id;
        p2.Campaign__c=cc1.Id;
        p2.Contact__c=null;
        p2.Status__c ='Qualification';
        p2.Amount_Asked__c=100;
        p2.Date_Asked__c=System.today();
        p2.Development_Team_Point_Person_1__c=u.Id;
        insert p2;
        
        
      //  update p;
        
        proposal__c p3 = new proposal__c();
        p3.Proposal_Type__c='organization';
        p3.Account__c=a1.id;
        p3.Campaign__c=cc1.Id;
        p3.Contact__c=null;
        p3.Status__c ='Qualification';
        p3.Amount_Asked__c=100;
        p3.Date_Asked__c=System.today();
        p3.Development_Team_Point_Person_1__c=u.Id;
        insert p3;
         update p3;
        p3.Account__c=a.Id;
        p3.Campaign__c=cc.Id;
        update p3;
        delete p3;
        undelete p3;
        
         proposal__c p4 = new proposal__c();
        p4.Proposal_Type__c='Individual';
        p4.Campaign__c=cc.Id;
        p4.Contact__c=c.Id;
         p4.Account__c=null;
        p4.Status__c ='Qualification';
        p4.Amount_Asked__c=100;
        p4.Date_Asked__c=System.today();
        p4.Development_Team_Point_Person_1__c=u.Id;
        insert p4;
     
        
        
         proposal__c p5 = new proposal__c();
        p5.Proposal_Type__c='Individual';
        p5.Campaign__c=cc.Id;
        p5.Contact__c=c.Id;
         p5.Account__c=null;
        p5.Status__c ='Qualification';
        p5.Amount_Asked__c=100;
        p5.Date_Asked__c=System.today();
        p5.Development_Team_Point_Person_1__c=u.Id;
        insert p5;
         update p5;
        p5.Contact__c=c1.Id;
        p5.Campaign__c=cc1.Id;
        update p5;
        delete p5;
        undelete p5;
       
        
        proposal__c p6 = new proposal__c();
        p6.Proposal_Type__c='Individual';
         p6.Contact__c=c.Id;
        p6.Campaign__c=cc.Id;
         p6.Account__c=null;
        p6.Status__c ='Approved';
        p6.Amount_Asked__c=100;
        p6.Date_Asked__c=System.today();
        p6.Development_Team_Point_Person_1__c=u.Id;
        insert p6;
        p6.Campaign__c=cc1.Id;
        update p6;
        p6.Date_Asked__c=system.today()+1;
        update p6;
        
         proposal__c p8 = new proposal__c();
        p8.Proposal_Type__c='organization';
        p8.Account__c=a.Id;
        p8.Campaign__c=cc.Id;
        p8.Contact__c=null;
        p8.Status__c ='Approved';
        p8.Amount_Asked__c=100;
        p8.Date_Asked__c=System.today();
        p8.Development_Team_Point_Person_1__c=u.Id;
        insert p8;
        p8.Campaign__c=cc1.Id;
        update p8;
        p8.Date_Asked__c=Date.newInstance(2019, 12, 9);
        update p8;
        
        
    }
     @isTest
    public static void testmethods1()
    {
         Account a=new Account();
        a.Name='test';
        insert a;
        
        Contact c=new Contact();
        c.LastName='test';
        insert c;
        
        campaign cc = new campaign();
        cc.Name ='test';
        insert cc;
        
         Account a1=new Account();
        a1.Name='test1';
        insert a1;
        
        Contact c1=new Contact();
        c1.LastName='test1';
        insert c1;
        
        campaign cc1 = new campaign();
        cc1.Name ='test1';
        insert cc1;
        
        opportunity opp = new opportunity();
        opp.name='Homer and Marge 2020-07-30';
        opp.StageName='Closed won';
        opp.CloseDate=system.today()+1;
        insert opp;
        
        Profile pp = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        
        User u = new User(Alias = 'standt', Email='standarduser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = pp.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='harshasenapathi123@testorg.com');
        insert u; 
        
       
           proposal__c p1 = new proposal__c();
        p1.Proposal_Type__c='Individual';
        p1.Campaign__c=cc.Id;
        p1.Contact__c=c.Id;
         p1.Account__c=null;
        p1.Status__c ='Qualification';
        p1.Amount_Asked__c=100;
        p1.Date_Asked__c=Date.newInstance(2019, 1, 9);
        p1.Development_Team_Point_Person_1__c=u.Id;
        insert p1;
        update p1;
        
           proposal__c p2 = new proposal__c();
        p2.Proposal_Type__c='Individual';
        p2.Campaign__c=cc.Id;
        p2.Contact__c=c.Id;
         p2.Account__c=null;
        p2.Status__c ='Qualification';
        p2.Linked_Gift__c=opp.id;
        p2.Amount_Asked__c=100;
        p2.Date_Asked__c=Date.newInstance(2019, 1, 9);
        p2.Development_Team_Point_Person_1__c=u.Id;
        insert p2;
        update p2;
        

         proposal__c p4 = new proposal__c();
        p4.Proposal_Type__c='Individual';
        p4.Campaign__c=cc.Id;
        p4.Contact__c=c.Id;
         p4.Account__c=null;
        p4.Status__c ='Qualification';
        p4.Amount_Asked__c=100;
        p4.Date_Asked__c=System.today();
        p4.Development_Team_Point_Person_1__c=u.Id;
        insert p4;
        
         proposal__c p5 = new proposal__c();
        p5.Proposal_Type__c='Individual';
        p5.Campaign__c=cc.Id;
        p5.Contact__c=c.Id;
         p5.Account__c=null;
        p5.Status__c ='Qualification';
        p5.Amount_Asked__c=100;
        p5.Date_Asked__c=System.today();
        p5.Development_Team_Point_Person_1__c=u.Id;
        insert p5;
         update p5;
        p5.Contact__c=c1.Id;
        p5.Campaign__c=cc1.Id;
        update p5;
        delete p5;
        undelete p5;
        
     
    }
}