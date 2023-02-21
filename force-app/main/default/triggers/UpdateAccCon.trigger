trigger UpdateAccCon on Opportunity (before insert,before update,after insert,after update,after delete){
    
    if(trigger.isafter){
      
        
        List<Opportunity> newList = trigger.isdelete?trigger.old:trigger.new;
        UpdateAccConTriggerHandler.updateContacts(newList,trigger.oldMap);
        UpdateAccConTriggerHandler.updateAccount(newList,trigger.oldMap);
        
        // UpdateAccTriggerHandler.updateAccount(newList,trigger.oldMap);
    }
    if(trigger.isbefore && (trigger.isInsert || trigger.isUpdate)){
     
        
      //  UpdateAccConTriggerHandler.updateCampain(trigger.new);
        defaultprimary1.AccountLevel(trigger.new,trigger.oldmap);
    }
    //if(trigger.isbefore &&(trigger.isUpdate)){
    // UpdateAfliated_opp.oppupdate_level(trigger.new,trigger.oldmap);
    //}
   if(trigger.isafter &&(trigger.isInsert)){
      
        
        UpdateAfliated_opp.AmountOnAccount(trigger.new,trigger.oldmap); }
    //AmountOnAccountUpdate
    if(trigger.isafter &&(trigger.Isupdate)){
      
        
        UpdateAfliated_opp.AmountOnAccountUpdate(trigger.new,trigger.oldmap); }
}