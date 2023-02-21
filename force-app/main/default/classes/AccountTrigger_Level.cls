public class AccountTrigger_Level {
    public static void AccountLevel2(List<Account>oppList,map<id,account>old){    
       //if(CheckRecursive1.runOnce())
      //{
        set<id>aclit=new set<id>();
        map<id,account>aclit1=new map<id,account>();
        map<id,account>aclit3=new map<id,account>();
         boolean check=false;
        set<id>aclit2=new set<id>();
        list<account>aclist=new list<account>();
        map<id,Affiliated_Level__c>af2=new map<id,Affiliated_Level__c>();
        map<id,Affiliated_Level__c>af3=new map<id,Affiliated_Level__c>();
        map<id,id>acid=new map<id,id>();
        set<id>levid=new set<id>();
        map<id,decimal>ammount=new map<id,decimal>();
        for(account ac:oppList){
            system.debug('the level'+old.get(ac.id).Level_c__c);
             system.debug('the level'+old.get(ac.id).Level_c__c);
             system.debug('the level'+ac.This_Year_Total_level__c);
             system.debug('the level'+ac.Level_c__c);
            if(ac.Level_c__c!=null && old.get(ac.id).Level_c__c==null && ac.This_year_Total_Amount__c>=1000 && old.get(ac.id).This_year_Total_Amount__c<=1000){
                system.debug('the level'+old.get(ac.id).Level_c__c);
                aclit.add(ac.id);
                aclit1.put(ac.id,ac);
            }
            if(ac.Level_c__c!=old.get(ac.id).Level_c__c && ac.This_year_Total_Amount__c>old.get(ac.id).This_year_Total_Amount__c){
                system.debug('the level'+old.get(ac.id).Level_c__c);
                aclit.add(ac.id);
                aclit1.put(ac.id,ac);
            }
            if(ac.Level_c__c!=old.get(ac.id).Level_c__c && ac.This_year_Total_Amount__c<old.get(ac.id).This_year_Total_Amount__c){
               system.debug('the level'+old.get(ac.id).Level_c__c);
                aclit2.add(ac.id);
                check=true;
                aclit3.put(ac.id,ac);
                levid.add(ac.Level_c__c);
            }
            acid.put(ac.Level_c__c,ac.id);
            system.debug('the current level is'+ac.Level_c__c);
            //levid.add(ac.Level_c__c);
            ammount.put(ac.id,ac.This_year_Total_Amount__c);
            
        }
        system.debug('the current level is'+aclit);
        system.debug('the current level is'+aclit2);
        system.debug('the current level is'+levid);
        map<id,Affiliated_Level__c>afliated_list=new map<id,Affiliated_Level__c>();
        if(aclit2.size()>0){
            for(Affiliated_Level__c af:[select id,name,account__r.name,Level__r.name,account__c,Level__c,Lifetime_Giving__c,Status__c,Campaign__c from Affiliated_Level__c where account__c IN:aclit2 and Level__c IN:levid and Status__c='active']){
                afliated_list.put(af.id,af);
            }
            }
        system.debug('the ids are'+afliated_list);
        system.debug('the ids are'+levid);
        string This_year=string.valueOf(system.today().year());
        string name =This_year+' '+'Annual Campaign';
        
        list<id>dlist=new list<id>();
        
        if(aclit.size()>0){
            for(account ac:aclit1.values()){
           try{ 
               if(ac.This_Year_Total_level__c>=1000){
                        system.debug('the contact level');
                        Affiliated_Level__c al=new Affiliated_Level__c();
                        al.name=ac.name+' '+This_year+' '+ac.test__c;
                        al.account__c=ac.id;
                        al.Level__c=ac.Level_c__c;
                        al.Lifetime_Giving__c=ac.This_year_Total_Amount__c;
                        string ss=Label.Campain;
                       system.debug('the lable'+ss);
                        al.Campaign__c=ss;
                        al.Status__c='Active';
                        system.debug('the afliated one is'+al);
                        system.debug('the changed'+al.Name);
                        system.debug('the values'+af2.values());
                        af2.put(al.account__c,al);
                        system.debug('the duplicate val'+al.Name);
               }
                    }catch(DmlException e) {
                        System.debug('The following exception has occurred: ' + e.getMessage());
                    }
         
            }  }     
                  
        
            if(afliated_list.size()==0){
            if(aclit3.size()>0){
            for(account ac:aclit3.values()){
                if(ac.This_Year_Total_level__c>=1000 ){
                Affiliated_Level__c al=new Affiliated_Level__c();
                        al.name=ac.name+' '+This_year+' '+ac.test__c;
                        al.account__c=ac.id;
                        al.Level__c=ac.Level_c__c;
                        al.Lifetime_Giving__c=ac.This_year_Total_Amount__c;
                        string ss=Label.Campain;
                       system.debug('the lable'+ss);
                        al.Campaign__c=ss;
                      
                   // al.Campaign__c='701J00000032XQXIA2';
                        al.Status__c='Active';
                        system.debug('the afliated one is'+al);
                        system.debug('the changed'+al.Name);
                        
                        
                        af3.put(al.account__c,al);
                        system.debug('the values'+af2.values());
            }
            }
            }}
          
    
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
    //}
}