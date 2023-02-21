@istest
public class AccNameUpdateTest {

    
    @isTest
    public static void concheck()
    {
        id RecordTypeIdContact = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Household Account').getRecordTypeId();

        list<contact>clist=new list<contact>();
        Account ac=new Account();
        ac.Name='Test Account';
        ac.RecordTypeId=RecordTypeIdContact;
        Insert ac;
        Contact cc = new Contact();
        cc.FirstName='Test';
        cc.LastName='Demo';
        cc.AccountId=ac.Id;
        clist.add(cc);
        insert cc;
        
        Contact cc1 = new Contact();
       cc1.FirstName='Test1';
        cc1.AccountId=ac.Id;
        cc1.LastName='Demo';
        clist.add(cc1);
        insert cc1;
        
        

    }
      @isTest
    public static void concheck1()
    {
         id RecordTypeIdContact = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Household Account').getRecordTypeId();

         list<contact>clist2=new list<contact>();
         Account ac=new Account();
        ac.Name='Test Account';
        ac.RecordTypeId=RecordTypeIdContact;
        Insert ac;
                ac.Name='Account';
       update ac;
         Contact cc2 = new Contact();
        //cc2.FirstName='Test';
        cc2.LastName='Demo1';
        cc2.AccountId=ac.id;
        clist2.add(cc2);
        insert cc2;
        cc2.LastName='Demo9';
        update cc2;
         Contact cc3 = new Contact();
        cc3.FirstName='Test';
        cc3.LastName='Demo2';
        cc3.AccountId=ac.id;
        clist2.add(cc3);
        insert cc3;
            }
}