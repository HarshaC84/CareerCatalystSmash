@isTest
public class UpdateLeadrating_test {
    
    public  static testMethod void myTest1(){
        Ability__c Ab=new Ability__c();
        ab.Name='1';
        ab.capability__c='$1 million +';
        ab.Known_Asserts__c='$20 million +';
        insert ab;
        
        Interest__c inc=new Interest__c();
        inc.Name='A';
        inc.Description1__c='My discription';
        inc.Description2__c='My discription2';
        insert inc;
        
        Readiness__c re=new Readiness__c();
        re.Name='1';
        re.Description__c='readiness dis';
        insert re;
        
        lead con = new lead();
        con.Company='test1';
        con.lastname='Ds6';
        con.Ability__c='1';
        insert con;
    }
    
    public  static testMethod void myTest2(){
        Ability__c Ab=new Ability__c();
        ab.Name='1';
        ab.capability__c='$1 million +';
        ab.Known_Asserts__c='$20 million +';
        insert ab;
        
        Interest__c inc=new Interest__c();
        inc.Name='A';
        inc.Description1__c='My discription';
        inc.Description2__c='My discription2';
        insert inc;
        
        Readiness__c re=new Readiness__c();
        re.Name='1';
        re.Description__c='readiness dis';
        insert re;
        
        lead con = new lead();
        con.lastname ='test1';
        con.Company='Ds6';
        con.Ability__c='1'; 
        con.Interest_to_give__c = 'A';
        insert con;
    }
    
    public  static testMethod void myTest3(){
        Ability__c Ab=new Ability__c();
        ab.Name='1';
        ab.capability__c='$1 million +';
        ab.Known_Asserts__c='$20 million +';
        insert ab;
        
        Interest__c inc=new Interest__c();
        inc.Name='A';
        inc.Description1__c='My discription';
        inc.Description2__c='My discription2';
        insert inc;
        
        Readiness__c re=new Readiness__c();
        re.Name='1';
        re.Description__c='readiness dis';
        insert re;
        
        lead con = new lead();
        con.lastname='test1';
        con.Company='Ds6';
        con.Ability__c='1';
        con.Interest_to_give__c = 'A';
        con.Readiness__c = '1';
        insert con;
    }
    
    public  static testMethod void myTest4(){
        Ability__c Ab=new Ability__c();
        ab.Name='1';
        ab.capability__c='$1 million +';
        ab.Known_Asserts__c='$20 million +';
        insert ab;
        
        Interest__c inc=new Interest__c();
        inc.Name='A';
        inc.Description1__c='My discription';
        inc.Description2__c='My discription2';
        insert inc;
        
        Readiness__c re=new Readiness__c();
        re.Name='1';
        re.Description__c='readiness dis';
        insert re;
        
        lead con = new lead();
        con.lastname='test1';
        con.Company='Ds6';
        insert con;
        
        con.Ability__c='1';
        con.Interest_to_give__c = 'A';
        con.Readiness__c = '1';
        update con;
    }
     public  static testMethod void myTest5(){
        Ability__c Ab=new Ability__c();
        ab.Name='1';
        ab.capability__c='$1 million +';
        ab.Known_Asserts__c='$20 million +';
        insert ab;
        
        Interest__c inc=new Interest__c();
        inc.Name='A';
        inc.Description1__c='My discription';
        inc.Description2__c='My discription2';
        insert inc;
        
        Readiness__c re=new Readiness__c();
        re.Name='1';
        re.Description__c='readiness dis';
        insert re;
        
        lead con = new lead();
        con.lastname='test1';
        con.Company='Ds6';
        insert con;
        
         update con;
       
     }
    
}