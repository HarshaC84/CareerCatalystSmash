trigger AfliatedContact on Contact (after Update,before update) {
    
    if(trigger.isafter){
             
        Contact_level.Decativateafliatecon(trigger.new,trigger.oldmap);
        Contact_level.ContactAFLevel(trigger.new,trigger.oldMap);
       
     }
    if(trigger.isbefore && (trigger.isUpdate)){
             
              Contact_level.contactlevel(trigger.new,trigger.oldMap);
               
    }

}