trigger UpdatepreviousCom on Affiliated_Level_Contact__c (after insert,after update) {
 if(trigger.isafter &&(trigger.isInsert)){
 UpdatePreviouslevel_contact.UpdatePreviouslevel_con(trigger.new,trigger.oldmap);
 }
    if(trigger.isafter &&(trigger.Isupdate)){
 UpdatePreviouslevel_contact.UpdatePreviouslevel_con(trigger.new,trigger.oldmap);
 }
}