public class Contact_approval {
    public List<ContactWrapper> contactWrapperList {get; set;}
    public List<ProcessInstance> itemsToApprove {get; set;}
    public Set<Id> selectedContactIds = new Set<Id>();
    public contact con {get; set;}
     public String recordId {get; set;}
    public String toAddress {get; set;}
    public String ccAddress {get; set;}
    public String bccAddress {get; set;}
    public String subject {get; set;}
    public String emailBody {get; set;}
    public Boolean allSelect {get; set;}
    
    public Contact_approval(ApexPages.StandardController controller) {
        contactWrapperList = new List<ContactWrapper>();
        
        Set<Id> contactIds = new Set<Id>();
        
        for(ProcessInstance approvalRequest : [SELECT Id, TargetObjectId,CreatedDate, Status FROM ProcessInstance WHERE Status='Pending']) {
            if(approvalRequest.TargetObjectId.getSobjectType() == Schema.contact.SObjectType) {
                contactIds.add(approvalRequest.TargetObjectId);
            }
        }
        
        for(contact con : [SELECT Id, Name,Opp_Availability_con__c,Email,CreatedById,Phone,Type__c,Donor__c,OwnerId, Account.Name FROM contact WHERE Id IN: contactIds ORDER BY CreatedDate DESC])
            contactWrapperList.add(new ContactWrapper(con));
    }
    
    public Set<Id> selectedContacts() {
        for(ContactWrapper contactWrapper: contactWrapperList) {
            if(ContactWrapper.selected == true)
                selectedContactIds.add(contactWrapper.con.Id);
        }
        
        if(selectedContactIds.size()>0)
            return selectedContactIds;
        else
            return null;   
    }
    public void openModal() {
        String userName = UserInfo.getUserName();
       User activeUser = [Select Email From User where Username = : userName limit 1];
      String userEmail = activeUser.Email;
       // string sign=activeUser.Signature;
		con = [SELECT Id, Name, OwnerId, Owner.Name, Owner.Email FROM contact WHERE Id =: recordId];
        toAddress = con.Owner.Email;
        ccAddress=userEmail;
        system.debug('Email '+toAddress);
       	subject = '';
	}
    
    public void sendEmail() {
        List<String> toAddresses = toAddress.split(';');
        List<String> ccAddresses = new List<String>();
        List<String> bccAddresses = new List<String>();   
        
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
      //  email.setWhatId(recordId);
        email.setSaveAsActivity(true);
        email.setSubject(subject);
        email.setToAddresses(toAddresses);
        if(ccAddress != null && ccAddress.trim() != ''){
            ccAddresses = ccAddress.split(';',0);
            email.setCcAddresses(ccAddresses);
        }
        if(bccAddress != null && bccAddress.trim() != ''){
            bccAddresses = bccAddress.split(';',0);
            email.setBccAddresses(bccAddresses);
        }
            
        String body = emailBody+'<br/> Please refer to this Contact link:'+System.URL.getSalesforceBaseUrl().toExternalForm()+'/'+con.Id;
        email.setHtmlBody(body);
        
        Messaging.SendEmailResult [] result = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
    }
    
    public void addToGrid() {
        Set<Id> targetIds = selectedContacts();
        system.debug(targetIds);
        itemsToApprove = [SELECT Id, TargetObjectId, Status,CreatedDate, LastModifiedDate FROM ProcessInstance WHERE Status='Pending' AND TargetObjectId =: targetIds ORDER BY LastModifiedDate DESC];
    }
    
    public PageReference approveContact() {
        Set<Id> targetIds = selectedContacts();
        List<Approval.ProcessWorkitemRequest> requests = new List<Approval.ProcessWorkitemRequest>();
        List<ProcessInstanceWorkitem> workItems = [Select Id from ProcessInstanceWorkitem where ProcessInstance.TargetObjectId =: targetIds];
        system.debug(workItems);
        for(ProcessInstanceWorkitem workItem : workItems) {
            Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
            req.setAction('Approve');
            req.setWorkitemId(workItem.Id);
            requests.add(req); 
            //	PageReference pageRef = new PageReference('/'+); 
        }
        
        List<Approval.ProcessResult> result = Approval.process(requests);
        
        PageReference pageRef = new PageReference('/lightning/o/Contact/list');            
        pageRef.setRedirect(true);
        return pageRef;
    }
    
    public PageReference DeleteRecord() 
    {
        Set<Id> targetIds = selectedContacts();
        List<Approval.ProcessWorkitemRequest> requests = new List<Approval.ProcessWorkitemRequest>();
        List<ProcessInstanceWorkitem> workItems = [Select Id from ProcessInstanceWorkitem where ProcessInstance.TargetObjectId =: targetIds];
        system.debug(workItems);
        for(ProcessInstanceWorkitem workItem : workItems) {
            Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
            req.setAction('Reject');
            req.setWorkitemId(workItem.Id);
            requests.add(req);   
        }
        
        List<Approval.ProcessResult> result = Approval.process(requests);
        
        List<contact> accountsToDelete = [SELECT Id, Name, email, Phone FROM contact WHERE Id IN: targetIds];
        delete accountsToDelete;
        //(/apex/contact_approvalvf)
        PageReference pageRef = new PageReference('/apex/Contact_approvalvf');            
        pageRef.setRedirect(true);
        return pageRef;
    }
    
    public void selectAll()
    {
        if(allSelect) 
        {
            for(ContactWrapper contactwrapper : contactWrapperList) {
                contactwrapper.selected = true;
            }
        } else 
        {
            for(ContactWrapper contactwrapper : contactWrapperList) {
                contactwrapper.selected = false;
            }
        }   
    }
     public pageReference returntolist()
    {
      Set<Id> targetIds = selectedContacts();
        List<Approval.ProcessWorkitemRequest> requests = new List<Approval.ProcessWorkitemRequest>();
        List<ProcessInstanceWorkitem> workItems = [Select Id from ProcessInstanceWorkitem where ProcessInstance.TargetObjectId =: targetIds];
        system.debug(workItems);
        for(ProcessInstanceWorkitem workItem : workItems) {
            Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
            req.setAction('Reject');
            req.setWorkitemId(workItem.Id);
            requests.add(req);   
        }
        
        List<Approval.ProcessResult> result = Approval.process(requests);
        
        List<opportunity> accountsToDelete = [SELECT Id, Name,CloseDate,CreatedById FROM opportunity WHERE Id IN: targetIds];
        delete accountsToDelete;
        
        PageReference pageRef = new PageReference('/lightning/o/Contact/list');            
        pageRef.setRedirect(true);
        return pageRef;
    }
    
    public PageReference clearrecords()
    {
         PageReference pageRef = new PageReference('/apex/Contact_approvalvf');            
        pageRef.setRedirect(true);
        return pageRef;
        
    }

    
    public class ContactWrapper {
        public contact con {get; set;}
        public Boolean selected {get; set;}
        public ContactWrapper(contact con)
        {
            this.con = con;
            selected = false;
        }
    }
}