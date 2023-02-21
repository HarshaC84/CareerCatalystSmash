@istest
public class Contact_approval_Test {
   @testSetup
    static void setupTestData(){
        test.startTest();
        Contact con = new Contact(LastName = 'Name721', Email = 'xyz@gmail.com', Phone = '456786',Opp_Availability__c=false, dupcheck__dc3DisableDuplicateCheck__c = false);
        Insert con; 
        //   ItemsToApproveController.AccountWrapper accwrap=new ItemsToApproveController.AccountWrapper(accountWrapperList);
        //   accwrap.selected=true;
        //ProcessInstance processinstance_Obj = new ProcessInstance();
        //Insert processinstance_Obj; 
        ApexPages.currentPage().getParameters().put('Id',con.id);	
        ApexPages.StandardController sc =new ApexPages.StandardController(con);
        Contact_approval ec=new Contact_approval (sc);
         ec.toAddress=con.Owner.Email;
         ec.ccAddress='test2@gmail.com';
        ec.bccAddress= 'test3@gmail.com';
        ec.emailBody='test1111111';
        ec.subject='test22222';
          
        //ec.openModal();
            
           test.stopTest();
    }
    static testMethod void test_selectedContacts_UseCase1(){
        List<Contact> con  =  [SELECT Id,Name,Email,Phone,dupcheck__dc3DisableDuplicateCheck__c from Contact];
        System.assertEquals(true,con.size()>0);
        List<ProcessInstance> pr  =  [SELECT Id,ProcessDefinitionId,TargetObjectId,Status,CompletedDate,LastActorId,ElapsedTimeInDays,ElapsedTimeInHours,ElapsedTimeInMinutes,SubmittedById,IsDeleted,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp from ProcessInstance];
        Contact_approval obj01 = new Contact_approval(new ApexPages.StandardController(con[0]));
        obj01.contactWrapperList = new List<Contact_approval.ContactWrapper>();
        obj01.itemsToApprove = pr;
        obj01.allSelect = false;
        obj01.selectedContactIds = new Set<Id>();
        obj01.selectedContacts();
          
        
    }
    
