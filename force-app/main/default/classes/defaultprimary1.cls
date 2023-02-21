public class defaultprimary1 {
public static void AccountLevel(List<Opportunity> oppList,Map<Id,Opportunity> oldMap){
 {
list<account>acc=new list<account>();
    Set<Id> accountIds = new Set<Id>();
    set<id>contactId=new set<id>();
    set<id>softid=new set<id>();
    set<id>softaccountId=new set<id>();
            
        for (Opportunity opp :oppList){
        accountIds.add(opp.AccountId);
        if(opp.Primary_Contact1__c!=null){
            contactId.add(opp.Primary_Contact1__c);
        }
        if(opp.Soft_Credit__c!=null && opp.Soft_Account__c==null){
            softid.add(opp.Soft_Credit__c);
              }
            if(opp.Soft_Account__c!=null){
            opp.SoftCreditAccount__c=true;
            opp.Real_Account__c=opp.Soft_Account__c;
            }
            if(opp.Soft_Account__c==null){
            opp.SoftCreditAccount__c=false;
            opp.Real_Account__c=opp.AccountId;  
            }
            
    }
     
    map<id,contact>contactrec=new Map<ID, Contact>([select id,FirstName,lastname,AccountId from contact where id In:contactId]);
    map<id,contact>softcontact=new map<id,contact>([select id,FirstName,lastname,AccountId from contact where id In:softid]);
    Map<Id, Account> AccountIdrec = new Map<Id, Account>([select id,npe01__One2OneContact__c,name,RecordType.Name,npsp__Number_of_Household_Members__c from account where id In:accountIds]);
  
    if(trigger.isInsert){   
                if(CheckRecursive1.runOnce())
    {
            for(Opportunity op :oppList){
                if(op.Soft_Credit__c==null && op.Primary_Contact1__c!=null){
                    op.CheckContact__c=true;
                }
                else
                    op.CheckContact__c=false;
           if(op.AccountId!=null && op.Soft_Account__c!=null){
            softaccountId.add(op.Soft_Credit__c);
             }
                if(op.Soft_Credit__c!=null){
                 op.Real_Contact__c=op.Soft_Credit__c;   
                }
                if(op.Soft_Credit__c==null && op.Primary_Contact1__c!=null){
                    op.Real_Contact__c=op.Primary_Contact1__c;
                }
                system.debug('the real contact is'+op.Real_Contact__c);
                system.debug('the list is'+op.CheckContact__c);
                  op.checkedlevel__c=true;
                    if(op.AccountId != null) {
                        Account e = AccountIdrec.get(op.AccountId);
                        system.debug('the Account info'+e);
                        system.debug('the opp primay contact'+op.npsp__Primary_Contact__c);
                        if(e != null) {
                            //c.EntitlementId = e.Id;                          
                            if(op.Primary_Contact1__c== null && e.npsp__Number_of_Household_Members__c==1) {
                                system.debug('the primary contact before update'+op.npsp__Primary_Contact__c);
                                op.Primary_Contact1__c= e.npe01__One2OneContact__c;
                                //op.PrimaryContact_Check__c=false;
                               
                            }
                            if(op.Primary_Contact1__c!= null) {
                                system.debug('the primary contact before update'+op.npsp__Primary_Contact__c);
                                op.npsp__Primary_Contact__c= op.Primary_Contact1__c;
                                //op.PrimaryContact_Check__c=false;
                                
                            }
                            if(op.Primary_Contact1__c== null && e.npsp__Number_of_Household_Members__c >1){
                               //op.PrimaryContact_Check__c=true; 
                                System.debug('the checkbox is'+op.PrimaryContact_Check__c);
                                op.npsp__Primary_Contact__c=null;
                               
                            }
                            if(e.RecordType.Name=='Organization'){
                                op.Name=e.Name+' '+string.valueOf(op.CloseDate);
                            }
                        }                }
                
                if(op.Primary_Contact1__c!=null && op.Primary_Account__c==null){
                    contact c=contactrec.get(op.Primary_Contact1__c);
                    if(c!=null){
                        if(op.AccountId!=c.accountId){
                            op.Primary_Account__c=c.accountId;
                        }
                        else
                         op.Primary_Account__c=null; 
                    }
                }
                if(op.Soft_Credit__c!=null && softcontact.size()>0 && op.Soft_Account__c==null){
                    contact c1=softcontact.get(op.Soft_Credit__c);
                    if(c1!=null){                        
                           op.Soft_Account__c=c1.accountId;
                        } 
                    }
                if(contactrec.size()>0 && AccountIdrec.size()>0){
                    contact cc=contactrec.get(op.Primary_Contact1__c);
                    account ac1=AccountIdrec.get(op.AccountId);
                    if(ac1.RecordType.Name=='Household Account' && op.Primary_Contact1__c!=null){
                        if(cc.FirstName!=null){
                                op.Name=cc.FirstName+' '+cc.LastName+' '+string.valueOf(op.CloseDate);
                    }
                        else
                           op.Name=cc.LastName+' '+string.valueOf(op.CloseDate);
                }
                    if(ac1.RecordType.Name=='Household Account' && op.Primary_Contact1__c==null){
                            op.Name=ac1.Name+' '+string.valueOf(op.CloseDate); 
                            system.debug('PMnull'+op.Name);
                            
                        }
                }
                }
        //List<AggregateResult> AggregateResultList=[select id,name,];
            }
            }
        
            if(trigger.isUpdate){
                //Map<Id, Account> AccountIdrec1 = new Map<Id, Account>();
                for(Opportunity op : oppList){
                    if(op.Soft_Credit__c==null && op.Primary_Contact1__c!=null){
                    op.CheckContact__c=true;
                }
                else
                    op.CheckContact__c=false;
                    if(op.AccountId != null) {
                     Account e = AccountIdrec.get(op.AccountId);   
                      if(e != null) {
                            //c.EntitlementId = e.Id;
                            
                            if(op.Primary_Contact1__c!= null && oldmap.get(op.id).Primary_Contact1__c!=op.Primary_Contact1__c) {
                                system.debug('the primary contact before update'+op.npsp__Primary_Contact__c);
                                op.npsp__Primary_Contact__c= op.Primary_Contact1__c;
                                 //op.PrimaryContact_Check__c=false;
                            }
                          
                            if(op.Primary_Contact1__c== null) {
                                system.debug('the primary contact before update'+op.npsp__Primary_Contact__c);
                                op.npsp__Primary_Contact__c=null;
                               //op.PrimaryContact_Check__c=false;
                            }
                           if(e.RecordType.Name=='Organization'){
                                op.Name=e.Name+' '+string.valueOf(op.CloseDate);
                            }
                    }

                } 
                   if(contactrec.size()>0 && AccountIdrec.size()>0){
                    contact cc=contactrec.get(op.Primary_Contact1__c);
                    account ac1=AccountIdrec.get(op.AccountId);
                    if(ac1.RecordType.Name=='Household Account' && op.Primary_Contact1__c!=null){
                        if(cc.FirstName!=null){
                                op.Name=cc.FirstName+' '+' '+cc.LastName+' '+string.valueOf(op.CloseDate);
                    }
                        else
                           op.Name=cc.LastName+' '+string.valueOf(op.CloseDate);
                }
                    if(ac1.RecordType.Name=='Household Account' && op.Primary_Contact1__c==null){
                            op.Name=ac1.Name+' '+string.valueOf(op.CloseDate); 
                            system.debug('PMnull'+op.Name);
                            
                        }
                }
               if(op.Soft_Credit__c!=null){
                 op.Real_Contact__c=op.Soft_Credit__c;   
                }
                if(op.Soft_Credit__c==null && op.Primary_Contact1__c!=null){
                    op.Real_Contact__c=op.Primary_Contact1__c;
                }
              
            }
        } 
    }
}
}