trigger TriggerToNewContactRoleForSoftCredit on Opportunity (after insert,after update) {
    List<OpportunityContactRole> newContactRoleList = new List<OpportunityContactRole>();
    List<Opportunity> oldContactRoleList = new List<Opportunity>();
    Set<Id> CtctIds = new Set<Id>();
    map<Id,Id>OpOldOcR = new map<Id,Id>();
    map<Id,Id>OpNewOcR = new map<Id,Id>();
    map<id,id>oppSoft=new map<id,id>();
    
    if(Trigger.isInsert) {
        for(Opportunity opp : Trigger.new) {
            if(opp.Soft_Credit__c!=Opp.npsp__Primary_Contact__c && opp.Soft_Credit__c!=null){
                newContactRoleList.add(new OpportunityContactRole(ContactId=opp.Soft_Credit__c,OpportunityId=opp.Id,Role='Soft Credit',IsPrimary=false));
                System.debug('newContactRoleList'+newContactRoleList);
            }
        }
    }

    if (trigger.isUpdate){
        for(Opportunity opp : Trigger.new) {
            if(opp.Soft_Credit__c !=  Trigger.oldMap.get(opp.Id).Soft_Credit__c  && opp.Soft_Credit__c!=Opp.npsp__Primary_Contact__c) {
                //Creating new Contact Role
                if(opp.Soft_Credit__c!=null){
                    OpNewOcR.put(opp.Id,opp.Soft_Credit__c);
  
                }
                if(Trigger.oldMap.get(opp.Id).Soft_Credit__c!=null){
                    OpOldOcR.put(opp.Id,Trigger.oldMap.get(opp.Id).Soft_Credit__c);
                }
                
            }
            else if(opp.npsp__Primary_Contact__c !=  Trigger.oldMap.get(opp.Id).npsp__Primary_Contact__c && opp.Soft_Credit__c!= Trigger.oldMap.get(opp.Id).npsp__Primary_Contact__c && opp.npsp__Primary_Contact__c==opp.Soft_Credit__c && opp.Soft_Credit__c!=null&&opp.npsp__Primary_Contact__c!=null)
            {
                 OpOldOcR.put(opp.Id,Trigger.oldMap.get(opp.Id).Soft_Credit__c);
            }
            else if(opp.npsp__Primary_Contact__c !=  Trigger.oldMap.get(opp.Id).npsp__Primary_Contact__c && opp.npsp__Primary_Contact__c==null && Opp.Soft_Credit__c!=null &&  Trigger.oldMap.get(opp.Id).npsp__Primary_Contact__c==opp.Soft_Credit__c){
                 OpNewOcR.put(opp.Id,opp.Soft_Credit__c);
            }
             else if(opp.npsp__Primary_Contact__c !=  Trigger.oldMap.get(opp.Id).npsp__Primary_Contact__c && opp.npsp__Primary_Contact__c!=null && Opp.Soft_Credit__c!=null &&  Trigger.oldMap.get(opp.Id).npsp__Primary_Contact__c!=opp.Soft_Credit__c){
                 OpNewOcR.put(opp.Id,opp.Soft_Credit__c);
            }
            else if(opp.npsp__Primary_Contact__c !=  Trigger.oldMap.get(opp.Id).npsp__Primary_Contact__c && opp.npsp__Primary_Contact__c==null && Opp.Soft_Credit__c!=null &&  Trigger.oldMap.get(opp.Id).npsp__Primary_Contact__c!=opp.Soft_Credit__c){
                 OpNewOcR.put(opp.Id,opp.Soft_Credit__c);
            }
            else if(opp.npsp__Primary_Contact__c !=  Trigger.oldMap.get(opp.Id).npsp__Primary_Contact__c && Opp.Soft_Credit__c==Trigger.oldMap.get(opp.Id).Soft_Credit__c && opp.Soft_Credit__c!=null&&opp.npsp__Primary_Contact__c!=null )
            {
                OpNewOcR.put(opp.Id,opp.Soft_Credit__c);
            }
            else if(opp.Soft_Credit__c !=  Trigger.oldMap.get(opp.Id).Soft_Credit__c  && opp.Soft_Credit__c==Opp.npsp__Primary_Contact__c){
                if(Trigger.oldMap.get(opp.Id).Soft_Credit__c!=null){
                    OpOldOcR.put(opp.Id,Trigger.oldMap.get(opp.Id).Soft_Credit__c);
                }
            }
                 else if(opp.Soft_Credit__c ==  Trigger.oldMap.get(opp.Id).Soft_Credit__c  && opp.Soft_Credit__c==Opp.npsp__Primary_Contact__c){
                if(Trigger.oldMap.get(opp.Id).Soft_Credit__c!=null){
                    OpOldOcR.put(opp.Id,Trigger.oldMap.get(opp.Id).Soft_Credit__c);
                }
                      else if(opp.Soft_Credit__c ==  Trigger.oldMap.get(opp.Id).Soft_Credit__c  &&  (Opp.npsp__Primary_Contact__c==Trigger.oldMap.get(opp.Id).Soft_Credit__c)){
                if(Trigger.oldMap.get(opp.Id).Soft_Credit__c!=null){
                    OpOldOcR.put(opp.Id,Trigger.oldMap.get(opp.Id).Soft_Credit__c);
                }
            }
                     
                 } 
            for(Id oId:OpNewOcR.keyset())
            {
                
                newContactRoleList.add(new OpportunityContactRole(ContactId=OpNewOcR.get(oId),OpportunityId=oId,Role='Soft Credit',IsPrimary=false));
                system.debug('newContactRoleList'+newContactRoleList);
            }
            CtctIds.addALL(OpOldOcR.values());
            List<OpportunityContactRole> toDelete = new List<OpportunityContactRole>();
            list<OpportunityContactRole> oppConRoletoDelete = [SELECT Id, ContactId,OpportunityId FROM OpportunityContactRole WHERE OpportunityId IN : OpOldOcR.keySet() and Role='Soft Credit'];
            list<Opportunity>oppSoft=[select id,AccountId,Soft_Credit__c from Opportunity where id IN:oppSoft.keySet()];
            for(OpportunityContactRole ocr:oppConRoletoDelete){
                if(OpOldOcR.containsKey(ocr.OpportunityId) && OpOldOcR.get(ocr.OpportunityId)==ocr.ContactId){
                    toDelete.add(ocr);
                }
            }
            if(!toDelete.isEmpty()){ delete toDelete;}
            for(Opportunity opp1:oppSoft){
                opp1.Soft_Credit__c=null;
                system.debug('  opp1.Soft_Credit__c'+opp1.Soft_Credit__c);
            }
        }
    }
    if(!newContactRoleList.isEmpty())
    {
        insert newContactRoleList; 
      
        system.debug('newContactRoleList is'+newContactRoleList);
    }
}