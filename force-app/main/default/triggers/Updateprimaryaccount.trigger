trigger Updateprimaryaccount on Opportunity (before insert,before update) {
    //map<id,opportunity>opp=new map<id,opportunity>();
    list<opportunity>newopp=new list<opportunity>();
    list<id>accid=new list<id>();
     list<id>primaryid=new list<id>();
    list<id>soid=new list<id>();
    set<ID> accID1 =new set<ID>();
    list<opportunity>newopp1=new list<opportunity>();
    if(trigger.isinsert){
        for(Opportunity opp:trigger.new){
            accID1.add(opp.AccountId);
            newopp.add(opp);
            if(opp.Primary_Contact1__c!=null && opp.Primary_Account__c==null){
                accid.add(opp.Primary_Contact1__c);
                //opp.put(opp.id,opp);
            }
           
            
            if(opp.Soft_Account__c==null && opp.Soft_Credit__c!=null){
                soid.add(opp.Soft_Credit__c);
            }
            
            if(opp.AccountId!=null && opp.Primary_Account__c!=null&& opp.AccountId==opp.Primary_Account__c){
                opp.Primary_Account__c=null;
            }
            if(opp.Primary_Account__c!=null && opp.Primary_Account__c==opp.AccountId){
                opp.Primary_Account__c=null; 
            }
        }
        
        if(newopp.size()>0){
            for(Opportunity opp:newopp){
                
                if(opp.Primary_Contact1__c!=null){
                    if(opp.AccountId!=opp.Primary_Contact1__r.accountId){
                        for(contact con:[select id,name,accountid from contact where id In:accid limit 1]){
                            opp.Primary_Account__c=con.accountId;
                        }
                        system.debug('The account id...........'+opp.Primary_Contact1__c);
                        
                        newopp1.add(opp);
                    }   
                }
                if(accID1.size()>0)
                {
                    for(Account acc:[select id,RecordType.Name,name from account where ID IN : accID1])
                    {
                        if(acc.RecordType.Name=='Organization')
                        {
                            opp.Name=acc.Name+' '+string.valueOf(opp.CloseDate); 
                            system.debug('Account org'+opp.Name);
                        }
                        if(acc.RecordType.Name=='Household Account' && opp.Primary_Contact1__c!=null){
                            for(Contact cc:[select id,lastname,firstname from contact where ID=:opp.Primary_Contact1__c])
                            {
                                if(cc.FirstName!=null){
                                opp.Name=cc.FirstName+' '+' '+cc.LastName+' '+string.valueOf(opp.CloseDate);  
                                system.debug('Account household'+opp.Name);
                            }
                                else
                                   opp.Name=cc.LastName+' '+string.valueOf(opp.CloseDate); 
                                
                            }
                        }
                        if(acc.RecordType.Name=='Household Account' && opp.Primary_Contact1__c==null){
                            opp.Name=acc.Name+' '+string.valueOf(opp.CloseDate); 
                            system.debug('PMnull'+opp.Name);
                            
                        }
                    }
                    
                }
                if(opp.Soft_Credit__c!=null ){
                    if(opp.Soft_Account__c==null){
                        for(contact con:[select id,name,accountid from contact where id In:soid limit 1]){
                            opp.Soft_Account__c=con.accountId;
                        }  
                    }
                }
            }
            
        }
    }
    if(trigger.isUpdate){
        for(Opportunity opp:trigger.new){
              accID1.add(opp.AccountId);
            if(opp.Primary_Contact1__c!=null && opp.Primary_Account__c==null){
                newopp.add(opp);
                accid.add(opp.Primary_Contact1__c);
                //opp.put(opp.id,opp);
            }
            
            if(opp.AccountId!=null && opp.Primary_Account__c!=null&& opp.AccountId==opp.Primary_Account__c){
                opp.Primary_Account__c=null;
            }
            

             if(accID1.size()>0)
                {
                    for(Account acc:[select id,RecordType.Name,name from account where ID IN : accID1])
                    {
                        if(acc.RecordType.Name=='Organization')
                        {
                            opp.Name=acc.Name+' '+string.valueOf(opp.CloseDate); 
                            system.debug('Account org'+opp.Name);
                        }
                        if(acc.RecordType.Name=='Household Account' && opp.Primary_Contact1__c!=null){
                            for(Contact cc:[select id,lastname,firstname from contact where ID=:opp.Primary_Contact1__c])
                            {
                                if(cc.FirstName!=null){
                                opp.Name=cc.FirstName+' '+' '+cc.LastName+' '+string.valueOf(opp.CloseDate);  
                                system.debug('Account household'+opp.Name);
                            }
                                else
                                   opp.Name=cc.LastName+' '+string.valueOf(opp.CloseDate); 
   
                        }
                        }
                        if(acc.RecordType.Name=='Household Account' && opp.Primary_Contact1__c==null){
                            opp.Name=acc.Name+' '+string.valueOf(opp.CloseDate); 
                            system.debug('PMnull'+opp.Name);
                            
                        }
                    }
                }
        }
        if(newopp.size()>0){
            for(Opportunity opp:newopp){
                if(opp.Primary_Contact1__c!=null){
                    if(opp.AccountId!=opp.Primary_Contact1__r.accountId){
                        for(contact con:[select id,name,accountid from contact where id In:accid limit 1]){
                            opp.Primary_Account__c=con.accountId;
                        }
                        system.debug('The account id...........'+opp.Primary_Contact1__c);
                        
                       newopp1.add(opp);
                    }   
                }
            }
        }
    }
}