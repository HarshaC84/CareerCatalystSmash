public class Account_level1 {
    
    public static void AccountAmmount(list<Account>oppList,Map<Id,Account> oldMap){
        list<id>acc=new list<id>();
        list<decimal>dc=new list<decimal>();
        map<id,Account>acclist=new map<id,Account>();
        for(Account ac: oppList){
            acc.add(ac.id);
            acclist.put(ac.id,ac);
            
        }
        
        string this_year=string.valueOf(System.Today().year());
        system.debug('this year is'+this_year);
        list<account>ac=new list<account>();
        
        boolean check=false;
        for(account ac1:acclist.values()){

            if(ac1.This_Year_Total_level__c<1000 || ac1.This_Year_Total_level__c==null){
                ac1.Level_c__c=null;
                ac1.Previous_Level_c__c =null;
            }
            if(ac1.This_Year_Total_level__c >=1000 && ac1.This_Year_Total_level__c<=4999){
                ac1.Level_c__c=Label.Influencer_Circle;
            }
            if(ac1.This_Year_Total_level__c >=5000 && ac1.This_Year_Total_level__c<=9999){
                ac1.Level_c__c=Label.Impact_Circle;
            }
            if(ac1.This_Year_Total_level__c >=10000 && ac1.This_Year_Total_level__c<=24999){
                ac1.Level_c__c=Label.Inspiration_Circle;
            }
            if(ac1.This_Year_Total_level__c >=25000 && ac1.This_Year_Total_level__c<=49999){
                ac1.Level_c__c=Label.Opportunity_Circle;
            }
            if(ac1.This_Year_Total_level__c >=50000 && ac1.This_Year_Total_level__c<=99999){
                ac1.Level_c__c=Label.Equity_Circle;
            }
            if(ac1.This_Year_Total_level__c >=100000 ){
                ac1.Level_c__c=Label.Founders_Circle;
            }
    }
    }

    public static void Decativateafliate(list<Account>oppList,Map<Id,Account> oldMap){
     set<id>acid=new set<id>();
        boolean check =false;
      map<id,Affiliated_Level__c>aff=new map<id,Affiliated_Level__c>();
        for(Account ac: oppList){
            if(ac.This_Year_Total_level__c < oldMap.get(ac.id).This_Year_Total_level__c && ac.Level_c__c!=oldMap.get(ac.id).Level_c__c){
               acid.add(ac.id); 
            }
            if(ac.This_Year_Total_level__c==0 && oldMap.get(ac.id).This_Year_Total_level__c!=null &&ac.Level_c__c==null && oldMap.get(ac.id).Level_c__c!=null){
                check = true;
                acid.add(ac.id);
            }
        }
        if(acid.size()>0){
        for(Affiliated_Level__c af:[select id,name,account__c,Campaign__c,Level__c,Lifetime_Giving__c from Affiliated_Level__c where  Status__c='active'and account__c IN :acid ]){
            af.name=af.name+'(Inactive)';
             af.Status__c='Inactive';
             af.Level__c=null;
             af.Campaign__c=null;//added 19-03
             //af.account__c=null;//added 18/03
              aff.put(af.id,af);
                 }    
        }
            //map<id,Affiliated_Level__c>heightlev=new map<id,Affiliated_Level__c>([select id,name,account__c,Campaign__c,Level__c,Lifetime_Giving__c from Affiliated_Level__c where account__c IN :acid  and Status__c='active' ORDER BY Lifetime_Giving__c DESC limit 1]);
            if(acid.size()>0 && check==false){
            for(Affiliated_Level__c af:[select id,name,account__c,Campaign__c,Level__c,Lifetime_Giving__c from Affiliated_Level__c where  Status__c='active'and account__c IN :acid  ORDER BY Lifetime_Giving__c DESC limit 1]){
                   af.name=af.name+'(Inactive)';
                    af.Status__c='Inactive';
                    af.Level__c=null;
                   af.Campaign__c=null;//added 19-03
                   //af.Account__c=null;//added 18/03
                    aff.put(af.id,af);
                 } 
            }
        
        if(aff.size()>0){
            update aff.values();
                }
    }
    public static void fieldupdate(list<Account>oppList,Map<Id,Account> oldMap){
         
    set<Id> con = new set<Id>();    
    
    Id AccRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Organization').getRecordTypeId();
    Id Acc1RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Household Account').getRecordTypeId();
    
    for(Account acc:oppList){
        if(acc.No_of_Opp_s__c >= 1){
            acc.Opp_Availability__c = true;
        }
        
        if(acc.RecordTypeId == AccRecordTypeId ){
            
            acc.Donor_Listing_Preference__c =acc.Name;
        }else if(acc.RecordTypeId == Acc1RecordTypeId ){
            
            acc.Donor_Listing_Preference__c =acc.ContactFullName__c ;
            con.add(acc.id);
         
        }
        
    }
    
    //List<Contact> clst =[select id, name,MailingCity,MailingCountry,MailingPostalCode,MailingState,MailingStreet from contact where id =:con];
    
   /* for(Account accc :[select id,name,BillingCity,BillingCountry,BillingPostalCode,BillingState,BillingStreet,(select id, name,MailingCity,MailingCountry,MailingPostalCode,MailingState,MailingStreet from contacts) from account where id IN:con]){
        for(Contact cont :accc.contacts){
            accc.BillingCity = cont.MailingCity;
            accc.BillingCountry = cont.MailingCountry;
            accc.BillingPostalCode = cont.MailingPostalCode;
            accc.BillingState = cont.MailingState;
            accc.BillingStreet = cont.MailingStreet;
        }
    }*/
   
        
    }
}