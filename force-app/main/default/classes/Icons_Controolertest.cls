@istest
public class Icons_Controolertest {
	static testMethod void Icons_Controoler() 
	{
     String strRecordTypeId = [Select Id From RecordType Where SobjectType = 'Account' and Name = 'Household Account'].Id;
     account acc=new account(name='test',Do_Not_Contact__c=true,SMASH_Alum__c=true,
                                 HIPPA_Out_put__c=true,Active__c=true,RecordTypeId=strRecordTypeId);
        insert acc;
        Test.StartTest(); 
        PageReference pageRef = Page.Icons_Showing_Test; 
        pageRef.getParameters().put('id', String.valueOf(acc.Id)); 
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        Icons_Controoler testAccPlan = new Icons_Controoler(sc);
        Test.StopTest();
    }
}