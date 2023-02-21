@isTest
private class Account_approval_Test{
    @testSetup
    static void setupTestData(){
        test.startTest();
        Account acc = new Account(Name = 'Name721', BillingStreet = 'PratapNagar', BillingCity = 'Jaipur', BillingState = 'Raj', BillingPostalCode = '302022', BillingCountry = 'India', BillingLatitude = 13, BillingLongitude = 14, BillingGeocodeAccuracy = 'Address', ShippingStreet = 'PratapNagar', ShippingCity = 'Jaipur', Phone = '54343-63963', dupcheck__dc3DisableDuplicateCheck__c = false);
        Insert acc; 
         ApexPages.currentPage().getParameters().put('Id',acc.id);	
        ApexPages.StandardController sc =new ApexPages.StandardController(acc);
        Account_Approval ec=new Account_Approval (sc);
         ec.toAddress=acc.Owner.Email;
         ec.ccAddress='sfdcdev@cube84.com';
        ec.bccAddress= 'sfdcdev@cube84.com';
        ec.emailBody='test1111111';
        ec.subject='test22222';
        // ec.openModal();
       // ec.sendEmail();
      
        //   ItemsToApproveController.AccountWrapper accwrap=new ItemsToApproveController.AccountWrapper(accountWrapperList);
        //   accwrap.selected=true;
        //ProcessInstance processinstance_Obj = new ProcessInstance();
        //Insert processinstance_Obj; 
        test.stopTest();
    }
    static testMethod void test_selectedAccounts_UseCase1(){
        List<Account> acc  =  [SELECT Id,Name,ParentId,BillingStreet,BillingCity,BillingState,BillingPostalCode,BillingCountry,BillingLatitude,BillingLongitude,BillingGeocodeAccuracy,BillingAddress,ShippingStreet,ShippingCity,Phone,dupcheck__dc3DisableDuplicateCheck__c from Account];
        System.assertEquals(true,acc.size()>0);
        List<ProcessInstance> pr  =  [SELECT Id,ProcessDefinitionId,TargetObjectId,Status,CompletedDate,LastActorId,ElapsedTimeInDays,ElapsedTimeInHours,ElapsedTimeInMinutes,SubmittedById,IsDeleted,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp from ProcessInstance];
        Account_approval obj01 = new Account_approval(new ApexPages.StandardController(acc[0]));
        obj01.accountWrapperList = new List<Account_approval.AccountWrapper>();
        obj01.itemsToApprove = pr;
        obj01.allSelect = false;
        obj01.selectedAccountIds = new Set<Id>();
        obj01.selectedAccounts();
        system.debug('Test test');
        system.debug('Test test');
        system.debug('Test test');
        system.debug('Test test');
    }
    
