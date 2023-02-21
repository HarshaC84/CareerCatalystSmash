trigger UpdateRatingLead on Lead (before insert,before update) 
{
   List<Lead>contest=new list<Lead>();
    map<String, Ability__c> mcs = Ability__c.getAll();
    map<string,Interest__c>inc=Interest__c.getAll();
     map<string,Readiness__c>red=Readiness__c.getAll();
    if(trigger.isInsert)
    {
       for (Lead fc: trigger.new) {
        if(mcs.containsKey(fc.Ability__c) && fc.Ability__c!=null)
         //  fc.Text4__c=mcs.get(fc.Rating__c).capability__c;
        {
           fc.capability__c=mcs.get(fc.Ability__c).capability__c;
             fc.Known_Assets__c=mcs.get(fc.Ability__c).Known_Asserts__c;
            contest.add(fc);
          
            }
           if(inc.containsKey(fc.Interest_to_give__c) && fc.Interest_to_give__c!=null)
           {
               fc.Interest_to_give_Description__c=inc.get(fc.Interest_to_give__c).Description1__c;
               fc.Interest_to_give_Description1__c=inc.get(fc.Interest_to_give__c).Description2__c;
                contest.add(fc);
               
           }
            if(red.containsKey(fc.Readiness__c) && fc.Readiness__c!=null)
           {
               fc.Readiness_Description__c=red.get(fc.Readiness__c).Description__c;
               contest.add(fc);
               
           }
    }
    }
  else if(trigger.Isupdate)
    {
        for(Lead con:trigger.new){
            if(mcs.containsKey(con.Ability__c) && con.Ability__c!=null && con.Ability__c!=Trigger.oldMap.get(con.Id).Ability__c)
            {
            con.capability__c=mcs.get(con.Ability__c).capability__c;
             con.Known_Assets__c=mcs.get(con.Ability__c).Known_Asserts__c;
            contest.add(con);  
        }
           else if(con.Ability__c==null)
           {
                con.capability__c='';
                con.Known_Assets__c='';
                contest.add(con);
              }
            
            if(inc.containsKey(con.Interest_to_give__c) && con.Interest_to_give__c!=null && con.Interest_to_give__c!=Trigger.oldMap.get(con.Id).Interest_to_give__c)
            {
            con.Interest_to_give_Description__c=inc.get(con.Interest_to_give__c).Description1__c;
            con.Interest_to_give_Description1__c=inc.get(con.Interest_to_give__c).Description2__c;
            contest.add(con);  
                        }
             else if(con.Interest_to_give__c==null)
           {
              con.Interest_to_give_Description__c='';
               con.Interest_to_give_Description1__c='';
                contest.add(con);  
              }
             if(red.containsKey(con.Readiness__c) && con.Readiness__c!=null && con.Readiness__c!=Trigger.oldMap.get(con.Id).Readiness__c)
            {
            con.Readiness_Description__c=red.get(con.Readiness__c).Description__c;
            contest.add(con);  
                        }
             else if(con.Readiness__c==null)
           {
              con.Readiness_Description__c='';
              contest.add(con);      
           }
           }
    }
  }