    static testMethod void test_selectedContacts_UseCase2(){
        List<Contact> con  =[SELECT Id,LastName,Email,Phone,dupcheck__dc3DisableDuplicateCheck__c from Contact];
        System.assertEquals(true,con.size()>0);
        List<ProcessInstance> pr  =  [SELECT Id,ProcessDefinitionId,TargetObjectId,Status,CompletedDate,LastActorId,ElapsedTimeInDays,ElapsedTimeInHours,ElapsedTimeInMinutes,SubmittedById,IsDeleted,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp from ProcessInstance];
        Contact_approval obj01 = new Contact_approval(new ApexPages.StandardController(con[0]));
        obj01.contactWrapperList = new List<Contact_approval.ContactWrapper>();
        obj01.itemsToApprove = pr;
        obj01.allSelect = false;
        obj01.selectedContactIds = new set<Id>();
        Contact c1=new Contact();
        c1.LastName='Name354';
        Insert c1;
        //processinstance pe=new processinstance();
        //pe.Status='Approved';
        //pe.TargetObjectId= a1.Id;   
        //Insert pe;
        if([select count() from ProcessInstance where targetobjectid=:c1.id] < 1)
        {       
            Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
            req.setComments('Approved');
            req.setNextApproverIds(new Id[] {UserInfo.getUserId()});
            req.setObjectId(c1.Id);
            
            //Submit the approval request
            Approval.ProcessResult result = Approval.process(req);
            
        }
        obj01.selectedContacts();
    }
    static testMethod void test_addToGrid_UseCase1(){
        List<Contact> con  =  [SELECT Id,LastName,Email,Phone,dupcheck__dc3DisableDuplicateCheck__c from Contact];
        System.assertEquals(true,con.size()>0);
        List<ProcessInstance> pr  =  [SELECT Id,ProcessDefinitionId,TargetObjectId,Status,CompletedDate,LastActorId,ElapsedTimeInDays,ElapsedTimeInHours,ElapsedTimeInMinutes,SubmittedById,IsDeleted,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp from ProcessInstance];
        Contact_approval obj01 = new Contact_approval(new ApexPages.StandardController(con[0]));
        obj01.contactWrapperList = new List<Contact_approval.ContactWrapper>();
        obj01.itemsToApprove = pr;
        obj01.allSelect = false;
        obj01.selectedContactIds = new Set<Id>();
        obj01.addToGrid();
        
    }
    static testMethod void test_approveContact_UseCase1(){
        List<Contact> con  =  [SELECT Id,LastName,Email,Phone,dupcheck__dc3DisableDuplicateCheck__c from Contact];
        System.assertEquals(true,con.size()>0);
        List<ProcessInstance> pr  =  [SELECT Id,ProcessDefinitionId,TargetObjectId,Status,CompletedDate,LastActorId,ElapsedTimeInDays,ElapsedTimeInHours,ElapsedTimeInMinutes,SubmittedById,IsDeleted,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp from ProcessInstance];
        Contact_approval obj01 = new Contact_approval(new ApexPages.StandardController(con[0]));
        obj01.contactWrapperList = new List<Contact_approval.ContactWrapper>();
        obj01.itemsToApprove = pr;
        obj01.allSelect = false;
        obj01.selectedContactIds = new Set<Id>();
        obj01.approveContact();
        
    }
    static testMethod void test_DeleteRecord_UseCase1(){
        List<Contact> contact_Obj  =  [SELECT Id,LastName,Email,phone,dupcheck__dc3DisableDuplicateCheck__c from Contact];
        System.assertEquals(true,contact_Obj.size()>0);
        List<ProcessInstance> processinstance_Obj  =  [SELECT Id,ProcessDefinitionId,TargetObjectId,Status,CompletedDate,LastActorId,ElapsedTimeInDays,ElapsedTimeInHours,ElapsedTimeInMinutes,SubmittedById,IsDeleted,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp from ProcessInstance];
        Contact_approval obj01 = new Contact_approval(new ApexPages.StandardController(contact_Obj[0]));
        obj01.contactWrapperList = new List<Contact_approval.ContactWrapper>();
        obj01.itemsToApprove = processinstance_Obj;
        obj01.allSelect = false;
        obj01.selectedContactIds = new Set<Id>();
        obj01.DeleteRecord();
        
    }
    static testMethod void test_selectAll_UseCase1(){
        List<Contact> contact_Obj  =  [SELECT Id,LastName,Email,phone,dupcheck__dc3DisableDuplicateCheck__c from Contact];
        
        //List<Account> account_Obj  =  [SELECT Id,Name,ParentId,BillingStreet,BillingCity,BillingState,BillingPostalCode,BillingCountry,BillingLatitude,BillingLongitude,BillingGeocodeAccuracy,BillingAddress,ShippingStreet,ShippingCity,Phone,dupcheck__dc3DisableDuplicateCheck__c from Account];
        System.assertEquals(true,contact_Obj.size()>0);
        List<ProcessInstance> processinstance_Obj  =  [SELECT Id,ProcessDefinitionId,TargetObjectId,Status,CompletedDate,LastActorId,ElapsedTimeInDays,ElapsedTimeInHours,ElapsedTimeInMinutes,SubmittedById,IsDeleted,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp from ProcessInstance];
        Contact_approval obj01 = new Contact_approval(new ApexPages.StandardController(contact_Obj[0]));
        obj01.contactWrapperList = new List<Contact_approval.ContactWrapper>();
        obj01.itemsToApprove = processinstance_Obj;
        obj01.allSelect = false;
        obj01.selectedContactIds = new Set<Id>();
        obj01.selectAll();
        
        
    }
    static testMethod void test_selectAll_UseCase3(){
        
        List<Contact> contact_Obj  =  [SELECT Id,LastName,Email,dupcheck__dc3DisableDuplicateCheck__c from Contact];    
        Contact c1=new Contact();
        c1.LastName='Name354';
        //Insert a1;
        // Reject the submitted request, without providing a comment.
        Approval.ProcessWorkitemRequest testRej = new Approval.ProcessWorkitemRequest();
        testRej.setComments('');
        testRej.setAction  ('Reject');      
        testRej.setWorkitemId(c1.id);
        
        Test.startTest();        
        // Attempt to process the rejection
        try
        {
            Approval.ProcessResult testRejResult =  Approval.process(testRej);
            system.assert(false, 'A rejection with no comment should cause an exception');
        }
        catch(DMLException e)
        {
            //system.assertEquals('Operation Cancelled: Please provide a rejection reason!', e.getDmlMessage(0), 'error message should be Operation Cancelled: Please provide a rejection reason!'); 
        }
        Test.stopTest();
    }
    static testMethod void test_selectAll_UseCase2(){
        List<Contact> contact_Obj  =  [SELECT Id,LastName,Email,Phone,dupcheck__dc3DisableDuplicateCheck__c from Contact];
        System.assertEquals(true,contact_Obj.size()>0);
        List<ProcessInstance> processinstance_Obj  =  [SELECT Id,ProcessDefinitionId,TargetObjectId,Status,CompletedDate,LastActorId,ElapsedTimeInDays,ElapsedTimeInHours,ElapsedTimeInMinutes,SubmittedById,IsDeleted,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp from ProcessInstance];
        Account_approval obj01 = new Account_approval(new ApexPages.StandardController(contact_Obj[0]));
        obj01.accountWrapperList = new List<Account_approval.AccountWrapper>();
        obj01.itemsToApprove = processinstance_Obj;
        obj01.allSelect = false;
        obj01.selectedAccountIds = new Set<Id>();
        obj01.selectAll();
        
        Contact c1=new Contact();
        c1.LastName='Name354';
         Insert c1;
        if([select count() from ProcessInstance where targetobjectid=:c1.id] < 1)
            
        {       
            Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
            req.setComments('Reject');
            req.setNextApproverIds(new Id[] {UserInfo.getUserId()});
            req.setObjectId(c1.Id);
            
            
            
            //Submit the approval request
            Approval.ProcessResult result = Approval.process(req);
            
        }
        obj01.selectedAccounts();
    }
    
       @isTest
    public static void testSendEmail() {
        Contact account_Obj = [SELECT Id, Name, Owner.Email FROM contact LIMIT 1];
        ApexPages.StandardController sc = new ApexPages.StandardController(account_Obj);
        Contact_approval obj01 = new Contact_approval(sc);
        obj01.con = account_Obj;
        obj01.toAddress = account_Obj.Owner.Email;
        obj01.ccAddress = account_Obj.Owner.Email;
        obj01.bccAddress = account_Obj.Owner.Email;
        obj01.subject = 'Test Subject';
        obj01.emailBody = 'Test Body';
        obj01.recordId = account_Obj.Id;
        obj01.openModal();
        obj01.sendEmail();
        obj01.returntolist();
        obj01.clearrecords();
    }
}