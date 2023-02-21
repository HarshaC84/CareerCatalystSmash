trigger Updateprevious on Affiliated_Level__c (after insert,after update) {
    if(trigger.isafter &&(trigger.isInsert)){
        System.debug('.........insert');
 UpdatepreviousLevel_account.UpdatePreviouslevel_ACC(trigger.new,trigger.oldmap);
 }
    if(trigger.isafter &&(trigger.Isupdate)){
        system.debug('..........update');
 UpdatepreviousLevel_account.UpdatePreviouslevel_ACC(trigger.new,trigger.oldmap);
 }
    
}