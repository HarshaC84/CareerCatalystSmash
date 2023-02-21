@isTest(SeeAllData=true)
public class Contact_level_Test {
    static testmethod void Accountlevels()
    {
        String strRecordTypeId = [Select Id From RecordType Where SobjectType = 'opportunity' and Name = 'Donation'].Id;
        
        Level__c le = new Level__c();
        le.Name = 'test';
        le.Maximum_Amount__c =123456;
        le.Minimum_Amount__c =123;
        insert le;
        
        Campaign camp = new Campaign();
        camp.IsActive =true;
        camp.Name ='test';
        insert camp;
        
        Contact con = new contact();
        con.LastName ='test';
        con.FirstName ='demo';
        con.Email ='test@gmil.com';
        con.Phone = '1234567890';
        insert con;
        
        
        Affiliated_Level_Contact__c af = new Affiliated_Level_Contact__c();
        af.Contact__c =con.id;
        af.Name = con.Name;
        af.Campaign_Amount__c = con.This_Year_Totals_Gift_C__c;
        af.Level__c = le.id;
        af.Campaign__c = camp.id;
        insert af;
        
        
        
        opportunity op = new opportunity();
        op.Name ='test1';
        op.Primary_Contact1__c=con.Id;
        op.StageName ='closed won';
        op.CloseDate =Date.newInstance(2021,01,30);
        op.Soft_Credit__c=con.Id;
        op.Amount=100;
        op.RecordTypeId =strRecordTypeId;
        insert op;
        
        opportunity op1 = new opportunity();
        op1.Name ='test1';
        op1.Primary_Contact1__c=con.Id;
        op1.StageName ='closed won';
        op1.CloseDate =Date.newInstance(2021,01,30);
        op1.Soft_Credit__c=con.Id;
        op1.Amount=5000;
        op1.RecordTypeId =strRecordTypeId;
        insert op1;
        
        
        
        
        Test.StartTest();  
        
        update con;
        Test.StopTest();
    }
    @isTest
    public static void LevelupdationTest1(){
        String strRecordTypeId = [Select Id From RecordType Where SobjectType = 'opportunity' and Name = 'Donation'].Id;
        
        Level__c le = new Level__c();
        le.Name = 'test';
        le.Maximum_Amount__c =123456;
        le.Minimum_Amount__c =123;
        insert le;
        
        Campaign camp = new Campaign();
        camp.IsActive =true;
        camp.Name ='test';
        insert camp;
        
        Contact con = new contact();
        con.LastName ='test';
        con.FirstName ='demo';
        con.Email ='test@gmil.com';
        con.Phone = '1234567890';
        insert con;
        
        Affiliated_Level_Contact__c af = new Affiliated_Level_Contact__c();
        af.Contact__c =con.id;
        af.Name = con.Name;
        af.Campaign_Amount__c = con.This_Year_Totals_Gift_C__c;
        af.Level__c = le.id;
        af.Campaign__c = camp.id;
        insert af;
        
        
        
        opportunity op = new opportunity();
        op.Name ='test1';
        op.Primary_Contact1__c=con.Id;
        op.StageName ='closed won';
        op.CloseDate =Date.newInstance(2021,01,30);
        op.Soft_Credit__c=con.Id;
        op.Amount=10000;
        op.RecordTypeId =strRecordTypeId;
        insert op;
        
        
        Test.StartTest();  
        
        update con;
        Test.StopTest();
        
    }
    @isTest
    public static void LevelupdationTest2(){
        String strRecordTypeId = [Select Id From RecordType Where SobjectType = 'opportunity' and Name = 'Donation'].Id;
        
        Level__c le = new Level__c();
        le.Name = 'test';
        le.Maximum_Amount__c =123456;
        le.Minimum_Amount__c =123;
        insert le;
        
        Campaign camp = new Campaign();
        camp.IsActive =true;
        camp.Name ='test';
        insert camp;
        
        Contact con = new contact();
        con.LastName ='test';
        con.FirstName ='demo';
        con.Email ='test@gmil.com';
        con.Phone = '1234567890';
        con.This_Year_Totals_Gift__c = 1000;
        insert con;
        
        
        Affiliated_Level_Contact__c af = new Affiliated_Level_Contact__c();
        af.Contact__c =con.id;
        af.Name = con.LastName+con.test__c;
        af.Campaign_Amount__c = con.This_Year_Totals_Gift_C__c;
        af.Level__c = le.id;
        af.Campaign__c = camp.id;
        insert af;
        
        
        
        opportunity op2 = new opportunity();
        op2.Name ='test2';
        op2.Primary_Contact1__c=con.Id;
        op2.StageName ='closed won';
        op2.CloseDate =Date.newInstance(2021,01,30);
        op2.Soft_Credit__c=con.Id;
        op2.Amount=100000;
        op2.RecordTypeId =strRecordTypeId;
        insert op2;
        
        
        
        
        Test.StartTest();  
        
        update con;
        Test.StopTest();
        
    }
    @isTest
    public static void LevelupdationTest3(){
        String strRecordTypeId = [Select Id From RecordType Where SobjectType = 'opportunity' and Name = 'Donation'].Id;
        
        Level__c le = new Level__c();
        le.Name = 'test';
        le.Maximum_Amount__c =123456;
        le.Minimum_Amount__c =123;
        insert le;
        
        Campaign camp = new Campaign();
        camp.IsActive =true;
        camp.Name ='test';
        insert camp;
        
        Contact con = new contact();
        con.LastName ='test';
        con.FirstName ='demo';
        con.Email ='test@gmil.com';
        con.Phone = '1234567890';
        con.This_Year_Totals_Gift__c = 1000;
        insert con;
        
        
        Affiliated_Level_Contact__c af = new Affiliated_Level_Contact__c();
        af.Contact__c =con.id;
        af.Name = con.LastName+con.test__c;
        af.Campaign_Amount__c = con.This_Year_Totals_Gift_C__c;
        af.Level__c = le.id;
        af.Campaign__c = camp.id;
        insert af;
        
        
        
        opportunity op2 = new opportunity();
        op2.Name ='test2';
        op2.Primary_Contact1__c=con.Id;
        op2.StageName ='closed won';
        op2.CloseDate =Date.newInstance(2021,01,30);
        op2.Soft_Credit__c=con.Id;
        op2.Amount=50000;
        op2.RecordTypeId =strRecordTypeId;
        insert op2;
        
        
        
        
        Test.StartTest();  
        
        update con;
        Test.StopTest();
        
    }
    @isTest
    public static void LevelupdationTest4(){
        String strRecordTypeId = [Select Id From RecordType Where SobjectType = 'opportunity' and Name = 'Donation'].Id;
        
        Level__c le = new Level__c();
        le.Name = 'test';
        le.Maximum_Amount__c =123456;
        le.Minimum_Amount__c =123;
        insert le;
        
        Campaign camp = new Campaign();
        camp.IsActive =true;
        camp.Name ='test';
        insert camp;
        
        Contact con = new contact();
        con.LastName ='test';
        con.FirstName ='demo';
        con.Email ='test@gmil.com';
        con.Phone = '1234567890';
        con.This_Year_Totals_Gift__c = 1000;
        insert con;
        
        
        Affiliated_Level_Contact__c af = new Affiliated_Level_Contact__c();
        af.Contact__c =con.id;
        af.Name = con.LastName+con.test__c;
        af.Campaign_Amount__c = con.This_Year_Totals_Gift_C__c;
        af.Level__c = le.id;
        af.Campaign__c = camp.id;
        insert af;
        
        
        
        opportunity op2 = new opportunity();
        op2.Name ='test2';
        op2.Primary_Contact1__c=con.Id;
        op2.StageName ='closed won';
        op2.CloseDate =Date.newInstance(2021,01,30);
        op2.Soft_Credit__c=con.Id;
        op2.Amount=25000;
        op2.RecordTypeId =strRecordTypeId;
        insert op2;
        
        
        
        
        Test.StartTest();  
        
        update con;
        Test.StopTest();
        
    }
}