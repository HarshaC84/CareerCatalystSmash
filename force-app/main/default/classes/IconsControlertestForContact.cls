@istest
public class IconsControlertestForContact {
    static testMethod void IconsForContact() {
      contact con = new contact(FirstName='test',lastname='dileep',Board_Committee__c=true,Donor__c=true,npsp__Do_Not_Contact__c=true,SMASH_Alum__c=true,Volunteer__c=true,Special_Handling__c=true,Need_to_qualify__c=true,Disqualified__c=true);
        insert con;
        Test.StartTest(); 
        PageReference pageRef = Page.IconsFroContact; 
        pageRef.getParameters().put('id', String.valueOf(con.Id)); 
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(con);
        IconsForContact testAccPlan = new IconsForContact(sc);
        Test.StopTest();
    }
}