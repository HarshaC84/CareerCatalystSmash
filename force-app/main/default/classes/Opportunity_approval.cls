public class Opportunity_approval{
    public List<OpportunityWrapper> OpportunityWrapperList {get; set;}
    public List<ProcessInstance> itemsToApprove {get; set;}
    public Set<Id> selectedOpportunityIds = new Set<Id>();
    public opportunity opp {get; set;}
    public String recordId {get; set;}
    public String toAddress {get; set;}
    public String ccAddress {get; set;}
    public String bccAddress {get; set;}
    public String subject {get; set;}
    public String emailBody {get; set;}
    public Boolean allSelect {get; set;}
    
    
    public Opportunity_approval(ApexPages.StandardController controller) {
        
        OpportunityWrapperList = new List<OpportunityWrapper>();
        
        Set<Id> opportunityIds = new Set<Id>();
        
        for(ProcessInstance approvalRequest : [SELECT Id, TargetObjectId,CreatedDate,Status FROM ProcessInstance WHERE Status='Pending']) {
            if(approvalRequest.TargetObjectId.getSobjectType() == Schema.opportunity.SObjectType) {
                opportunityIds.add(approvalRequest.TargetObjectId);
            }
        }
        
        for(opportunity opp : [SELECT Id,Name,Amount,StageName,General_Ledger_Description__c,Type_of_Gift__c,AccountId,npsp__Primary_Contact__c,
                               Soft_Credit__c,GL_Class_Description__c,CloseDate,CreatedById FROM opportunity 
                               WHERE Id IN: opportunityIds ORDER BY CreatedDate DESC])
            OpportunityWrapperList.add(new OpportunityWrapper(opp));
    }
    
    public Set<Id> selectedOpportunities() {
        
        for(OpportunityWrapper opportunitywrapper: OpportunityWrapperList) {
            if(OpportunityWrapper.selected == true)
                selectedOpportunityIds.add(OpportunityWrapper.opp.Id);
        }
        
        if(selectedOpportunityIds.size()>0)
            return selectedOpportunityIds;
        else
            return null;   
    }
    public void openModal() {
        String userName = UserInfo.getUserName();
        User activeUser = [Select Email From User where Username = : userName limit 1];
        String userEmail = activeUser.Email;
        opp = [SELECT Id, Name, OwnerId, Owner.Name, Owner.Email FROM opportunity WHERE Id =: recordId];
        toAddress = opp.Owner.Email;
        ccAddress=userEmail;
        subject = '';
        
    }
    
    public void sendEmail() {
        system.debug('===recordId=='+opp.Id); 
        List<String> toAddresses = toAddress.split(';');
        List<String> ccAddresses = new List<String>();
        List<String> bccAddresses = new List<String>();   
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setWhatId(opp.Id);
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
        
        String body = emailBody+'<br/> Please refer to this Opportunity link:'+System.URL.getSalesforceBaseUrl().toExternalForm()+'/'+opp.Id;
        email.setHtmlBody(body);
        
        Messaging.SendEmailResult [] result = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
    }
    
    
    public void addToGrid() {
        Set<Id> targetIds = selectedOpportunities();
        system.debug(targetIds);
        itemsToApprove = [SELECT Id, TargetObjectId, Status,CreatedDate, LastModifiedDate FROM ProcessInstance 
                          WHERE Status='Pending' AND TargetObjectId =: targetIds ORDER BY LastModifiedDate DESC];
    }
    
    public PageReference approveOpportunity() {
        Set<Id> targetIds = selectedOpportunities();
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
        
        PageReference pageRef = new PageReference('/lightning/o/Opportunity/list');            
        pageRef.setRedirect(true);
        return pageRef;
    }
    
    public PageReference DeleteRecord() 
    {
        Set<Id> targetIds = selectedOpportunities();
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
        
        PageReference pageRef = new PageReference('/apex/Opportunity_approvalVf');            
        pageRef.setRedirect(true);
        return pageRef;
    }
    
    public void selectAll()
    {
        if(allSelect) 
        {
            for(OpportunityWrapper opportunitywrapper : OpportunityWrapperList) 
            {
                opportunitywrapper.selected = true;
            }
        } else 
        {
            for(OpportunityWrapper opportunitywrapper : OpportunityWrapperList) 
            {
                opportunitywrapper.selected = false;
            }
        }   
    } 
    public pageReference returntolist()
    {
        Set<Id> targetIds = selectedOpportunities();
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
        
        PageReference pageRef = new PageReference('/lightning/o/Opportunity/list');            
        pageRef.setRedirect(true);
        return pageRef;
    }
    
    public class OpportunityWrapper {
        public opportunity opp {get; set;}
        public Boolean selected {get; set;}
        public OpportunityWrapper(opportunity opp)
        {
            this.opp = opp;
            selected = false;
        }
    }
    
    
}