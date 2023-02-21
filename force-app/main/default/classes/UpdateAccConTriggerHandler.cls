public class UpdateAccConTriggerHandler{
    
    public static void updateContacts(List<Opportunity> oppList,Map<Id,Opportunity> oldMap){
        set<Id> accIds = new set<Id>();
        list<Id> conIds= new list<Id>();
        set<Id>  camIds=new set<Id>();
        set<Id> sfcIds=new set<id>();
        set<Id> oldContactIds = new Set<Id>();
        list<campaign> cs=new list<campaign>();
        list<opportunity> cmps=new list<opportunity>();
        //list<account> Accounts_DateUpdate = new list<account>(); 
        list<contact> contacts_DateUpdate=new list<contact>();
        // list<account> Accounts_AmountUpdate = new list<account>();
        list<contact> contacts_AmountUpdate=new list<contact>();
        list<opportunity> OpplistToUpdate = new list<opportunity>();
        
        Id donorRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByDeveloperName().get('Donation').getRecordTypeId();
        //if(checkRecursiv.run==true) {
            //checkRecursiv.run =false;
            for(opportunity o:oppList){
                accIds.add(o.accountId);
                conIds.add(o.Primary_Contact1__c);
                camIds.add(o.campaignId);
                sfcIds.add(o.Soft_Credit__c);
                if(oldMap!=null && oldMap.containsKey(o.Id) && o.Soft_Credit__c != oldMap.get(o.Id).Soft_Credit__c && oldMap.get(o.Id).Soft_Credit__c!=null){
                    oldContactIds.add(oldMap.get(o.Id).Soft_Credit__c);
                }
                if(oldMap!=null && oldMap.containsKey(o.Id) && o.Primary_Contact1__c != oldMap.get(o.Id).Primary_Contact1__c && oldMap.get(o.Id).Primary_Contact1__c!=null){
                    oldContactIds.add(oldMap.get(o.Id).Primary_Contact1__c);
                }
            }
            Map<Id,contact> contactmap = new Map<Id,contact>([Select id,lastName, (Select id, closedate,Close_Date_Year__c ,amount,stageName,RecordType.Name From Opportunities1__r
                                                                                   WHERE RecordType.Name='Donation' and StageName='closed won' and Amount !=null and Soft_Credit__c=null), (Select id, closedate,Close_Date_Year__c ,amount,stageName,RecordType.Name From Opportunities__r
                                                                                                                                                                                            WHERE RecordType.Name='Donation' and StageName='closed won' and Amount !=null) from contact
                                                              where Id IN : conIds or Id IN:sfcIds Or Id In:oldContactIds]);
            
            
            Map<Id,contact> softCreditMap = new Map<Id,contact>([Select id,lastName, (Select id, closedate,Close_Date_Year__c,amount,stageName,RecordType.Name From Opportunities__r
                                                                                      WHERE RecordType.Name='Donation') from contact
                                                                 where Id IN:sfcIds]);
            system.debug('======contactmap======'+contactmap);                                            
            //  Map<Id,contact> contactmap2 = new Map<Id,contact>([Select id,lastName, (Select id, closedate, amount,stageName,RecordType.Name From Opportunities
            //  WHERE RecordType.Name!='Donation' OR StageName!='closed won' OR Amount=0.00) from contact
            // where Id IN : conIds OR Id IN:sfcIds]);
            
            Map<Id,Contact> conMap = new Map<Id,Contact>();
            map<id,account>accmap=new map<id,account>();
            
            for(Opportunity opp :oppList){               
                Id conId = (opp.Soft_Credit__c!=null)?opp.Soft_Credit__c:opp.Primary_Contact1__c;
                if(conId!=null) {
                    if(contactmap.containsKey(conId) ){
                        Contact con = contactmap.get(conId);
                        prepareContact(con,conMap);
                    }
                }
                if(trigger.isafter && trigger.isdelete && oldMap.get(opp.Id).Primary_Contact1__c!=null){
                    if(contactmap.containsKey(opp.Primary_Contact1__c) ){
                        Contact con = contactmap.get(opp.Primary_Contact1__c);
                        prepareContact(con,conMap);
                    }
                }
                if(oldMap!=null && oldMap.containsKey(opp.Id) && oldMap.get(opp.Id).Soft_Credit__c==null  && opp.Soft_Credit__c!=null && opp.Primary_Contact1__c == oldMap.get(opp.Id).Primary_Contact1__c  && opp.Primary_Contact1__c!=null){
                    if(contactmap.containsKey(opp.Primary_Contact1__c) ){
                        Contact con = contactmap.get(opp.Primary_Contact1__c);
                        prepareContact(con,conMap);
                    }
                }
                
                if(oldMap!=null && oldMap.containsKey(opp.Id) && opp.Soft_Credit__c != oldMap.get(opp.Id).Soft_Credit__c && oldMap.get(opp.Id).Soft_Credit__c!=null && contactmap.containsKey(oldMap.get(opp.Id).Soft_Credit__c) && oldMap.get(opp.Id).Soft_Credit__c!=null){
                    Contact con = contactmap.get(oldMap.get(opp.Id).Soft_Credit__c);
                    prepareContact(con,conMap);
                }
                if(oldMap!=null && oldMap.containsKey(opp.Id) && opp.Primary_Contact1__c != oldMap.get(opp.Id).Primary_Contact1__c && opp.Primary_Contact1__c!=null && contactmap.containsKey(oldMap.get(opp.Id).Primary_Contact1__c)){
                    Contact con = contactmap.get(opp.Primary_Contact1__c);
                    prepareContact(con,conMap);
                }
                if(oldMap!=null && oldMap.containsKey(opp.Id) && opp.Primary_Contact1__c != oldMap.get(opp.Id).Primary_Contact1__c && oldMap.get(opp.Id).Primary_Contact1__c!=null && contactmap.containsKey(oldMap.get(opp.Id).Primary_Contact1__c)){
                    Contact con = contactmap.get(oldMap.get(opp.Id).Primary_Contact1__c);
                    prepareContact(con,conMap);
                }
                
            }
            try{
                if(conMap.size()>0){
                    contacts_DateUpdate.AddAll(conMap.values());
                    update contacts_DateUpdate;
                } 
            }catch(Exception e){
                system.debug('Exception on UpdateAccCon '+e.getMessage()+e.getLineNumber());
                
                // we dont need to update the campaign. we have to update contact and this was inside the FOR lo
            }
            //checkRecursiv.run = false;
            
            //}
        //}
    }
    public static void updateAccount(List<Opportunity> oppList,Map<Id,Opportunity> oldMap){
        list<Id> accIds = new list<Id>();
        set<Id> SoftIds = new set<Id>();
        set<Id> oldAccounts = new Set<Id>();
        set<Id> primarycon = new Set<Id>();
        set<Id> oldPrimaryacc = new Set<Id>();
        // list<opportunity> cmps=new list<opportunity>();
        list<account> Accounts_DateUpdate = new list<account>();
        list<opportunity> OpplistToUpdate = new list<opportunity>();
        Id donorRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByDeveloperName().get('Donation').getRecordTypeId();
    //checkRecursiv.run =false;
    if(checkRecursiv.run==true) {
            for(opportunity o:oppList){
                accIds.add(o.accountId);
                SoftIds.add(o.Soft_Account__c);
                primarycon.add(o.Primary_Account__c);
                if(oldMap!=null && oldMap.containsKey(o.Id) && o.AccountId!= oldMap.get(o.Id).AccountId && oldMap.get(o.Id).AccountId!=null){
                    oldAccounts.add(oldMap.get(o.Id).accountId);
                }
                if(oldMap!=null && oldMap.containsKey(o.Id) && o.Soft_Account__c != oldMap.get(o.Id).Soft_Account__c && oldMap.get(o.Id).Soft_Account__c!=null){
                    oldAccounts.add(oldMap.get(o.Id).Soft_Account__c);
                }
                if(oldMap!=null && oldMap.containsKey(o.Id) && o.Primary_Account__c != oldMap.get(o.Id).Primary_Account__c && oldMap.get(o.Id).Primary_Account__c!=null){
                    oldAccounts.add(oldMap.get(o.Id).Primary_Account__c);
                }
            }
            Map<Id,Account> Accountmap = new Map<Id,Account>([Select id,Name,(Select id, closedate,Close_Date_Year__c ,amount,stageName,RecordType.Name From Opportunities
                                                                              WHERE RecordType.Name='Donation' and StageName='closed won' and Amount !=null ), (Select id, closedate,Close_Date_Year__c ,amount,stageName,RecordType.Name From Opportunities__r
                                                                                                                                                                WHERE RecordType.Name='Donation' and StageName='closed won' and Amount !=null And Soft_Account__c!=null),(Select id, closedate,Close_Date_Year__c ,amount,stageName,RecordType.Name From Opportunities1__r
                                                                                                                                                                                                                                                                          WHERE RecordType.Name='Donation' and StageName='closed won' and Amount !=null And Primary_Account__c!=null) from Account
                                                              where Id IN : accIds or Id IN:SoftIds Or Id In:oldAccounts or Id IN:primarycon]);
            
            
            
            system.debug('======Accountmap======'+Accountmap);
            // system.debug('======Accountmap======'+primaryacc);
            List<OpportunityWrapper> oppyListSortByAmount = new List<OpportunityWrapper>();
            List<OpportunityWrapper> oppyListSOrtByCloseDate = new List<OpportunityWrapper>();     
            map<id,account>accmap=new map<id,account>();
            for(Opportunity opp :oppList){
                
                oppyListSortByAmount = new List<OpportunityWrapper>();
                oppyListSOrtByCloseDate = new List<OpportunityWrapper>(); 
                // Id AccId = (opp.Soft_Account__c!=null)?opp.Soft_Account__c:opp.AccountId;
                if(opp.AccountId!=null ){
                    if(Accountmap.containsKey(opp.AccountId) ){
                        Account Acc = Accountmap.get(opp.AccountId);
                        prepareAcc(Acc,accmap);
                    }
                    
                }
                if(opp.Soft_Account__c!=null ){
                    if(Accountmap.containsKey(opp.Soft_Account__c) ){
                        Account Acc = Accountmap.get(opp.Soft_Account__c);
                        prepareAcc(Acc,accmap);
                    }
                    
                }
                if(opp.Primary_Account__c!=null){
                    if(Accountmap.containsKey(opp.Primary_Account__c) ){
                        Account Acc = Accountmap.get(opp.Primary_Account__c); 
                        prepareAcc(Acc,accmap);
                    }
                }
                /*  if(trigger.isafter && trigger.isdelete && oldMap.get(opp.Id).accountId!=null){
if(Accountmap.containsKey(opp.accountId) ){
Account con = Accountmap.get(opp.accountId);
prepareAcc(con,accmap);
}
} */
                /* if(trigger.isafter && opp.accountId!=null && (opp.AccountId==opp.Primary_Account__c || opp.AccountId!=opp.Primary_Account__c) ){
if(primaryacc.containsKey(opp.AccountId) ){
Account con = Accountmap.get(opp.accountId);
prepareAcc(con,accmap);
}
}*/
                if(oldMap!=null && oldMap.containsKey(opp.Id) && opp.accountId != oldMap.get(opp.Id).accountId && oldMap.get(opp.Id).accountId!=null && Accountmap.containsKey(oldMap.get(opp.Id).accountId) && oldMap.get(opp.Id).accountId!=null  ){
                    Account con = Accountmap.get(oldMap.get(opp.Id).accountId);
                    prepareAcc(con,accmap);
                }
                if(oldMap!=null && oldMap.containsKey(opp.Id) && opp.Primary_Account__c != oldMap.get(opp.Id).Primary_Account__c && oldMap.get(opp.Id).Primary_Account__c!=null &&  Accountmap.containsKey(oldMap.get(opp.Id).Primary_Account__c) && oldMap.get(opp.Id).Primary_Account__c!=null){
                    Account con = Accountmap.get(oldMap.get(opp.Id).Primary_Account__c);
                    prepareAcc(con,accmap);
                }
                if(oldMap!=null && oldMap.containsKey(opp.Id) && opp.Soft_Account__c != oldMap.get(opp.Id).Soft_Account__c && oldMap.get(opp.Id).Soft_Account__c!=null && Accountmap.containsKey(oldMap.get(opp.Id).Soft_Account__c) && oldMap.get(opp.Id).Soft_Account__c!=null){
                    Account con = Accountmap.get(oldMap.get(opp.Id).Soft_Account__c);
                    prepareAcc(con,accmap);
                }
                /*   if(oldMap!=null && oldMap.containsKey(opp.Id) && opp.accountId != oldMap.get(opp.Id).accountId && opp.accountId!=null && Accountmap.containsKey(oldMap.get(opp.Id).accountId)){
Account con = Accountmap.get(opp.accountId);
prepareAcc(con,accmap);
}
if(oldMap!=null && oldMap.containsKey(opp.Id) && opp.accountId != oldMap.get(opp.Id).accountId && oldMap.get(opp.Id).accountId!=null && Accountmap.containsKey(oldMap.get(opp.Id).accountId)){
Account con = Accountmap.get(oldMap.get(opp.Id).accountId);
prepareAcc(con,accmap);
}*/
            }
            try{
                if(accmap.size()>0){
                    Accounts_DateUpdate.AddAll(accmap.values());
                    update Accounts_DateUpdate;
                    system.debug('Acount values'+Accounts_DateUpdate);
                }
            }catch(Exception e){
                system.debug('Exception on UpdateAccCon '+e.getMessage()+e.getLineNumber());
            }
            //}
            checkRecursiv.run = false;
        }
    }
    
    public static void updateCampain(List<Opportunity> oppList){
        Set<String> closeDateYers = new Set<String>();
        Map<String,String> campaignYearMap = new Map<String,String>();
        for(Opportunity opp : oppList){
            if(opp.CampaignId==null){
                closeDateYers.add(opp.Close_Date_Year__c);
            }
        }
        list<campaign>camlist=new list<campaign>([select Id,Name,Campaign_Year__c from campaign WHERE Campaign_Year__c IN: closeDateYers and Name LIKE '%Annual Campaign%']);
        for(campaign c:camlist){
            campaignYearMap.put(c.Campaign_Year__c,c.Id);
        }
        
        for(Opportunity opp : oppList){
            if(campaignYearMap.containsKey(opp.Close_Date_Year__c)){
                opp.CampaignId = campaignYearMap.get(opp.Close_Date_Year__c);
            }
            if((campaignYearMap.containsKey(opp.Close_Date_Year__c))==false && opp.CampaignId==null){
                opp.CampaignId = null;
            }
        }
        
        
    }
    
    
    //Custom donation list
    Public static void setContactFieldvalues(contact con){
        
        con.First_Gift_Amount__c=  null;
        con.First_Gift_Date__c = null;
        con.Last_Gift_date__c= null;
        con.Last_Gift_Amount__c= null;
        con.Largest_Gift_Date__c= null;
        con.Largest_gift_Amount__c=null;
        con.Average_Gift__c= null;
        con.Smallest_Gift__c=  null;
        con.Best_Gift_year__c= null;
        con.Best_Gift_Year_Total_Donations__c=null;
        con.Lifetime_Giving_Donations__c=null;
        con.This_Year_Totals_Gift__c=null;
        con.Donor__c=false;
    }
    //soft credit list
    Public static void setsofcredit(contact con){
        
        con.npsp__First_Soft_Credit_Amount__c= null;
        con.npsp__First_Soft_Credit_Date__c = null;
        con.npsp__Last_Soft_Credit_Date__c= null;
        con.npsp__Last_Soft_Credit_Amount__c= null;
        con.npsp__Largest_Soft_Credit_Date__c= null;
        con.npsp__Largest_Soft_Credit_Amount__c=null;
        con.Lifetime_Giving_Soft_Credit__c=null;
        con.Smallest_SoftCredit_Gift__c= null;
        con.Best_Soft_credit_Gift_Year__c=null;
        con.Average_Soft_Credit_Gift__c=null;
        con.Best_Soft_credit_Gift_Year_Total__c=null;
        con.Total_Soft_Credit_This_Year__c=null;
    } 
    //primary contact
    Public static void PrimaryCon(contact con){
        
        con.First_primary_Gift_Amount__c=  null;
        con.First_Primary_Gift_Date__c =null;
        con.Last_Primary_Gift_Date__c= null;
        con.Last_Primary_Gift_Amount__c= null;
        con.Largest_Primary_Gift_Date__c= null;
        con.Largest_Primary_Gift_Amount__c=null;
        con.Lifetime_primary_Contact_Giving__c= null;
        con.Smallest_Primary_Gift__c=null;
        con.Best_Primary_Gift_Year__c= null;
        con.Average_Primary_Gift__c=null;
        con.Best_Primary_Gift_Year_Total__c=null;
        con.Total_Primary_Contact_This_Year__c=null;
    } 
    
    //Custom donation for values fill
    Public static void setContactFieldvalues(List<Opportunity> oppList,Contact con,List<OpportunityWrapper> oppyListSortByAmount,List<OpportunityWrapper> oppyListSOrtByCloseDate){
        
        oppyListSortByAmount = OpportunityTriggerUtility.sortbyAmount(oppList);
        oppyListSOrtByCloseDate = OpportunityTriggerUtility.sortbyCloseDate(oppList);
        
        
        con.Last_Gift_Amount__c=  oppyListSOrtByCloseDate.get(oppyListSOrtByCloseDate.size()-1).oppy.Amount;
        con.Last_Gift_date__c = oppyListSOrtByCloseDate.get(oppyListSOrtByCloseDate.size()-1).oppy.CloseDate;
        con.First_Gift_Date__c= oppyListSOrtByCloseDate.get(0).oppy.CloseDate;
        con.First_Gift_Amount__c= oppyListSOrtByCloseDate.get(0).oppy.Amount;
        
        con.Largest_Gift_Date__c= oppyListSortByAmount.get(oppyListSortByAmount.size()-1).oppy.CloseDate;
        con.Largest_gift_Amount__c=oppyListSortByAmount.get(oppyListSortByAmount.size()-1).oppy.Amount;
        con.Average_Gift__c= OpportunityTriggerUtility.averageAmount(oppList);
        con.Smallest_Gift__c=  oppyListSortByAmount.get(0).oppy.Amount;
        con.Lifetime_Giving_Donations__c= OpportunityTriggerUtility.TotalSoft(oppList);
        con.Best_Gift_year__c= String.Valueof(oppyListSortByAmount.get(oppyListSortByAmount.size()-1).oppy.CloseDate.year());
        con.Best_Gift_Year_Total_Donations__c =OpportunityTriggerUtility.Bestyeartotal(oppList);
        con.This_Year_Totals_Gift__c=OpportunityTriggerUtility.thisyeartotal1(oppList);
        con.Donor__c=true;
    }
    //primary contact for values
    Public static void PrimaryCon(List<Opportunity> oppList,Contact con,List<OpportunityWrapper> oppyListSortByAmount,List<OpportunityWrapper> oppyListSOrtByCloseDate){
        
        oppyListSortByAmount = OpportunityTriggerUtility.sortbyAmount(oppList);
        oppyListSOrtByCloseDate = OpportunityTriggerUtility.sortbyCloseDate(oppList);
        system.debug('oppyListSOrtByCloseDate'+oppyListSOrtByCloseDate);
        
        con.Last_Primary_Gift_Amount__c=  oppyListSOrtByCloseDate.get(oppyListSOrtByCloseDate.size()-1).oppy.Amount;
        con.Last_Primary_Gift_Date__c = oppyListSOrtByCloseDate.get(oppyListSOrtByCloseDate.size()-1).oppy.CloseDate;
        con.First_Primary_Gift_Date__c= oppyListSOrtByCloseDate.get(0).oppy.CloseDate;
        con.First_primary_Gift_Amount__c= oppyListSOrtByCloseDate.get(0).oppy.Amount;
        
        
        
        con.Largest_Primary_Gift_Date__c= oppyListSortByAmount.get(oppyListSortByAmount.size()-1).oppy.CloseDate;
        con.Largest_Primary_Gift_Amount__c=oppyListSortByAmount.get(oppyListSortByAmount.size()-1).oppy.Amount;
        con.Lifetime_primary_Contact_Giving__c= OpportunityTriggerUtility.TotalSoft(oppList);
        con.Smallest_Primary_Gift__c=  oppyListSortByAmount.get(0).oppy.Amount;
        con.Best_Primary_Gift_Year__c= String.Valueof(oppyListSortByAmount.get(oppyListSortByAmount.size()-1).oppy.CloseDate.year());
        con.Average_Primary_Gift__c=OpportunityTriggerUtility.averageAmount(oppList);
        con.Best_Primary_Gift_Year_Total__c= OpportunityTriggerUtility.Bestyeartotal(oppList);
        con.Total_Primary_Contact_This_Year__c=OpportunityTriggerUtility.thisyeartotal1(oppList);
    }
    // Soft credit for vaues Contact
    Public static void setsofcredit(List<Opportunity> oppList,Contact con,List<OpportunityWrapper> oppyListSortByAmount,List<OpportunityWrapper> oppyListSOrtByCloseDate){
        
        oppyListSortByAmount = OpportunityTriggerUtility.sortbyAmount(oppList);
        oppyListSOrtByCloseDate = OpportunityTriggerUtility.sortbyCloseDate(oppList);
        
        con.npsp__Last_Soft_Credit_Amount__c=  oppyListSOrtByCloseDate.get(oppyListSOrtByCloseDate.size()-1).oppy.Amount;
        con.npsp__Last_Soft_Credit_Date__c = oppyListSOrtByCloseDate.get(oppyListSOrtByCloseDate.size()-1).oppy.CloseDate;
        con.npsp__First_Soft_Credit_Date__c= oppyListSOrtByCloseDate.get(0).oppy.CloseDate;
        con.npsp__First_Soft_Credit_Amount__c= oppyListSOrtByCloseDate.get(0).oppy.Amount;
        
        
        con.npsp__Largest_Soft_Credit_Date__c= oppyListSortByAmount.get(oppyListSortByAmount.size()-1).oppy.CloseDate;
        con.npsp__Largest_Soft_Credit_Amount__c=oppyListSortByAmount.get(oppyListSortByAmount.size()-1).oppy.Amount;
        con.Lifetime_Giving_Soft_Credit__c= OpportunityTriggerUtility.TotalSoft(oppList);
        con.Smallest_SoftCredit_Gift__c=  oppyListSortByAmount.get(0).oppy.Amount;
        con.Best_Soft_credit_Gift_Year__c= String.Valueof(oppyListSortByAmount.get(oppyListSortByAmount.size()-1).oppy.CloseDate.year());
        con.Average_Soft_Credit_Gift__c=OpportunityTriggerUtility.averageAmount(oppList);
        con.Best_Soft_credit_Gift_Year_Total__c=OpportunityTriggerUtility.Bestyeartotal(oppList);
        con.Total_Soft_Credit_This_Year__c=OpportunityTriggerUtility.thisyeartotal1(oppList);
    }
    ///////////////////////Account Rolleups///////////////////////////////
    Public static void Primaryacc(Account con){
        
        con.First_primary_Gift_Amount__c=  null;
        con.First_Primary_Gift_Date__c =null;
        con.Last_Primary_Gift_Date__c= null;
        con.Last_Primary_Gift_Amount__c= null;
        con.Largest_Primary_Gift_Date__c= null;
        con.Largest_Primary_Gift_Amount__c=null;
        con.Lifetime_primary_Contact_Giving__c= null;
        con.Smallest_Primary_Gift__c=null;
        con.Best_Primary_Gift_Year__c= null;
        con.Average_Primary_Gift__c=null;
        con.Best_Primary_Gift_Year_Total__c=null;
        con.Total_Primary_Contact_This_Year__c=null;
    } 
    // acouunt list
    Public static void setAccountFieldvalues(Account con){
        
        //con.Last_GiftAmount__c= null;
        //con.Last_GiftDate__c =null;
        // con.First_GiftDate__c= null;
        con.First_Gift_Amount__c= null;
        con.Largest_Gift_Date__c= null;
        con.This_Year_Totals__c=null;
        //con.LargestGift__c=null;
        //con.Lifetime_Giving_Amount__c=null;
        //con.SmallestGift__c=null;
        //con.Best_GiftYear__c=null;
        //con.Average_Gift__c=null;
        //con.Best_Gift_YearTotal__c=null;
        con.Active__c=false;
        
    }
    Public static void AccountSoftcredit(Account con){
        con.Last_Soft_Credit_Amount__c= null;
        con.Last_Soft_Credit_Date__c = null;
        con.First_Soft_Credit_Date__c=null;
        con.First_Soft_Credit_Amount__c= null;
        con.Largest_Soft_Credit_Date__c= null;
        con.Largest_Soft_Credit_Amount__c= null;
        con.Lifetime_Giving_Soft_Credit__c= null;
        con.Smallest_Soft_Credit_Gift__c=  null;
        con.Best_Soft_credit_Gift_Year__c= null;
        con.Average_Soft_Credit_Gift__c=null;
        con.Best_Soft_credit_Gift_Year_Total__c=null;
        con.Total_Soft_Credit_This_Year__c=null;
    }
    Public static void CustomAccTotals(Account con){
        
        con.Last_Totals_Gift_Amount__c=  null;
        con.Last_Totals_Gift_Date__c = null;
        con.First_Gift_Totals_Date__c= null;
        con.First_Totals_Gift_Amount__c= null;
        con.Largest_Totals_Gift_Date__c= null;
        con.Largest_Totals_Gift__c=null;
        con.Lifetime_Giving_Totals__c= null;
        con.Smallest_Totals_Gift__c=  null;
        con.Best_Totals_Gift_Year__c= null;
        con.Average_Totals_Gift__c=null;
        con.Best_Totals_Gift_Year_Total__c=null;
        con.This_Year_Totals_Gift__c=null;
        
    }
    //Custom donation for values fill
    
    //accoutn for values
    Public static void setAccountFieldvalues(List<Opportunity> oppList,Account con,List<OpportunityWrapper> oppyListSortByAmount,List<OpportunityWrapper> oppyListSOrtByCloseDate){
        
        oppyListSortByAmount = OpportunityTriggerUtility.sortbyAmount(oppList);
        oppyListSOrtByCloseDate = OpportunityTriggerUtility.sortbyCloseDate(oppList);
        con.First_Gift_Amount__c= oppyListSOrtByCloseDate.get(0).oppy.Amount;
        con.Largest_Gift_Date__c= oppyListSortByAmount.get(oppyListSortByAmount.size()-1).oppy.CloseDate;
        con.This_Year_Totals__c=OpportunityTriggerUtility.thisyeartotal1(oppList);
        con.Active__c=true;
    }
    //primary contact for values
    Public static void Primaryacc(List<Opportunity> oppList,Account con,List<OpportunityWrapper> oppyListSortByAmount,List<OpportunityWrapper> oppyListSOrtByCloseDate){
        
        oppyListSortByAmount = OpportunityTriggerUtility.sortbyAmount(oppList);
        oppyListSOrtByCloseDate = OpportunityTriggerUtility.sortbyCloseDate(oppList);
        system.debug('oppyListSOrtByCloseDate'+oppyListSOrtByCloseDate);
        
        con.Last_Primary_Gift_Amount__c=  oppyListSOrtByCloseDate.get(oppyListSOrtByCloseDate.size()-1).oppy.Amount;
        con.Last_Primary_Gift_Date__c = oppyListSOrtByCloseDate.get(oppyListSOrtByCloseDate.size()-1).oppy.CloseDate;
        con.First_Primary_Gift_Date__c= oppyListSOrtByCloseDate.get(0).oppy.CloseDate;
        con.First_primary_Gift_Amount__c= oppyListSOrtByCloseDate.get(0).oppy.Amount;
        
        
        
        con.Largest_Primary_Gift_Date__c= oppyListSortByAmount.get(oppyListSortByAmount.size()-1).oppy.CloseDate;
        con.Largest_Primary_Gift_Amount__c=oppyListSortByAmount.get(oppyListSortByAmount.size()-1).oppy.Amount;
        con.Lifetime_primary_Contact_Giving__c= OpportunityTriggerUtility.TotalSoft(oppList);
        con.Smallest_Primary_Gift__c=  oppyListSortByAmount.get(0).oppy.Amount;
        con.Best_Primary_Gift_Year__c= String.Valueof(oppyListSortByAmount.get(oppyListSortByAmount.size()-1).oppy.CloseDate.year());
        con.Average_Primary_Gift__c=OpportunityTriggerUtility.averageAmount(oppList);
        con.Best_Primary_Gift_Year_Total__c= OpportunityTriggerUtility.Bestyeartotal(oppList);
        con.Total_Primary_Contact_This_Year__c=OpportunityTriggerUtility.thisyeartotal1(oppList);
        
    }
    // Soft credit for vaues Contact
    
    //Custom Totals Account
    Public static void CustomAccTotals(List<Opportunity> oppList,Account con,List<OpportunityWrapper> oppyListSortByAmount,List<OpportunityWrapper> oppyListSOrtByCloseDate){
        
        oppyListSortByAmount = OpportunityTriggerUtility.sortbyAmount(oppList);
        oppyListSOrtByCloseDate = OpportunityTriggerUtility.sortbyCloseDate(oppList);
        
        con.Last_Totals_Gift_Amount__c=  oppyListSOrtByCloseDate.get(oppyListSOrtByCloseDate.size()-1).oppy.Amount;
        con.Last_Totals_Gift_Date__c = oppyListSOrtByCloseDate.get(oppyListSOrtByCloseDate.size()-1).oppy.CloseDate;
        con.First_Gift_Totals_Date__c= oppyListSOrtByCloseDate.get(0).oppy.CloseDate;
        con.First_Totals_Gift_Amount__c= oppyListSOrtByCloseDate.get(0).oppy.Amount;
        con.Largest_Totals_Gift_Date__c= oppyListSortByAmount.get(oppyListSortByAmount.size()-1).oppy.CloseDate;
        con.Largest_Totals_Gift__c=oppyListSortByAmount.get(oppyListSortByAmount.size()-1).oppy.Amount;
        con.Lifetime_Giving_Totals__c= OpportunityTriggerUtility.TotalSoft(oppList);
        con.Smallest_Totals_Gift__c=  oppyListSortByAmount.get(0).oppy.Amount;
        con.Best_Totals_Gift_Year__c= String.Valueof(oppyListSortByAmount.get(oppyListSortByAmount.size()-1).oppy.CloseDate.year());
        con.Average_Totals_Gift__c=OpportunityTriggerUtility.averageAmount(oppList);
        con.Best_Totals_Gift_Year_Total__c=OpportunityTriggerUtility.Bestyeartotal(oppList);
        con.This_Year_Totals_Gift__c=OpportunityTriggerUtility.thisyeartotal1(oppList);
        
    }
    //acount soft credit
    Public static void AccountSoftcredit(List<Opportunity> oppList,Account con,List<OpportunityWrapper> oppyListSortByAmount,List<OpportunityWrapper> oppyListSOrtByCloseDate){
        
        oppyListSortByAmount = OpportunityTriggerUtility.sortbyAmount(oppList);
        oppyListSOrtByCloseDate = OpportunityTriggerUtility.sortbyCloseDate(oppList);
        
        con.Last_Soft_Credit_Amount__c=  oppyListSOrtByCloseDate.get(oppyListSOrtByCloseDate.size()-1).oppy.Amount;
        con.Last_Soft_Credit_Date__c = oppyListSOrtByCloseDate.get(oppyListSOrtByCloseDate.size()-1).oppy.CloseDate;
        con.First_Soft_Credit_Date__c= oppyListSOrtByCloseDate.get(0).oppy.CloseDate;
        con.First_Soft_Credit_Amount__c= oppyListSOrtByCloseDate.get(0).oppy.Amount;
        con.Largest_Soft_Credit_Date__c= oppyListSortByAmount.get(oppyListSortByAmount.size()-1).oppy.CloseDate;
        con.Largest_Soft_Credit_Amount__c=oppyListSortByAmount.get(oppyListSortByAmount.size()-1).oppy.Amount;
        con.Lifetime_Giving_Soft_Credit__c= OpportunityTriggerUtility.TotalSoft(oppList);
        con.Smallest_Soft_Credit_Gift__c=  oppyListSortByAmount.get(0).oppy.Amount;
        con.Best_Soft_credit_Gift_Year__c= String.Valueof(oppyListSortByAmount.get(oppyListSortByAmount.size()-1).oppy.CloseDate.year());
        con.Average_Soft_Credit_Gift__c=OpportunityTriggerUtility.averageAmount(oppList);
        con.Best_Soft_credit_Gift_Year_Total__c=OpportunityTriggerUtility.Bestyeartotal(oppList);
        con.Total_Soft_Credit_This_Year__c=OpportunityTriggerUtility.thisyeartotal1(oppList);
    }
    
    //contact method
    public static void prepareContact(Contact con,Map<Id,Contact> conMap){
        List<OpportunityWrapper> oppyListSortByAmount = new List<OpportunityWrapper>();
        List<OpportunityWrapper> oppyListSOrtByCloseDate = new List<OpportunityWrapper>();   
        List<opportunity> opList = new List<Opportunity>();
        List<opportunity> SoList = new List<Opportunity>();
        List<opportunity> PrList = new List<Opportunity>();
        if(con.Opportunities1__r!=null && con.Opportunities1__r.size()>0){
            opList.addAll(con.Opportunities1__r);
            PrList.addAll(con.Opportunities1__r);
            system.debug('the soft credit values1'+PrList);
        }
        if(con.Opportunities__r!=null && con.Opportunities__r.size()>0){
            opList.addAll(con.Opportunities__r);
            SoList.addAll(con.Opportunities__r);
            system.debug('the soft credit values2'+opList);
        }
        if(opList.size()>0){
            setContactFieldvalues(opList,con,oppyListSortByAmount,oppyListSOrtByCloseDate);
            
        }
        else{
            setContactFieldvalues(con);
        }
        if(SoList.size()>0){
            setsofcredit(SoList,con,oppyListSortByAmount,oppyListSOrtByCloseDate);
        }
        else{
            setsofcredit(con);
        }
        if(PrList.size()>0){
            PrimaryCon(PrList,con,oppyListSortByAmount,oppyListSOrtByCloseDate);
        }
        else{
            PrimaryCon(con);
        }
        conMap.put(con.Id,con);
    }
    public static void prepareAcc(Account con,Map<Id,Account> conMap){
        List<OpportunityWrapper> oppyListSortByAmount = new List<OpportunityWrapper>();
        List<OpportunityWrapper> oppyListSOrtByCloseDate = new List<OpportunityWrapper>();   
        List<opportunity> opList = new List<Opportunity>();
        List<opportunity> SoList = new List<Opportunity>();
        List<opportunity> PrList = new List<Opportunity>();
        List<opportunity> PmList = new List<Opportunity>();
        if(con.Opportunities!=null && con.Opportunities.size()>0){
            opList.addAll(con.Opportunities);
            PrList.addAll(con.Opportunities);
            system.debug('the soft credit values1'+PrList);
        }
        if(con.Opportunities__r!=null && con.Opportunities__r.size()>0){
            opList.addAll(con.Opportunities__r);
            SoList.addAll(con.Opportunities__r);
            system.debug('the soft credit values2'+opList);
        }
        if(con.Opportunities1__r!=null && con.Opportunities1__r.size()>0){
            PmList.addAll(con.Opportunities1__r);
            //SoList.addAll(con.Opportunities__r);
            system.debug('the soft credit values2'+PmList);
        }
        if(opList.size()>0){
            CustomAccTotals(opList,con,oppyListSortByAmount,oppyListSOrtByCloseDate);
            
        }
        else{
            CustomAccTotals(con);
        }
        if(SoList.size()>0){
            AccountSoftcredit(SoList,con,oppyListSortByAmount,oppyListSOrtByCloseDate);
        }
        else{
            AccountSoftcredit(con);
        }
        if(PrList.size()>0){
            setAccountFieldvalues(PrList,con,oppyListSortByAmount,oppyListSOrtByCloseDate);
        }
        else{
            setAccountFieldvalues(con);
        }
        if(PmList.size()>0){
            Primaryacc(PmList,con,oppyListSortByAmount,oppyListSOrtByCloseDate);   
        }
        else
        {
            Primaryacc(con);
            
        }
        conMap.put(con.Id,con);
    }
}