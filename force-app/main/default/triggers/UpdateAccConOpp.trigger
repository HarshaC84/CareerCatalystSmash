trigger UpdateAccConOpp on DS360oi__DonorSearch_del_del__c(after insert,after update){
    
    Set<Id> accountIds = new Set<Id>();
    set<id> contactIds= new set<id>();
    set<Id> leadIds=new set<Id>();
    for(DS360oi__DonorSearch_del_del__c opp : Trigger.new)
    {
        accountIds.add(opp.DS360oi__Account__c);
        contactIds.add(opp.DS360oi__ID__c);
        leadIds.add(opp.DS360oi__Lead_ID__c);
    }
    
    //Update Accounts
    Map<ID, Account> mapAccounts = new Map<ID, Account>([SELECT Id,DS_Rating__c,LastModifiedDate FROM Account where Id IN :accountIds ORDER BY LastModifiedDate DESC LIMIT 1]);
    List<Account> lstAccToUpdate = new List<Account>();
    For(DS360oi__DonorSearch_del_del__c opp : Trigger.new)
    {
        if(opp.DS360oi__Account__c!=null){
        Account acc = mapAccounts.get(opp.DS360oi__Account__c);
        acc.DS_Rating__c = opp.DS360oi__DS_Rating__c;
        lstAccToUpdate.add(acc);
            system.debug('Account result'+ acc.DS_Rating__c );
    }
    }
    update lstAccToUpdate;
    Map<ID, Contact> mapContacts = new Map<ID, Contact>([SELECT Id,DS_Rating__c,LastModifiedDate FROM Contact where Id IN :contactIds ORDER BY LastModifiedDate DESC LIMIT 1]);
    List<Contact> lstConToUpdate = new List<Contact>();
    For(DS360oi__DonorSearch_del_del__c opp : Trigger.new)
    { 
        if(opp.DS360oi__ID__c!=null){
        Contact con= mapContacts.get(opp.DS360oi__ID__c);
        con.DS_Rating__c = opp.DS360oi__DS_Rating__c;
        lstConToUpdate.add(con);
             system.debug('Account result'+ con.DS_Rating__c );
    }
    }
    update lstConToUpdate;
    Map<ID, Lead> mapleads = new Map<ID, Lead>([SELECT Id,DS_Rating__c,LastModifiedDate FROM Lead where Id IN :leadIds ORDER BY LastModifiedDate DESC LIMIT 1]);
    List<Lead> lstleadToUpdate = new List<Lead>();
    For(DS360oi__DonorSearch_del_del__c opp : Trigger.new)
    {
        if(opp.DS360oi__Lead_ID__c!=null){
        Lead l= mapleads.get(opp.DS360oi__Lead_ID__c);
        l.DS_Rating__c = opp.DS360oi__DS_Rating__c;
        lstleadToUpdate.add(l);
             system.debug('Account result'+ l.DS_Rating__c );
    }
    }
    update lstleadToUpdate;
   }