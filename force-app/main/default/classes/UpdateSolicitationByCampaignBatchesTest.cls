@istest
public class UpdateSolicitationByCampaignBatchesTest {
    public static testmethod void testrun()
    {
        List<Campaign> scopes = new List<Campaign>();
        String CRON_EXP = '0 0 5 * * ?';
        String ZoomID = '45637hgd873bd';
        account acc=new account();
        acc.name='test';
        insert Acc;
        contact con=new contact();
        con.lastname='test';
        con.AccountId=acc.id;
        insert con;
        
        lead l=new lead();
        l.lastname='test';
        l.Company='company';
        l.LeadSource='open - not contacted';
        insert l;     
        campaign cam = new campaign();
        cam.RecordTypeId='012f40000006sTPAAY';
        cam.Name='TestCampaigns';
        cam.Campaign_Source__c='Constant Contact';
        cam.CazoomiId__c=ZoomID;
        insert cam;
        
        campaignmember campmember=new campaignmember();
        campmember.CampaignId=cam.id;
        campmember.ContactId=con.id;
        campmember.CazoomiId__c=cam.CazoomiId__c;
        campmember.LeadId=l.Id;
        campmember.Status='responded';
        insert campmember;
              
        Test.startTest();
        
        String jobId = System.schedule('SolicitationTestClass',  CRON_EXP, new SolicitationUpdateBatchJobsched());
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
        System.assertEquals(CRON_EXP, ct.CronExpression);
        System.assertEquals(0, ct.TimesTriggered);
        Test.stopTest();
       
    }
}