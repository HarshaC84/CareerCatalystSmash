@isTest(SeeAllData=false)
public class Accountlevel1_Test {
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
        
        Account ac = new account();
        ac.Name ='demo';
        ac.This_Year_Total_level__c = 1500;
        ac.Level_c__c=le.Id;
        ac.Lifetime_Giving_Totals__c=1100;
        insert ac;
        
        
        Affiliated_Level__c af = new Affiliated_Level__c();
        af.Account__c =ac.id;
        af.Level__c = le.id;
        af.Lifetime_Giving__c =50000;
        af.Campaign__c = camp.id;
        insert af;
        

        
        opportunity op = new opportunity();
        op.Name ='test1';
        op.AccountId=ac.Id;
        op.StageName ='closed won';
        op.CloseDate =Date.newInstance(2021,01,30);
        op.Soft_Account__c=ac.Id;
        op.Amount=100;
        op.RecordTypeId =strRecordTypeId;
        insert op;
        
        opportunity op1 = new opportunity();
        op1.Name ='test1';
        op1.AccountId=ac.Id;
        op1.StageName ='closed won';
        op1.CloseDate =Date.newInstance(2021,01,30);
        op1.Soft_Account__c=ac.Id;
        op1.Amount=5000;
        op1.RecordTypeId =strRecordTypeId;
        insert op1;
        
         opportunity op2 = new opportunity();
        op2.Name ='test2';
        op2.AccountId=ac.Id;
        op2.StageName ='closed won';
        op2.CloseDate =Date.newInstance(2021,01,30);
        op2.Soft_Account__c=ac.Id;
        op2.Amount=10000;
        op2.RecordTypeId =strRecordTypeId;
        insert op2;
        
       
       
      
        Test.StartTest();  
        
        update ac;
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
        
        Account ac = new account();
        ac.Name ='demo';
        ac.This_Year_Total_level__c = 1500;
        ac.Level_c__c=le.Id;
        ac.Lifetime_Giving_Totals__c=1100;
        insert ac;
        
        
        Affiliated_Level__c af = new Affiliated_Level__c();
        af.Account__c =ac.id;
        af.Level__c = le.id;
        af.Lifetime_Giving__c =50000;
        af.Campaign__c = camp.id;
        insert af;
        

        
        opportunity op = new opportunity();
        op.Name ='test1';
        op.AccountId=ac.Id;
        op.StageName ='closed won';
        op.CloseDate =Date.newInstance(2021,01,30);
        op.Soft_Account__c=ac.Id;
        op.Amount=100;
        op.RecordTypeId =strRecordTypeId;
        insert op;
        
        opportunity op1 = new opportunity();
        op1.Name ='test1';
        op1.AccountId=ac.Id;
        op1.StageName ='closed won';
        op1.CloseDate =Date.newInstance(2021,01,30);
        op1.Soft_Account__c=ac.Id;
        op1.Amount=25000;
        op1.RecordTypeId =strRecordTypeId;
        insert op1;
        
         opportunity op2 = new opportunity();
        op2.Name ='test2';
        op2.AccountId=ac.Id;
        op2.StageName ='closed won';
        op2.CloseDate =Date.newInstance(2021,01,30);
        op2.Soft_Account__c=ac.Id;
        op2.Amount=50000;
        op2.RecordTypeId =strRecordTypeId;
        insert op2;
        
       
       
      
        Test.StartTest();  
        
        update ac;
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
        
        Account ac = new account();
        ac.Name ='demo';
        ac.This_Year_Total_level__c = 1500;
        ac.Level_c__c=le.Id;
        ac.Lifetime_Giving_Totals__c=1100;
        insert ac;
        
        
        Affiliated_Level__c af = new Affiliated_Level__c();
        af.Account__c =ac.id;
        af.Level__c = le.id;
        af.Lifetime_Giving__c =50000;
        af.Campaign__c = camp.id;
        insert af;
        

        
        opportunity op = new opportunity();
        op.Name ='test1';
        op.AccountId=ac.Id;
        op.StageName ='closed won';
        op.CloseDate =Date.newInstance(2021,01,30);
        op.Soft_Account__c=ac.Id;
        op.Amount=100;
        op.RecordTypeId =strRecordTypeId;
        insert op;
        
        opportunity op1 = new opportunity();
        op1.Name ='test1';
        op1.AccountId=ac.Id;
        op1.StageName ='closed won';
        op1.CloseDate =Date.newInstance(2021,01,30);
        op1.Soft_Account__c=ac.Id;
        op1.Amount=100000;
        op1.RecordTypeId =strRecordTypeId;
        insert op1;
        
        
        
       
       
      
        Test.StartTest();  
        
        update ac;
        Test.StopTest();
    
    }
    
    
}