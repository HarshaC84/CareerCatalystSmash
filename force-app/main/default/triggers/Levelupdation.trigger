//trigger used to update the level ON account and create the afliated Account In the Afliated Account Object
trigger Levelupdation on Account (after update,before update,before insert){
    
   
     if(trigger.isbefore && trigger.isinsert){
              
                      //Account_level1.AccountAmmount(trigger.new,trigger.oldMap);
                         Account_level1.fieldupdate(trigger.new,trigger.oldMap);
                //AccountTrigger_Level.AccountLevel(trigger.new,trigger.oldmap);     
    }
    if(trigger.isbefore && trigger.isupdate){
              
                      Account_level1.AccountAmmount(trigger.new,trigger.oldMap);
                        // Account_level1.fieldupdate(trigger.new,trigger.oldMap);
                //AccountTrigger_Level.AccountLevel(trigger.new,trigger.oldmap);     
    }
    
    if(trigger.isafter){
        Account_level1.Decativateafliate(trigger.new,trigger.oldMap);
        AccountTrigger_Level.AccountLevel2(trigger.new,trigger.oldmap);
         
    }   
}