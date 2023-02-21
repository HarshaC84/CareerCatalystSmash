public class Account_Approval {
    public List<AccountWrapper> accountWrapperList {get; set;}
    public List<ProcessInstance> itemsToApprove {get; set;}
    public Set<Id> selectedAccountIds = new Set<Id>();
    public Account acc {get; set;}
    public String recordId {get; set;}
    public String toAddress {get; set;}
    public String ccAddress {get; set;}
    public String bccAddress {get; set;}
    public String subject {get; set;}
    public String emailBody {get; set;}
    public Boolean allSelect {get; set;}   
    /*public transient string toAddress {
        get {
            return acc.Owner.Email;
        }
    }*/
    
    public Account_Approval(ApexPages.StandardController controller) {
        accountWrapperList = new List<accountwrapper>();        
        Set<Id> accountIds = new Set<Id>();
        
        for(ProcessInstance approvalRequest : [SELECT Id, TargetObjectId, Status FROM ProcessInstance WHERE Status='Pending']) {
            if(approvalRequest.TargetObjectId.getSobjectType() == Schema.Account.SObjectType) {
                accountIds.add(approvalRequest.TargetObjectId);
            }
        }
        
        for(Account acc : [SELECT Id, Name,OwnerId,Oppavilability__c,Owner.Name,Active__c,Owner.Email,npe01__One2OneContact__c,Donor_ID__c,Phone,Email__c FROM Account WHERE Id IN: accountIds ORDER BY CreatedDate DESC]) {
            accountWrapperList.add(new AccountWrapper(acc));
        }
    }
    
    public Set<Id> selectedAccounts() {        
        for(AccountWrapper accountwrapper: accountWrapperList) {
            if(accountwrapper.selected == true)
                selectedAccountIds.add(accountwrapper.acc.Id);
        }
        
        if(selectedAccountIds.size()>0)
            return selectedAccountIds;
        else
            return null;   
    }
    
    public void openModal() {
        String userName = UserInfo.getUserName();
        User activeUser = [Select Email From User where Username = : userName limit 1];
        String userEmail = activeUser.Email;
        acc = [SELECT Id, Name, OwnerId, Owner.Name, Owner.Email FROM Account WHERE Id =: recordId];
        toAddress = acc.Owner.Email;
        ccAddress=userEmail;
        system.debug('Email '+toAddress);
        subject = '';
	}
    
    public void sendEmail() {
        List<String> toAddresses = toAddress.split(';');
        List<String> ccAddresses = new List<String>();
        List<String> bccAddresses = new List<String>();   
        
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setWhatId(acc.id);
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
        String body = emailBody+'<br/>Please refer to this Account link:'+System.URL.getSalesforceBaseUrl().toExternalForm()+'/'+acc.Id;
        email.setHtmlBody(body);
        
        Messaging.SendEmailResult [] result = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
    }
    
    public void addToGrid() {
        Set<Id> targetIds = selectedAccounts();
        system.debug(targetIds);
        itemsToApprove = [SELECT Id, TargetObjectId, Status, LastModifiedDate FROM ProcessInstance WHERE Status='Pending' AND TargetObjectId =: targetIds ORDER BY LastModifiedDate DESC];
    }
    
    public PageReference approveAccount() {
        Set<Id> targetIds = selectedAccounts();
        List<Approval.ProcessWorkitemRequest> requests = new List<Approval.ProcessWorkitemRequest>();
        List<ProcessInstanceWorkitem> workItems = [Select Id from ProcessInstanceWorkitem where ProcessInstance.TargetObjectId =: targetIds];
        system.debug(workItems);
        for(ProcessInstanceWorkitem workItem : workItems) {
            Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
            req.setAction('Approve');
            req.setWorkitemId(workItem.Id);
            requests.add(req);   
        }
        
        List<Approval.ProcessResult> result = Approval.process(requests);
        
        PageReference pageRef = new PageReference('/lightning/o/Account/list');            
        pageRef.setRedirect(true);
        return pageRef;
    }
    
    public PageReference DeleteRecord() 
    {
        Set<Id> targetIds = selectedAccounts();
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
        
        List<Account> accountsToDelete = [SELECT Id, Name, AccountNumber, Phone FROM Account WHERE Id IN: targetIds];
        delete accountsToDelete;
        
        PageReference pageRef = new PageReference('/apex/Account_approvalVf');            
        pageRef.setRedirect(true);
        return pageRef;
    }
    
    public void selectAll()
    {
        if(allSelect) 
        {
            for(AccountWrapper accountwrapper : accountWrapperList) {
                accountwrapper.selected = true;
            }
        } else 
        {
            for(AccountWrapper accountwrapper : accountWrapperList) {
                accountwrapper.selected = false;
            }
        }   
    }
    public pageReference returntolist()
    {
      Set<Id> targetIds = selectedAccounts();
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
        
        PageReference pageRef = new PageReference('/lightning/o/Account/list');            
        pageRef.setRedirect(true);
        return pageRef;
    }
    
    public PageReference clearrecords()
    {
        PageReference pageRef = new PageReference('/apex/Account_approvalVf');            
        pageRef.setRedirect(true);
        return pageRef;
        
    }
  
    public class AccountWrapper {
        public Account acc {get; set;}
        public Boolean selected {get; set;}
        public AccountWrapper(Account acc)
        {
            this.acc = acc;
            selected = false;
        }
    }
}