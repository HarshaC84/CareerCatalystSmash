trigger AccNameUpdate on Contact (after insert,after update,after delete,after undelete) {

      List<Contact> modcon = Trigger.isDelete ? Trigger.old:Trigger.new;
    list<Account> acclst=new list<Account>();
   list<ID> setAccountIDs = new list<ID>();
     list<ID> setAccountIDs1 = new list<ID>();
  boolean v=true;
    boolean recordtypename=false;
     list<id> myid=new list<id>();
    Id clientRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Household Account').getRecordTypeId();
    system.debug('recordtype'+clientRecordTypeId);
    for(Contact c : modcon){
        setAccountIDs.add(c.AccountId);
     
        system.debug(c.AccountId);
       
    }
     integer val=modcon.size();
      system.debug(modcon.size());
    List<Contact> lstcon=[select id,firstname,lastname,AccountId,Account.RecordTypeId from contact  where AccountId =:setAccountIDs ORDER BY CreatedDate ASC];
    
   map<id,Account> accmap1=new map<id,Account>([select id,name from account where ID =:setAccountIDs]);
    
    list<Account> lstac=new list<Account>([select id,name,RecordTypeId from account where ID =:setAccountIDs]);
    system.debug('list size'+lstcon.size());
    
    if(lstcon.size()==1)
    {
         for(Contact c:lstcon)
     {
       if(c.Account.RecordTypeId==clientRecordTypeId)
       {
        Account ac=accmap1.get(c.AccountId);
         system.debug(ac);
         if(c.FirstName!=null){
       ac.Name=c.FirstName+' '+c.LastName+' '+'Hh';  
         }
         else
             ac.Name=c.LastName+' '+'Hh';
         system.debug('contact name'+ac.Name);
         acclst.add(ac);
       }
     }
    }
    
    if(lstcon.size()>1){
     
          string ss='';
       //  string s2='and';
        string s3='';
        string s4='';
           system.debug(modcon.size());
       if(modcon.size()==1)
       {
         system.debug(modcon.size());
        for(Contact cc:modcon)
         {
                        
         Integer i=lstcon.size();
             system.debug(''+i);
             string s5=lstcon[i-1].firstname;
              string s6=lstcon[i-1].lastname;
             system.debug(s6);
             boolean b=true;
             for(Contact c1:lstcon)
     {
         system.debug('FirstnameOuter'+c1.FirstName);
              if(c1.FirstName!=null){
                  system.debug(cc.LastName + c1.LastName );
                  
                  if(cc.LastName==c1.LastName && b==true)
                  {
                        system.debug('hajhhshdklasklas');
                      if(c1.firstname!=s5)
                      {
                           ss=ss+c1.FirstName+',';
                          system.debug('contact name'+ss);
                      }
                      else{
                            ss = ss.removeEnd(',');
                            s4=ss+' '+'and'+' '+c1.FirstName+' '+c1.LastName;
                           system.debug('mytest');
                          b=false;
                      }     
                    
          // s4=ss.substring(0,ss.length()-4);
         c1.Account_Name__c=s4+' '+'Hh';
         s3=c1.Account_Name__c;
                  }
                  else{
                       system.debug('FirstnameOuter'+c1.FirstName);
                      if(c1.lastname!=s6)
                      {
                         system.debug('FirstnameOuter'+c1.FirstName); 
                        ss=ss+c1.lastname+',';
                           system.debug('contact name'+ss);
                            b=false;
                      }
                       else
                      {
                           system.debug('FirstnameOuter'+c1.FirstName);
                           ss=ss.removeEnd(',');
                           s4=ss+' '+'and'+' '+c1.LastName; 
                          system.debug('contact name'+ss);
                        
                      }
        
          // s4=ss.substring(0,ss.length()-4);
         c1.Account_Name__c=s4+' '+'Hh';
         s3=c1.Account_Name__c;
                  }
       
         }
      
     
        }
         
         }
         
    
         for(Account ac1:lstac)
     {
         if(ac1.Name!=null && ac1.RecordTypeId==clientRecordTypeId){
         ac1.Name=s3;
         acclst.add(ac1);
             recordtypename=true;
         system.debug('the Account_Name__c'+ac1.Name);
     }
     
     }
       }
       
    }
         if(acclst.size()>0 && recordtypename==true)
         {
             system.debug(acclst);
              update acclst;
             system.debug(acclst);
         }
     if(lstcon.size()==1)
     {
          system.debug('the Account_Name__c');
          update acclst;
     }
         
  

}