@isTest
public class Test_UpdateAccConOpp{
  public  static testMethod void myTest(){
        account acc = new account();
        acc.name ='test';
        acc.Active__c=false;
        acc.DS_Rating__c='Ds22';
        insert acc;
        contact con = new contact();
        con.lastname='test1';
        con.DS_Rating__c='Ds6';
        insert con;
       Lead l=new Lead();
      // l.Name='test test';
       l.LastName='test1 test1';
       l.Company='cube84';
       l.Status='closed won';
       l.DS_Rating__c='Ds7';
       insert l;
      DS360oi__DonorSearch_del_del__c d=new DS360oi__DonorSearch_del_del__c();
        d.DS360oi__DS_Rating__c='Ds-1';
        d.DS360oi__Account__c=acc.Id;
        d.DS360oi__ID__c=con.Id;
        d.DS360oi__Lead_ID__c=l.Id;
         insert d;
       }
}