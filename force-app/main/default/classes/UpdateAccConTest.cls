@isTest 
public class UpdateAccConTest{
    public  static testMethod void myTest(){
        account acc = new account();
        acc.name ='test';
        acc.Active__c=false;
        acc.Largest_Gift_Date__c=system.today();
        // acc.Largest_Gift_Amount__c=12;
        acc.RecordTypeId='012f40000006sTMAAY';   
        insert acc;
        acc.name ='test';
        update acc;
        contact con = new contact();
        con.lastname='test1';
        con.Largest_Gift_Date__c=system.today();
        //con.Largest_Gift_Amount__c=15;
        con.AccountId=acc.Id;
        insert con;
        campaign cam =new campaign();
        cam.name='2012 test campaign';
        insert cam;
        opportunity opp = new opportunity();       
        opp.name='test';
        opp.amount=1;
        opp.RecordTypeId='012f40000006sTOAAY';
        opp.StageName='closed won';
        opp.ContactId=con.Id;
        opp.AccountId=acc.Id;
        opp.CampaignId=cam.id;
        opp.CloseDate = system.today();
        insert opp;
    }
}