trigger UpdateAccCon2 on Opportunity (after insert,after update){
    set<Id> accIds = new set<Id>();
    list<Id> conIds= new list<Id>();
    list<Account> accounts = new list<account>();
    list<account> Accounts_DateUpdate = new list<account>();
    list<contact> contacts=new list<contact>();
    list<contact> contacts_DateUpdate=new list<contact>();
    list<account> Accounts_AmountUpdate = new list<account>();
    list<contact> contacts_AmountUpdate=new list<contact>();
    for(opportunity o:trigger.new){
        accIds.add(o.accountId);
        conIds.add(o.contactId);
    }
    for(account a:[select Id, Active__c from account where Id IN :accIds]){
        for(opportunity opp:trigger.new){
            if(opp.stagename=='closed won' & opp.RecordType.Name=='Donation'){
                a.Active__c=true;
                accounts.add(a);
            }
        }
    }
    for(contact c:[select Id, Donor__c from contact where Id IN :conIds]){
        for(opportunity opp:trigger.new){
            if(opp.stagename=='closed won' & opp.RecordType.Name=='Donation'){
                c.Donor__c=true;
                contacts.add(c);
            }
        }
    }
    
    Map<Id,Account> accountmap = new Map<Id,Account>([Select id, Name, (Select id, closedate, amount,stageName,RecordType.Name From Opportunities WHERE RecordType.Name='Donation' ORDER BY amount DESC LIMIT 1) from Account where Id IN : accIds]);
    for (Account ThisAccount : AccountMap.values()) {
        Account Acc = AccountMap.get(ThisAccount.id);
        for (Opportunity o : Acc.Opportunities) {
            if(o.stagename=='closed won' & o.RecordType.Name=='Donation'){
            Acc.Largest_Gift_Date__c = o.closedate;
        }
      }
        if(Acc.Opportunities.size()==0)
        {
            Acc.Largest_Gift_Date__c=null;
        }
        Accounts_DateUpdate.add(Acc);
    }
    Map<Id,contact> contactmap = new Map<Id,contact>([Select id,lastName, (Select id, closedate, amount,stageName,RecordType.Name From Opportunities WHERE RecordType.Name='Donation' ORDER BY amount DESC LIMIT 1) from contact where Id IN : conIds]);
    for (contact Thiscontact : contactmap.values()) {
        contact con = contactmap.get(Thiscontact.id);
        for (Opportunity o : con.Opportunities) {
         if(o.stagename=='closed won' & o.RecordType.Name=='Donation'){
            con.Largest_Gift_Date__c = o.closedate;
        }
        }
        if(con.Opportunities.size()==0)
        {
            con.Largest_Gift_Date__c=null;
        }
        contacts_DateUpdate.add(con);
    }
    try{
        if(accounts.size()>0)
            update accounts;
        if(Accounts_DateUpdate.size()>0)
            update Accounts_DateUpdate;
        // Contacts update
        if(contacts.size()>0)
            update contacts;
        if(contacts_DateUpdate.size()>0)
            update contacts_DateUpdate;
    }catch(Exception e){
        system.debug('Exception on UpdateAccCon '+e.getMessage()+e.getLineNumber());
    }
    Map<Id,Account> accountmap1 = new Map<Id,Account>([Select id, Name, (Select id, closedate, amount,CreatedDate,stageName,RecordType.Name From Opportunities WHERE RecordType.Name='Donation' ORDER BY CreatedDate ASC LIMIT 1) from Account where Id IN : accIds]);
    for (Account ThisAccount : accountmap1.values()) {
        Account Acc = accountmap1.get(ThisAccount.id);
        for (Opportunity o : Acc.Opportunities) {
        if(o.stagename=='closed won' & o.RecordType.Name=='Donation'){
            Acc.First_Gift_Amount__c = o.amount;
        }
        }
        if(Acc.Opportunities.size()==0)
        {
            Acc.First_Gift_Amount__c=null;
        }
        Accounts_AmountUpdate.add(Acc);
    }
    Map<Id,contact> contactmap1 = new Map<Id,contact>([Select id,lastName, (Select id, closedate, amount,CreatedDate,stageName,RecordType.Name From Opportunities WHERE RecordType.Name='Donation' ORDER BY CreatedDate ASC LIMIT 1) from contact where Id IN : conIds]);
    for (contact Thiscontact : contactmap1.values()) {
        contact con = contactmap1.get(Thiscontact.id);
        for (Opportunity o : con.Opportunities) {
        if(o.stagename=='closed won' & o.RecordType.Name=='Donation'){
            con.First_Gift_Amount__c = o.amount;
        }
        }
        if(con.Opportunities.size()==0)
        {
            con.First_Gift_Amount__c=null;
        }
        contacts_AmountUpdate.add(con);
    }
    try{
        if(accounts.size()>0)
            update accounts;
        if(Accounts_AmountUpdate.size()>0)
            update Accounts_AmountUpdate;
        // Contacts update
        if(contacts.size()>0)
            update contacts;
        if(contacts_AmountUpdate.size()>0)
            update contacts_AmountUpdate;
    }catch(Exception e){
        system.debug('Exception on UpdateAccCon '+e.getMessage()+e.getLineNumber());
    }
}