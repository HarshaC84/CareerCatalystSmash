@istest
public class IconsControlertestForAccount {
    static testMethod void Icons_Controoler() {
      Account Acc = new Account(Name='test',HIPPA_Out_put__c=true,Active__c=true,SMASH_Alum__c=true,Volunteer__c=true,Special_Handling__c=true,Need_to_qualify__c=true,Disqualified__c=true);
        insert Acc;
        Test.StartTest(); 
        PageReference pageRef = Page.Icons_Showing_Test; 
        pageRef.getParameters().put('id', String.valueOf(Acc.Id)); 
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(Acc);
        Icons_Controoler testAccPlan = new Icons_Controoler(sc);
        Test.StopTest();
    }
}