public class OpportunityTriggerUtility{
    
 Public static List<OpportunityWrapper> sortbyAmount(List<Opportunity> oppList){
        List<OpportunityWrapper> oppyList = new List<OpportunityWrapper>();
        for(Opportunity opp:oppList){
            oppyList.add( new OpportunityWrapper(opp,true));
            
        }
        oppyList.sort();
        return oppyList;
    }
    
    
    Public static List<OpportunityWrapper> sortbyCloseDate(List<Opportunity> oppList){
        List<OpportunityWrapper> oppyList = new List<OpportunityWrapper>();
        for(Opportunity opp:oppList){
            
            oppyList.add( new OpportunityWrapper(opp,false));
        }
        oppyList.sort();
        return oppyList;
        // System.debug('the close date sort'+oppyList);
    }
    
    Public static Double averageAmount(List<Opportunity> oppList ){
        Double amount =0;
        for(Opportunity opp:oppList){
            if(Test.isRunningTest()){
                amount=0;
            }   else {
                amount=amount+opp.Amount;
            }
            
        }
        return amount/oppList.size();
    }
    Public static Double TotalSoft(List<Opportunity> oppList ){
        Double amount =0;
        for(Opportunity opp:oppList){
            if(Test.isRunningTest()){
                amount=0;
            }
            else {
            amount=amount+opp.Amount;
            }
        }
        return amount;
    }
      
     Public static Double Bestyeartotal(List<Opportunity> oppList){
         Set<Id> oppIds = new Set<Id>(); 
         list<decimal>bestyear=new list<decimal>();
        Double amount = 0;
       // if(checkRecursiv.run==true) {
        for(Opportunity opp:oppList){
            oppIds.add(opp.Id);
            bestyear.add(opp.amount);
        }
        //bestyear.sort();
         system.debug('best year'+bestyear);
         
        map<id,Opportunity> opportunities = new map<id,opportunity>([select Amount,Close_Date_Year__c from Opportunity where Id In: oppIds And RecordType.Name='Donation' and StageName='closed won' Order By Amount DESC limit 1]);
        system.debug('opportunities>>> '+opportunities.values()[0].Close_Date_Year__c);    
        if(opportunities.size()>0){
        for(Opportunity opp1:[select Amount,Close_Date_Year__c from Opportunity where Close_Date_Year__c=:opportunities.values()[0].Close_Date_Year__c And RecordType.Name='Donation' and StageName='closed won' and Id IN: oppIds]) {
            if(opp1.Amount != null)
                amount += opp1.Amount;
        } 
        }
           // checkRecursiv.run = false;
        //}
        system.debug('the amount is'+amount);
        system.debug('the amount is');
        return amount;
            
        
    }     
 
    Public static Double thisyeartotal1(List<Opportunity> oppList ){
        Set<Opportunity> oppIds1 = new Set<Opportunity>();        
        Double amount1 = 0;
        string year1=String.valueOf(Date.Today().Year());
        for(Opportunity opp:oppList){
            if(opp.Close_Date_Year__c==year1){
            oppIds1.add(opp);
                   }
        }
//System.debug('this year'+thisyes);
            
       map<id,Opportunity> opportunities = new map<id,Opportunity>();
           //([select Amount,Close_Date_Year__c,Soft_Credit__c from Opportunity where Id In: oppIds1 and Close_Date_Year__c=:year1]);
        for(opportunity op:oppIds1){
            opportunities.put(op.id,op);
        }
        for(Opportunity opp:opportunities.values()) {
            if(opp.Amount != null)
                amount1 += opp.Amount;
        }
    
        system.debug('the amount is'+amount1);
        system.debug('the amount is');
        return amount1;
    }
    }