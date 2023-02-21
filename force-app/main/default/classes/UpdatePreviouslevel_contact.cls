public class UpdatePreviouslevel_contact {
public static void UpdatePreviouslevel_con(list<Affiliated_Level_Contact__c>AF_contact,Map<Id,Affiliated_Level_Contact__c> oldMap){
     
    set<id>acid=new set<id>();
    set<id>lid=new set<id>();
    set<id>aid=new set<id>();
    map<id,contact>amap=new map<id,contact>();
    for(Affiliated_Level_Contact__c af:AF_contact){
       aid.add(af.contact__c); 
        //amap.put(af.id,af.Account__c);
    }
  //for(account ac:[select id,level_c__c,Previous_Level_c__c from account where id IN:aid])
  map<id,Affiliated_Level_Contact__c>afleve=new map<id,Affiliated_Level_Contact__c>([select id,name,contact__c,Campaign__c,Level__c,Campaign_Amount__c from Affiliated_Level_Contact__c where contact__c IN :aid and Status__c='active' ORDER BY Campaign_Amount__c DESC]);
  system.debug('the afliated level is'+afleve);
    for(contact ac:[select id,Previous_Level_c__c from contact where id IN:aid]){
        if(afleve.size()>1){
            system.debug('.................'+afleve.values()[1].level__c);
            if(afleve.values()[1].contact__c==ac.id){
                ac.Previous_Level_c__c=afleve.values()[1].level__c;
                amap.put(ac.id,ac);
            }
            
            
        }
        if(afleve.size()<=1){
           ac.Previous_Level_c__c=null; 
            amap.put(ac.id,ac);
        }
    }
    if(amap.size()>0){
        update amap.values();
    }
      
}
}