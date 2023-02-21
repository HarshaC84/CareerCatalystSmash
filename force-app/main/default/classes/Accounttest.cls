@isTest(SeeAllData=true)
public class Accounttest {
    static testmethod void Accountlevels()
    {
        String strRecordTypeId = [Select Id From RecordType Where SobjectType = 'opportunity' and Name = 'Donation'].Id;
        list<account>acc=new list<account>();
        map<id,account>acc1=new map<id,account>();
        Level__c le = new Level__c();
        le.Name = 'test';
        le.Maximum_Amount__c =123456;
        le.Minimum_Amount__c =123;
        insert le;
        
        Level__c le1 = new Level__c();
        le1.Name = 'test2';
        le1.Maximum_Amount__c =5456;
        le1.Minimum_Amount__c =123;
        insert le1;
        
        
        Campaign camp = new Campaign();
        camp.IsActive =true;
        camp.Name ='test';
        insert camp;
        
        Account ac = new account();
        ac.Name ='demo';
        ac.This_Year_Total_level__c = 1500;
        ac.Level_c__c=le.Id;
        //ac.This_year_Total_Amount__c=900;
        ac.Lifetime_Giving_Totals__c=1100;
        ac.Donor_Listing_Preference__c ='demo';
            
        insert ac;
        acc1.put(ac.id,ac);
        ac.This_Year_Total_level__c = 150;
        ac.Level_c__c=le1.Id;
        update ac;
        acc.add(ac);
        
         Account ac1 = new account();
        ac1.Name ='demo1';
        ac1.This_Year_Total_level__c = 11500;
        ac1.Level_c__c=le.Id;
        ac1.Lifetime_Giving_Totals__c=2100;
        insert ac1;
        acc1.put(ac1.id,ac1);
        //ac.name='demo2';
        
        Affiliated_Level__c af = new Affiliated_Level__c();
        af.Account__c =ac.id;
        af.Level__c = le.id;
        af.Lifetime_Giving__c =50000;
        af.Campaign__c = camp.id;
        insert af;
        
         af.Account__c =ac.id;
         af.Lifetime_Giving__c =50000;
        af.Level__c =le.id;
        af.Status__c ='active';
           update af;

        
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
        op1.AccountId=ac1.Id;
        op1.StageName ='closed won';
        op1.CloseDate =Date.newInstance(2021,01,30);
        op1.Soft_Account__c=ac.Id;
        op1.Amount=5000;
        op1.RecordTypeId =strRecordTypeId;
        insert op1;
        
        
       
       
      
        Test.StartTest();  
        
        update ac1;
        acc.add(ac1);
        
       Account_level1.fieldupdate(acc,acc1);
         Account_level1.AccountAmmount(acc,acc1);
        Test.StopTest();
    }
    static testmethod void Accountlevels2()
    {
        String strRecordTypeId = [Select Id From RecordType Where SobjectType = 'opportunity' and Name = 'Donation'].Id;
        list<account>acc=new list<account>();
        map<id,account>acc1=new map<id,account>();
        Level__c le = new Level__c();
        le.Name = 'test';
        le.Maximum_Amount__c =3456;
        le.Minimum_Amount__c =123;
        insert le;
        
        Level__c le1 = new Level__c();
        le1.Name = 'test';
        le1.Maximum_Amount__c =4506;
        le1.Minimum_Amount__c =3456;
        insert le1;
        
        //le.name='test2';
        
        
        Campaign camp = new Campaign();
        camp.IsActive =true;
        camp.Name ='test';
        insert camp;
        
        Account ac = new account();
        ac.Name ='demo';
        ac.This_Year_Total_level__c = 1500;
        ac.Level_c__c=le.Id;
        //ac.ContactFullName__c='demoa';
        ac.Lifetime_Giving_Totals__c=1100;
        ac.Donor_Listing_Preference__c ='demo';
            
        insert ac;
        acc1.put(ac.id,ac);
        ac.This_Year_Total_level__c =0;
        ac.Level_c__c=le.Id;
        update ac;
        acc.add(ac);

        
         Account ac1 = new account();
        ac1.Name ='demo1';
        ac1.This_Year_Total_level__c = 11500;
        ac1.Level_c__c=le.Id;
        ac1.Lifetime_Giving_Totals__c=2100;
        insert ac1;
        acc1.put(ac1.id,ac1);
        Account ac2 = new account();
        ac2.Name ='demo1';
        ac2.This_Year_Total_level__c = 1150;
        ac2.Level_c__c=le.Id;
        ac2.Lifetime_Giving_Totals__c=2100;
        insert ac2;
        acc1.put(ac2.id,ac2);
        
         Account ac3 = new account();
        ac3.Name ='demo1';
        ac3.This_Year_Total_level__c = 27000;
        ac3.Level_c__c=le.Id;
        ac3.Lifetime_Giving_Totals__c=2100;
        insert ac3;
        acc1.put(ac3.id,ac3);
       
         Account ac0 = new account();
        ac0.Name ='demo1';
        ac0.This_Year_Total_level__c = 50000;
        ac0.Level_c__c=le.Id;
        ac0.Lifetime_Giving_Totals__c=2100;
        insert ac0;
        acc1.put(ac0.id,ac0);
       
         ac.This_Year_Total_level__c =7890;
        ac.Level_c__c=le.Id;
        update ac;
        acc.add(ac);

         Account ac8 = new account();
        ac8.Name ='demo1';
        ac8.This_Year_Total_level__c = 6000;
        ac8.Level_c__c=le.Id;
        ac8.Lifetime_Giving_Totals__c=6000;
        insert ac8;
        acc1.put(ac8.id,ac8);
        
         
        
        //ac.name='demo2';
        
        Affiliated_Level__c af = new Affiliated_Level__c();
        af.Account__c =ac.id;
        af.Level__c = le.id;
        af.Lifetime_Giving__c =50000;
        af.Campaign__c = camp.id;
        insert af;
        
        af.Account__c=ac.id;
        af.Level__c = null;
        af.Status__c='Inactive';
        update af;
        
        opportunity op = new opportunity();
        op.Name ='test1';
        op.AccountId=ac.Id;
        op.StageName ='closed won';
        op.CloseDate =Date.newInstance(2021,01,30);
        op.Soft_Account__c=ac.Id;
        op.Amount=100;
        op.RecordTypeId =strRecordTypeId;
        insert op;
        
        
        
      
        Test.StartTest();  
         update ac1;
        acc.add(ac1);
        update ac2;
         acc.add(ac2);
        
        
       Account_level1.fieldupdate(acc,acc1);
         Account_level1.AccountAmmount(acc,acc1);
        Test.StopTest();
    }
     
