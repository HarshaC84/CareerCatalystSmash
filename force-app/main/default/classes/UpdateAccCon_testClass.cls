@isTest(SeeAllData=true)
public class UpdateAccCon_testClass {
    @isTest static void Method1() {
        List<opportunity>opplist=new List<opportunity>();
        Map<id,opportunity>oldmap=new map<id,opportunity>();
        Map<id,opportunity>newmap=new map<id,opportunity>();
        List<contact>con11=new list<contact>();
        map<id,contact>mapcon=new map<id,contact>();
        map<id,account>accmap=new map<id,account>();        
        account ac=new account();
        ac.name='first account';
        insert ac;
        accmap.put(ac.id,ac);
        ac.name ='test';
        update ac;
   
        account ac1=new account();
        ac1.name='first account';
        ac1.RecordTypeId='012f40000006sTMAAY';
        insert ac1;
        accmap.put(ac1.id,ac1);
        contact con=new contact();
        con.LastName='contact 1';
        insert con;
        mapcon.put(con.id,con);
         
        contact co=new contact();
        co.LastName='contact 1';
        insert co;
        mapcon.put(co.id,co);
       
        contact con1=new contact();
        con1.lastname='contact 2';
        insert con1;
        mapcon.put(con1.id,con1);
        
        opportunity opp=new opportunity();
        opp.AccountId=ac.id;
        opp.Primary_Contact1__c=con.id;
        opp.Soft_Credit__c=co.id;
        opp.Soft_Account__c=null;
        opp.CloseDate=system.today();
        opp.StageName='Closed won';
        opp.name='My oppname';
        insert opp;
        oldmap.put(opp.id,opp);
        
        opp.AccountId=ac.id;
        opp.Primary_Contact1__c=co.id;
        opp.Soft_Account__c=ac1.id;
        opp.CloseDate=system.today();
        opp.StageName='Closed won';
        opp.name='My oppname';
        update opp;
        opplist.add(opp);
        
         
        opportunity opp1=new opportunity();
        opp1.AccountId=ac.id;
        opp1.Soft_Credit__c=co.id;
        opp1.Primary_Account__c=ac1.id;
        opp1.CloseDate=system.today();
        opp1.StageName='Closed Won';
        opp1.name='My oppname1';
        insert opp1;
        oldmap.put(opp1.id,opp1);
        
        opp1.AccountId=ac1.id;
        opp1.Soft_Credit__c=con.id;
        opp1.Primary_Account__c=ac.id;
        opp1.CloseDate=system.today();
        opp1.StageName='Closed won';
        opp1.name='My oppname1';
        update opp1;
        opplist.add(opp1);

    }
    
}