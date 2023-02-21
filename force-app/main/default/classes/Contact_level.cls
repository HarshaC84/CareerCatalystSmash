public class Contact_level {
    // This class is used to update the Level on the contact object using the this year total amount 
    public static void contactlevel(List<contact> conList,Map<Id,contact> oldMap){
        list<opportunity>opplist1=new list<opportunity>();
        map<id,contact>Contact_map=new map<id,contact>();
        for(contact con:conList){
            Contact_map.put(con.id,con); 
        }
        
        for(contact ac1:Contact_map.values()){
            system.debug('the levl enterd');
            if(ac1.This_Year_Totals_Gift_C__c<1000){
                system.debug('the This_Year_Totals_Gift__c is'+ac1.This_Year_Totals_Gift__c);
                ac1.Level_c__c=null;
            }
            if(ac1.This_Year_Totals_Gift_C__c >=1000 && ac1.This_Year_Totals_Gift_C__c<=4999){
                ac1.Level_c__c=Label.Influencer_Circle;
            }
            if(ac1.This_Year_Totals_Gift_C__c >=5000 && ac1.This_Year_Totals_Gift_C__c<=9999){
                ac1.Level_c__c=Label.Impact_Circle;
            }
            if(ac1.This_Year_Totals_Gift_C__c >=10000 && ac1.This_Year_Totals_Gift_C__c<=24999){
                ac1.Level_c__c=Label.Inspiration_Circle;
            }
            if(ac1.This_Year_Totals_Gift_C__c >=25000 && ac1.This_Year_Totals_Gift_C__c<=49999){
                ac1.Level_c__c=Label.Opportunity_Circle;
            }
            if(ac1.This_Year_Totals_Gift_C__c >=50000 && ac1.This_Year_Totals_Gift_C__c<=99999){
                ac1.Level_c__c=Label.Equity_Circle;
            }
            if(ac1.This_Year_Totals_Gift_C__c >=100000 ){
                ac1.Level_c__c=Label.Founders_Circle;
            }
        }  
        
    }
    public static void ContactAFLevel(list<contact> conList,Map<Id,contact> oldMap){
        
      
        set<id>aclit=new set<id>();
        map<id,contact>aclit1=new map<id,contact>();
        map<id,contact>aclit3=new map<id,contact>();
        set<id>aclit2=new set<id>();
        list<account>aclist=new list<account>();
        map<id,Affiliated_Level_Contact__c>af2=new map<id,Affiliated_Level_Contact__c>();
        map<id,Affiliated_Level_Contact__c>af3=new map<id,Affiliated_Level_Contact__c>();
        map<id,id>acid=new map<id,id>();
        set<id>levid=new set<id>();
        map<id,decimal>ammount=new map<id,decimal>();
        for(contact ac:conList){
            if(ac.Level_c__c!=oldmap.get(ac.id).Level_c__c && ac.This_Year_Totals_Gift_C__c>oldmap.get(ac.id).This_Year_Totals_Gift_C__c){
                aclit.add(ac.id);
                aclit1.put(ac.id,ac);
            }
            if(ac.Level_c__c!=oldmap.get(ac.id).Level_c__c && ac.This_Year_Totals_Gift_C__c<oldmap.get(ac.id).This_Year_Totals_Gift_C__c){
               aclit2.add(ac.id);
                aclit3.put(ac.id,ac);
                levid.add(ac.Level_c__c);
            }
            acid.put(ac.Level_c__c,ac.id);
            system.debug('the current level is'+ac.Level_c__c);
            //levid.add(ac.Level_c__c);
            ammount.put(ac.id,ac.This_Year_Totals_Gift_C__c);
            
        }
        system.debug('the current level is'+aclit);
        system.debug('the current level is'+aclit2);
        system.debug('the current level is'+levid);
        map<id,Affiliated_Level_Contact__c>afliated_list=new map<id,Affiliated_Level_Contact__c>([select id,name,Contact__r.name,Level__r.name,Contact__c,Level__c,Campaign_Amount__c,Status__c,Campaign__c from Affiliated_Level_Contact__c where Contact__c IN:aclit2 and Level__c IN:levid and Status__c='active']);
        system.debug('the ids are'+aclit);
        system.debug('the ids are'+levid);
        string This_year=string.valueOf(system.today().year());
        string name =This_year+' '+'Annual Campaign';
        
        list<id>dlist=new list<id>();
        
        if(aclit.size()>0){
            for(contact ac:aclit1.values()){
           try{ 
               if(ac.This_Year_Totals_Gift_C__c>=1000){
                        system.debug('the contact level');
                        Affiliated_Level_Contact__c al=new Affiliated_Level_Contact__c();
                        al.name=ac.lastname+' '+This_year+' '+ac.test__c;
                        al.contact__c=ac.id;
                        al.Level__c=ac.Level_c__c;
                        al.Campaign_Amount__c=ac.This_Year_Totals_Gift_C__c;
                        string ss=Label.Campain;
                       system.debug('the lable'+ss);
                        al.Campaign__c=ss;
                        al.Status__c='Active';
                        system.debug('the afliated one is'+al);
                        system.debug('the changed'+al.Name);
                        system.debug('the values'+af2.values());
                        af2.put(al.contact__c,al);
                        system.debug('the duplicate val'+al.Name);
               }
                    }catch(DmlException e) {
                        System.debug('The following exception has occurred: ' + e.getMessage());
                    }
         
            }  }     
                  
        if(afliated_list.size()==0){
            if(aclit3.size()>0){
            for(contact ac:aclit3.values()){
                if(ac.This_Year_Totals_Gift_C__c>=1000){
                Affiliated_Level_Contact__c al=new Affiliated_Level_Contact__c();
                        al.name=ac.lastname+' '+This_year+' '+ac.test__c;
                        al.contact__c=ac.id;
                        al.Level__c=ac.Level_c__c;
                        al.Campaign_Amount__c=ac.This_Year_Totals_Gift_C__c;
                        string ss=Label.Campain;
                       system.debug('the lable'+ss);
                        al.Campaign__c=ss;
                      
                   // al.Campaign__c='701J00000032XQXIA2';
                        al.Status__c='Active';
                        system.debug('the afliated one is'+al);
                        system.debug('the changed'+al.Name);
                        
                        
                        af3.put(al.contact__c,al);
                        system.debug('the values'+af2.values());
            }
            }
            }
          
    }
        try{
        if(af2.size()>0){
             system.debug('the values'+af2.values());
                database.insert(af2.values());} 
            if(af3.size()>0){
            system.debug('the values'+af2.values());
            database.insert(af3.values());}
        }catch(DmlException e) {
        System.debug('The following exception has occurred: ' + e.getMessage());
        }
    }
    public static void Decativateafliatecon(list<contact>oppList,Map<Id,contact> oldMap){
     set<id>acid=new set<id>();
     set<id>acid1=new set<id>();
      map<id,Affiliated_Level_Contact__c>aff=new map<id,Affiliated_Level_Contact__c>();
        for(contact ac: oppList){
            if(ac.This_Year_Totals_Gift_C__c < oldMap.get(ac.id).This_Year_Totals_Gift_C__c && ac.Level_c__c!=oldMap.get(ac.id).Level_c__c){
               acid.add(ac.id); 
                system.debug('the contact is'+acid);
            }
            if(ac.This_Year_Totals_Gift_C__c==0 && oldMap.get(ac.id).This_Year_Totals_Gift_C__c!=null &&ac.Level_c__c==null && oldMap.get(ac.id).Level_c__c!=null){
               acid1.add(ac.id);
                system.debug('the contact is'+acid1);
            }
        }
            //map<id,Affiliated_Level__c>heightlev=new map<id,Affiliated_Level__c>([select id,name,account__c,Campaign__c,Level__c,Lifetime_Giving__c from Affiliated_Level__c where account__c IN :acid  and Status__c='active' ORDER BY Lifetime_Giving__c DESC limit 1]);
                if(acid.size()>0){
                for(Affiliated_Level_Contact__c af:[select id,name,contact__c,Campaign__c,Level__c,Campaign_Amount__c from Affiliated_Level_Contact__c where contact__c IN :acid  and Status__c='active' ORDER BY Campaign_Amount__c DESC limit 1]){
                   af.name=af.name+'(Inactive)';
                    af.Status__c='Inactive';
                    af.Level__c=null;
                    af.Campaign__c=null;//added 19-03
                    //af.contact__c=null;//added 18/03
                    system.debug('the rec'+af.Contact__c);
                    aff.put(af.id,af);

            }
                }
                if(acid1.size()>0){
                    for(Affiliated_Level_Contact__c af:[select id,name,contact__c,Campaign__c,Level__c,Campaign_Amount__c from Affiliated_Level_Contact__c where contact__c IN :acid  and Status__c='active']){
                   af.name=af.name+'(Inactive)';
                    af.Status__c='Inactive';
                    af.Level__c=null;
                     af.Campaign__c=null;//19-03 add
                    //af.Contact__c=null;//added 18/03
                    aff.put(af.id,af);

            }
                }
        if(aff.size()>0){
            update aff.values();
                }
    }
}