      static testmethod void Accountlevels3()
    {
        String strRecordTypeId = [Select Id From RecordType Where SobjectType = 'opportunity' and Name = 'Donation'].Id;
        list<account>acc=new list<account>();
        map<id,account>acc1=new map<id,account>();
        Level__c le = new Level__c();
        le.Name = 'test';
        le.Maximum_Amount__c =3456;
        le.Minimum_Amount__c =123;
        insert le;
        
        Level__c le1 = new Level__c();
        le1.Name = 'test';
        le1.Maximum_Amount__c =4506;
        le1.Minimum_Amount__c =3456;
        insert le1;
        
        //le.name='test2';
        
        
        Campaign camp = new Campaign();
        camp.IsActive =true;
        camp.Name ='test';
        insert camp;
        
        Account ac = new account();
        ac.Name ='demo';
        ac.This_Year_Total_level__c = 1500;
        ac.Level_c__c=le.Id;
        //ac.ContactFullName__c='demoa';
        ac.Lifetime_Giving_Totals__c=1100;
        ac.Donor_Listing_Preference__c ='demo';
            
        insert ac;
        acc1.put(ac.id,ac);
        ac.This_Year_Total_level__c =0;
        ac.Level_c__c=le.Id;
        update ac;
        acc.add(ac);

        
         
         Account ac3 = new account();
        ac3.Name ='demo1';
        ac3.This_Year_Total_level__c = 27000;
        ac3.Level_c__c=le.Id;
        ac3.Lifetime_Giving_Totals__c=29000;
        insert ac3;
        acc1.put(ac3.id,ac3);
       
         Account ac0 = new account();
        ac0.Name ='demo1';
        ac0.This_Year_Total_level__c =50000;
        ac0.Level_c__c=le.Id;
        ac0.Lifetime_Giving_Totals__c=21000;
        insert ac0;
        acc1.put(ac0.id,ac0);
       
         ac0.This_Year_Total_level__c =7890;
        ac0.Level_c__c=le.Id;
        update ac0;
        acc.add(ac0);

         Account ac8 = new account();
        ac8.Name ='demo1';
        ac8.This_Year_Total_level__c = 6000;
        ac8.Level_c__c=le.Id;
        ac8.Lifetime_Giving_Totals__c=60000;
        insert ac8;
        acc1.put(ac8.id,ac8);
        
         
        
        //ac.name='demo2';
        
        
        opportunity op = new opportunity();
        op.Name ='test1';
        op.AccountId=ac.Id;
        op.StageName ='closed won';
        op.CloseDate =Date.newInstance(2021,01,30);
        op.Soft_Account__c=ac.Id;
        op.Amount=100;
        op.RecordTypeId =strRecordTypeId;
        insert op;
        
      
        Test.StartTest();  
         update ac0;
        acc.add(ac0);
        update ac8;
         acc.add(ac8);
        
        
       Account_level1.fieldupdate(acc,acc1);
         Account_level1.AccountAmmount(acc,acc1);
        Test.StopTest();
    }
     
   
    
    
}