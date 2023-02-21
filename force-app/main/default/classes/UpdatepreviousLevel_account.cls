public class UpdatepreviousLevel_account {
    public static void UpdatePreviouslevel_ACC(list<Affiliated_Level__c>AF_Account,Map<Id,Affiliated_Level__c> oldMap){
        
        set<id>aid=new set<id>();
    map<id,account>amap=new map<id,account>();
    for(Affiliated_Level__c af:AF_Account){
       aid.add(af.Account__c); 
        //amap.put(af.id,af.Account__c);
    }
        system.debug('the level is'+aid);
  //for(account ac:[select id,level_c__c,Previous_Level_c__c from account where id IN:aid])
  map<id,Affiliated_Level__c>afleve=new map<id,Affiliated_Level__c>([select id,name,account__c,Campaign__c,Level__c,Lifetime_Giving__c from Affiliated_Level__c where account__c IN :aid and Status__c='active' ORDER BY Lifetime_Giving__c DESC]);
  system.debug('the afliated level is'+afleve);
        system.debug('the afliated level is'+afleve.size());
    for(account ac:[select id,Level_c__c,Previous_Level_c__c from account where id IN:aid]){
        if(afleve.size()>1){
            system.debug('the level is below that'+afleve.size());
            system.debug('.................'+afleve.values()[1].level__c);
            if(afleve.values()[1].account__c==ac.id && ac.level_c__C!=afleve.values()[1].account__c){
                system.debug('the level is below that'+ac.level_c__C);
                ac.Previous_Level_c__c=afleve.values()[1].level__c;
                amap.put(ac.id,ac);
            }
            if(ac.level_c__C==afleve.values()[1].account__c && afleve.values()[1].account__c==ac.id){
                 system.debug('the level is below that'+ac.level_c__C);
                ac.Previous_Level_c__c=null;
                amap.put(ac.id,ac);
            }
            
            
        }
        if(afleve.size()<=1){
            system.debug('the level is below that'+afleve.size());
           ac.Previous_Level_c__c=null; 
            amap.put(ac.id,ac);
        }
    }
    if(amap.size()>0){
        update amap.values();
    }
    
}
}