    static testMethod void test_selectedAccounts_UseCase2(){
        List<Account> acc  =[SELECT Id,Name,ParentId,BillingStreet,BillingCity,BillingState,BillingPostalCode,BillingCountry,BillingLatitude,BillingLongitude,BillingGeocodeAccuracy,BillingAddress,ShippingStreet,ShippingCity,Phone,dupcheck__dc3DisableDuplicateCheck__c from Account];
        System.assertEquals(true,acc.size()>0);
        List<ProcessInstance> pr  =  [SELECT Id,ProcessDefinitionId,TargetObjectId,Status,CompletedDate,LastActorId,ElapsedTimeInDays,ElapsedTimeInHours,ElapsedTimeInMinutes,SubmittedById,IsDeleted,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp from ProcessInstance];
        Account_approval obj01 = new Account_approval(new ApexPages.StandardController(acc[0]));
        obj01.accountWrapperList = new List<Account_approval.AccountWrapper>();
        obj01.itemsToApprove = pr;
        obj01.allSelect = false;
        obj01.selectedAccountIds = new set<Id>();
        Account a1=new Account();
        a1.Name='Name354';
        a1.BillingStreet = 'Mallad Road';
        a1.BillingCity='BillingCity270';
        a1.BillingState = 'London';
        a1.BillingPostalCode = '302033';
        a1.BillingCountry = 'United Kingdom';
        a1.BillingGeocodeAccuracy='Address';
        a1.ShippingStreet = 'Mallad Road';
        a1.ShippingCity='ShippingCity497';
        Insert a1;
        //processinstance pe=new processinstance();
        //pe.Status='Approved';
        //pe.TargetObjectId= a1.Id;   
        //Insert pe;
        if([select count() from ProcessInstance where targetobjectid=:a1.id] < 1)
        {       
            Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
            req.setComments('Approved');
            req.setNextApproverIds(new Id[] {UserInfo.getUserId()});
            req.setObjectId(a1.Id);
            
            //Submit the approval request
            Approval.ProcessResult result = Approval.process(req);
            
        }
        obj01.selectedAccounts();
    }
    static testMethod void test_addToGrid_UseCase1(){
        List<Account> acc  =  [SELECT Id,Name,ParentId,BillingStreet,BillingCity,BillingState,BillingPostalCode,BillingCountry,BillingLatitude,BillingLongitude,BillingGeocodeAccuracy,BillingAddress,ShippingStreet,ShippingCity,Phone,dupcheck__dc3DisableDuplicateCheck__c from Account];
        System.assertEquals(true,acc.size()>0);
        List<ProcessInstance> pr  =  [SELECT Id,ProcessDefinitionId,TargetObjectId,Status,CompletedDate,LastActorId,ElapsedTimeInDays,ElapsedTimeInHours,ElapsedTimeInMinutes,SubmittedById,IsDeleted,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp from ProcessInstance];
        Account_approval obj01 = new Account_approval(new ApexPages.StandardController(acc[0]));
        obj01.accountWrapperList = new List<Account_approval.AccountWrapper>();
        obj01.itemsToApprove = pr;
        obj01.allSelect = false;
        obj01.selectedAccountIds = new Set<Id>();
        obj01.addToGrid();
        
    }
    static testMethod void test_approveAccount_UseCase1(){
        List<Account> acc  =  [SELECT Id,Name,ParentId,BillingStreet,BillingCity,BillingState,BillingPostalCode,BillingCountry,BillingLatitude,BillingLongitude,BillingGeocodeAccuracy,BillingAddress,ShippingStreet,ShippingCity,Phone,dupcheck__dc3DisableDuplicateCheck__c from Account];
        System.assertEquals(true,acc.size()>0);
        List<ProcessInstance> pr  =  [SELECT Id,ProcessDefinitionId,TargetObjectId,Status,CompletedDate,LastActorId,ElapsedTimeInDays,ElapsedTimeInHours,ElapsedTimeInMinutes,SubmittedById,IsDeleted,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp from ProcessInstance];
        Account_approval obj01 = new Account_approval(new ApexPages.StandardController(acc[0]));
        obj01.accountWrapperList = new List<Account_approval.AccountWrapper>();
        obj01.itemsToApprove = pr;
        obj01.allSelect = false;
        obj01.selectedAccountIds = new Set<Id>();
        obj01.approveAccount();
        
    }
    static testMethod void test_DeleteRecord_UseCase1(){
        List<Account> account_Obj  =  [SELECT Id,Name,ParentId,BillingStreet,BillingCity,BillingState,BillingPostalCode,BillingCountry,BillingLatitude,BillingLongitude,BillingGeocodeAccuracy,BillingAddress,ShippingStreet,ShippingCity,Phone,dupcheck__dc3DisableDuplicateCheck__c from Account];
        System.assertEquals(true,account_Obj.size()>0);
        List<ProcessInstance> processinstance_Obj  =  [SELECT Id,ProcessDefinitionId,TargetObjectId,Status,CompletedDate,LastActorId,ElapsedTimeInDays,ElapsedTimeInHours,ElapsedTimeInMinutes,SubmittedById,IsDeleted,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp from ProcessInstance];
        Account_approval obj01 = new Account_approval(new ApexPages.StandardController(account_Obj[0]));
        obj01.accountWrapperList = new List<Account_approval.AccountWrapper>();
        obj01.itemsToApprove = processinstance_Obj;
        obj01.allSelect = false;
        obj01.selectedAccountIds = new Set<Id>();
        obj01.DeleteRecord();
        
    }
    static testMethod void test_selectAll_UseCase1(){
        List<Account> account_Obj  =  [SELECT Id,Name,ParentId,BillingStreet,BillingCity,BillingState,BillingPostalCode,BillingCountry,BillingLatitude,BillingLongitude,BillingGeocodeAccuracy,BillingAddress,ShippingStreet,ShippingCity,Phone,dupcheck__dc3DisableDuplicateCheck__c from Account];
        System.assertEquals(true,account_Obj.size()>0);
        List<ProcessInstance> processinstance_Obj  =  [SELECT Id,ProcessDefinitionId,TargetObjectId,Status,CompletedDate,LastActorId,ElapsedTimeInDays,ElapsedTimeInHours,ElapsedTimeInMinutes,SubmittedById,IsDeleted,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp from ProcessInstance];
        Account_approval obj01 = new Account_approval(new ApexPages.StandardController(account_Obj[0]));
        obj01.accountWrapperList = new List<Account_approval.AccountWrapper>();
        obj01.itemsToApprove = processinstance_Obj;
        obj01.allSelect = false;
        obj01.selectedAccountIds = new Set<Id>();
        obj01.selectAll();
        
        
    }
    static testMethod void test_selectAll_UseCase3(){
        List<Account> account_Obj  =  [SELECT Id,Name,ParentId,BillingStreet,BillingCity,BillingState,BillingPostalCode,BillingCountry,BillingLatitude,BillingLongitude,BillingGeocodeAccuracy,BillingAddress,ShippingStreet,ShippingCity,Phone,dupcheck__dc3DisableDuplicateCheck__c from Account];    
        Account a1=new Account();
        a1.Name='Name354';
        a1.BillingStreet = 'Mallad Road';
        a1.BillingCity='BillingCity270';
        a1.BillingState = 'London';
        a1.BillingPostalCode = '302033';
        a1.BillingCountry = 'United Kingdom';
        a1.BillingGeocodeAccuracy='Address';
        a1.ShippingStreet = 'Mallad Road';
        a1.ShippingCity='ShippingCity497';
        //Insert a1;
        // Reject the submitted request, without providing a comment.
        Approval.ProcessWorkitemRequest testRej = new Approval.ProcessWorkitemRequest();
        testRej.setComments('');
        testRej.setAction  ('Reject');      
        testRej.setWorkitemId(a1.id);
        
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
        List<Account> account_Obj  =  [SELECT Id,Name,ParentId,BillingStreet,BillingCity,BillingState,BillingPostalCode,BillingCountry,BillingLatitude,BillingLongitude,BillingGeocodeAccuracy,BillingAddress,ShippingStreet,ShippingCity,Phone,dupcheck__dc3DisableDuplicateCheck__c from Account];
        System.assertEquals(true,account_Obj.size()>0);
        List<ProcessInstance> processinstance_Obj  =  [SELECT Id,ProcessDefinitionId,TargetObjectId,Status,CompletedDate,LastActorId,ElapsedTimeInDays,ElapsedTimeInHours,ElapsedTimeInMinutes,SubmittedById,IsDeleted,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp from ProcessInstance];
        Account_approval obj01 = new Account_approval(new ApexPages.StandardController(account_Obj[0]));
        obj01.accountWrapperList = new List<Account_approval.AccountWrapper>();
        obj01.itemsToApprove = processinstance_Obj;
        obj01.allSelect = false;
        obj01.selectedAccountIds = new Set<Id>();
        obj01.selectAll();
        
        Account a1=new Account();
        a1.Name='Name354';
        a1.BillingStreet = 'Mallad Road';
        a1.BillingCity='BillingCity270';
        a1.BillingState = 'London';
        a1.BillingPostalCode = '302033';
        a1.BillingCountry = 'United Kingdom';
        a1.BillingGeocodeAccuracy='Address';
        a1.ShippingStreet = 'Mallad Road';
        a1.ShippingCity='ShippingCity497';
        Insert a1;
        if([select count() from ProcessInstance where targetobjectid=:a1.id] < 1)
            
        {       
            Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
            req.setComments('Reject');
            req.setNextApproverIds(new Id[] {UserInfo.getUserId()});
            req.setObjectId(a1.Id);
       
            //Submit the approval request
            Approval.ProcessResult result = Approval.process(req);
            
        }
        obj01.selectedAccounts();
    }
    
    @isTest
    public static void testSendEmail() {
        Account account_Obj = [SELECT Id, Name, Owner.Email FROM Account LIMIT 1];
        ApexPages.StandardController sc = new ApexPages.StandardController(account_Obj);
        Account_approval obj01 = new Account_approval(sc);
        obj01.acc = account_Obj;
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