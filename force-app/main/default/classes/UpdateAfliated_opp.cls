public class UpdateAfliated_opp {
    
    public static void AmountOnAccount(list<Opportunity>Opplist,map<id,Opportunity>oldmap){
        
        system.debug('the class call');
        set<id>acc=new set<id>();
        Id donorRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByDeveloperName().get('Donation').getRecordTypeId();
        list<decimal>dc=new list<decimal>();
        string this_year=string.valueOf(System.Today().year());
        for(Opportunity op:Opplist){
            system.debug('the real account is'+op.Real_Account__c);
            system.debug('the real account is'+this_year);
            system.debug('the real account is'+donorRecordTypeId);
            system.debug('the real account is'+op.StageName);
            if(op.Real_Account__c!=null && op.Close_Date_Year__c ==this_year && op.RecordTypeId==donorRecordTypeId && op.StageName=='closed won'){
                acc.add(op.Real_Account__c);
                system.debug('the real account is'+op.Real_Account__c);
            }
        }
            system.debug('the real account is'+acc);
            //list<Opportunity>opplist=new list<Opportunity>([select id,name,Real_Account__c,StageName from Opportunity where Close_Date_Year__c=this_year and RecordType.Name='Donation' and StageName='closed won' and Real_Account__c IN:acc])
            AggregateResult[] groupedResults = [SELECT Real_Account__c, SUM(Amount) sum
                                                FROM Opportunity
                                                WHERE Close_Date_Year__c =:this_year AND RecordType.Name='Donation' and StageName='closed won' and Amount !=null and Real_Account__c IN :acc group by Real_Account__c
                                               ];
                                                    system.debug('grouped'+groupedResults);

            map<double,account>Lacc=new map<double,account>();
            
            for(account ac:[select id,This_Year_Total_level__c from account where id IN:acc]){
                
                if(groupedResults.size()>0){
                    ac.This_Year_Total_level__c=double.valueOf(groupedResults[0].get('sum'));
                    Lacc.put(ac.This_Year_Total_level__c,ac);
                                        system.debug('this year level'+ac.This_Year_Total_level__c);

                }
                
                if(groupedResults.size()==0){
                    ac.This_Year_Total_level__c=0; 
                    Lacc.put(ac.This_Year_Total_level__c,ac);
                    system.debug('preveous level'+ac.This_Year_Total_level__c);
                }
               system.debug('preveous level'+ac.This_Year_Total_level__c); 
            }
            update Lacc.values();
        
        
     }
   public static void AmountOnAccountUpdate(list<Opportunity>Opplist,map<id,Opportunity>oldmap){
        
        system.debug('the class call');
        set<id>acc=new set<id>();
        Id donorRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByDeveloperName().get('Donation').getRecordTypeId();
        list<decimal>dc=new list<decimal>();
        string this_year=string.valueOf(System.Today().year());
        for(Opportunity op:Opplist){
            system.debug('the real account is'+op.Real_Account__c);
            system.debug('the real account is'+this_year);
            system.debug('the real account is'+donorRecordTypeId);
            system.debug('the real account is'+op.StageName);
            if(op.Real_Account__c!=null && op.Close_Date_Year__c ==this_year && op.RecordTypeId==donorRecordTypeId && op.StageName=='closed won'){
                acc.add(op.Real_Account__c);
                system.debug('the real account is'+op.Real_Account__c);
            }
        }
            system.debug('the real account is'+acc);
            //list<Opportunity>opplist=new list<Opportunity>([select id,name,Real_Account__c,StageName from Opportunity where Close_Date_Year__c=this_year and RecordType.Name='Donation' and StageName='closed won' and Real_Account__c IN:acc])
            AggregateResult[] groupedResults = [SELECT Real_Account__c, SUM(Amount) sum
                                                FROM Opportunity
                                                WHERE Close_Date_Year__c =:this_year AND RecordType.Name='Donation' and StageName='closed won' and Amount !=null and Real_Account__c IN :acc group by Real_Account__c
                                               ];
            
            map<double,account>Lacc=new map<double,account>();
            
            for(account ac:[select id,This_Year_Total_level__c from account where id IN:acc]){
                
                if(groupedResults.size()>0){
                    ac.This_Year_Total_level__c=double.valueOf(groupedResults[0].get('sum'));
                    Lacc.put(ac.This_Year_Total_level__c,ac);
                }
                
                if(groupedResults.size()==0){
                    ac.This_Year_Total_level__c=0; 
                    Lacc.put(ac.This_Year_Total_level__c,ac);
                    system.debug('preveous level'+ac.This_Year_Total_level__c);
                }
               system.debug('preveous level'+ac.This_Year_Total_level__c); 
            }
            update Lacc.values();
       
        //When updating the opportunity real account
        set<id>upacount=new set<id>();
        double ammount=0;
        
        for(Opportunity opp:Opplist){
            
            system.debug('the real contact'+opp.Real_Account__c);
            system.debug('the real contact'+oldmap.get(opp.id).Real_Account__c);
            if(trigger.isupdate && opp.Real_Account__c!=oldmap.get(opp.id).Real_Account__c && oldmap.get(opp.id).Real_Account__c!=null){
               system.debug('the real contact'+oldmap.get(opp.id).Real_Account__c);
                upacount.add(oldmap.get(opp.id).Real_Account__c);
                ammount=oldmap.get(opp.id).Amount;
            }
        }
        map<id,account>updateacc=new map<id,account>();
       try{ 
       if(upacount.size()>0){
        for(account acc1:[select id,name,This_Year_Total_level__c from account where id IN:upacount]){
            acc1.This_Year_Total_level__c=acc1.This_Year_Total_level__c-ammount;
            if(acc1.This_Year_Total_level__c>=0)
            updateacc.put(acc1.id,acc1);
            system.debug('the update ammount is'+acc1.This_Year_Total_level__c);
        }
        
        }
       }catch(exception e){
           system.debug('the e is'+e);
       }
        if(updateacc.size()>0){
            update updateacc.values();}
    }
   
}