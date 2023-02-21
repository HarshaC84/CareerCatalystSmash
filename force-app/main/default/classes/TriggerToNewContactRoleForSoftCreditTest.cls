@istest
public class TriggerToNewContactRoleForSoftCreditTest {
   public static testmethod void test(){
       //   Id RecordTypeIdaccount = Schema.SObjectType.account.getRecordTypeInfosByName().get('Organization').getRecordTypeId();
       //   Id RecordTypeIdOpportunity = Schema.SObjectType.opportunity.getRecordTypeInfosByName().get('donation').getRecordTypeId();        
       
       account acc = new account();
       acc.name ='test';
       acc.Active__c=false;
       acc.Largest_Gift_Date__c=system.today();
       acc.recordtypeid='012f40000006sTNAAY';  
       insert acc;
       
       contact con = new contact();
       con.lastname='test1';
       con.Largest_Gift_Date__c=system.today();
       con.AccountId=acc.Id;
       insert con;
       
       contact con1 = new contact();
       con1.lastname='test2';
       con1.Largest_Gift_Date__c=system.today();
       insert con1;
       contact con2 = new contact();
       con2.lastname='test3';
       con2.Largest_Gift_Date__c=system.today();
       insert con2;
       
       opportunity opp = new opportunity();      
       opp.name='test';
       opp.amount=1;
       opp.recordtypeid='012f40000006sTOAAY';
       opp.StageName='closed won';
       opp.ContactId=con.Id;
       opp.AccountId=acc.Id;
       opp.Soft_Credit__c=con.id;
       opp.CloseDate = system.today();
       insert opp;
       
       opp.Soft_Credit__c=con1.id;
       Test.startTest();      
       update opp; 
       
       opportunity opp1 = new opportunity();      
       opp1.name='test';
       opp1.amount=1;
       opp1.recordtypeid='012f40000006sTOAAY';
       opp1.StageName='closed won';
       opp1.ContactId=con.Id;
       opp1.AccountId=acc.Id;
       //opp1.Soft_Credit__c=con.id;
       opp1.CloseDate = system.today();
       opp1.Soft_Credit__c=null;
       insert opp1;
       
       opp1.Soft_Credit__c=con1.id;
       //Test.startTest();      
       update opp1;
       //Test.stopTest();
       
       
   }
}