@isTest(SeeAllData=true)
public class UpdatePrimaryAccountTest {
@isTest 
    public static void Method1() {
        account ac=new account();
        ac.name='first account';
        insert ac;
        
         account ac1=new account();
        ac1.name='first account';
        insert ac1;
        
         contact co=new contact();
        co.LastName='contact 1';
        insert co;
        
         contact con1=new contact();
        con1.lastname='contact 2';
        insert con1;
        
        opportunity opp=new opportunity();
        opp.AccountId=ac.id;
        opp.Primary_Contact1__c=con1.id;
        opp.Soft_Account__c=ac.id;
        opp.Soft_Credit__c=co.id;
        opp.CloseDate=system.today();
        opp.StageName='Closed won';
        opp.name='My oppname';
        insert opp;
        
         opp.AccountId=ac.id;
        opp.Primary_Contact1__c=con1.id;
        opp.Primary_Account__c=null;
        opp.Soft_Credit__c=con1.id;
        opp.Soft_Account__c=ac1.id;
        opp.CloseDate=system.today();
        opp.StageName='Closed won';
        opp.name='My oppname';
        update opp;
        opportunity opp1=new opportunity();
        opp1.AccountId=ac.id;
        opp1.Primary_Contact1__c=con1.id;
        opp1.Soft_Account__c=null;
        opp1.Soft_Credit__c=co.id;
        opp1.CloseDate=system.today();
        opp1.StageName='Closed won';
        opp1.name='My oppname';
        insert opp1;
        
         opp1.AccountId=ac.id;
        opp1.Primary_Contact1__c=co.id;
        opp1.Primary_Account__c=null;
        opp1.Soft_Credit__c=con1.id;
        opp1.Soft_Account__c=null;
        opp1.CloseDate=system.today();
        opp1.StageName='Closed won';
        opp1.name='My oppname';
        update opp1;
    }
}