@isTest
private class Opportunity_approval_Test{
    @testSetup
    static void setupTestData(){
        test.startTest();
        opportunity opp = new opportunity( Name = 'Name437', StageName = 'Prospecting', CloseDate = Date.today());
        Insert opp; 
         ApexPages.currentPage().getParameters().put('Id',opp.id);	
        ApexPages.StandardController sc =new ApexPages.StandardController(opp);
        Opportunity_approval ec=new Opportunity_approval (sc);
         ec.toAddress=opp.Owner.Email;
         ec.ccAddress='test2@gmail.com';
        ec.bccAddress= 'test3@gmail.com';
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
    static testMethod void test_selectedOpportunities_UseCase1(){
        List<opportunity> opp  =  [SELECT IsPrivate,Name,StageName,CloseDate from Opportunity];
        System.assertEquals(true,opp.size()>0);
        List<ProcessInstance> pr  =  [SELECT Id,ProcessDefinitionId,TargetObjectId,Status,CompletedDate,LastActorId,ElapsedTimeInDays,ElapsedTimeInHours,ElapsedTimeInMinutes,SubmittedById,IsDeleted,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp from ProcessInstance];
        Opportunity_approval obj01 = new Opportunity_approval(new ApexPages.StandardController(opp[0]));
        obj01.OpportunityWrapperList = new List<Opportunity_approval.OpportunityWrapper>();
        obj01.itemsToApprove = pr;
        obj01.allSelect = false;
        obj01.selectedOpportunityIds = new Set<Id>();
        obj01.selectedOpportunities();
    }
    
    static testMethod void test_selectedOpportunities_UseCase2(){
        List<opportunity> acc =[SELECT IsPrivate,Name,StageName,CloseDate from Opportunity];
        System.assertEquals(true,acc.size()>0);
        List<ProcessInstance> pr  =  [SELECT Id,ProcessDefinitionId,TargetObjectId,Status,CompletedDate,LastActorId,ElapsedTimeInDays,ElapsedTimeInHours,ElapsedTimeInMinutes,SubmittedById,IsDeleted,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp from ProcessInstance];
         Opportunity_approval obj01 = new  Opportunity_approval(new ApexPages.StandardController(acc[0]));
        obj01.OpportunityWrapperList= new List<Opportunity_approval.OpportunityWrapper>();
        obj01.itemsToApprove = pr;
        obj01.allSelect = false;
        obj01.selectedOpportunityIds = new set<Id>();
        opportunity a1=new opportunity();
        a1.Name='Name354';
        a1.StageName='prospecting';
        a1.CloseDate=date.today();
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
        obj01.selectedOpportunities();
    }
    static testMethod void test_addToGrid_UseCase1(){
        List<opportunity> acc  =  [SELECT IsPrivate,Name,StageName,CloseDate from Opportunity];
        System.assertEquals(true,acc.size()>0);
        List<ProcessInstance> pr  =  [SELECT Id,ProcessDefinitionId,TargetObjectId,Status,CompletedDate,LastActorId,ElapsedTimeInDays,ElapsedTimeInHours,ElapsedTimeInMinutes,SubmittedById,IsDeleted,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp from ProcessInstance];
       Opportunity_approval obj01 = new  Opportunity_approval(new ApexPages.StandardController(acc[0]));
        obj01.OpportunityWrapperList= new List<Opportunity_approval.OpportunityWrapper>();
        obj01.itemsToApprove = pr;
        obj01.allSelect = false;
        obj01.selectedOpportunityIds = new set<Id>();
        obj01.addToGrid();
        
    }
    static testMethod void test_approveOpportunity_UseCase1(){
       List<opportunity> acc  =  [SELECT IsPrivate,Name,StageName,CloseDate from Opportunity];
        System.assertEquals(true,acc.size()>0);
        List<ProcessInstance> pr  =  [SELECT Id,ProcessDefinitionId,TargetObjectId,Status,CompletedDate,LastActorId,ElapsedTimeInDays,ElapsedTimeInHours,ElapsedTimeInMinutes,SubmittedById,IsDeleted,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp from ProcessInstance];
       Opportunity_approval obj01 = new  Opportunity_approval(new ApexPages.StandardController(acc[0]));
        obj01.OpportunityWrapperList= new List<Opportunity_approval.OpportunityWrapper>();
        obj01.itemsToApprove = pr;
        obj01.allSelect = false;
        obj01.selectedOpportunityIds = new set<Id>();
        obj01.approveOpportunity();
        
    }
    static testMethod void test_DeleteRecord_UseCase1(){
     List<opportunity> acc  =  [SELECT IsPrivate,Name,StageName,CloseDate from Opportunity];
        System.assertEquals(true,acc.size()>0);
        List<ProcessInstance> pr  =  [SELECT Id,ProcessDefinitionId,TargetObjectId,Status,CompletedDate,LastActorId,ElapsedTimeInDays,ElapsedTimeInHours,ElapsedTimeInMinutes,SubmittedById,IsDeleted,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp from ProcessInstance];
       Opportunity_approval obj01 = new  Opportunity_approval(new ApexPages.StandardController(acc[0]));
        obj01.OpportunityWrapperList= new List<Opportunity_approval.OpportunityWrapper>();
        obj01.itemsToApprove = pr;
        obj01.allSelect = false;
        obj01.selectedOpportunityIds = new set<Id>();
        obj01.DeleteRecord();
        
    }
    static testMethod void test_selectAll_UseCase1(){
      List<opportunity> acc  =  [SELECT IsPrivate,Name,StageName,CloseDate from Opportunity];
        System.assertEquals(true,acc.size()>0);
        List<ProcessInstance> pr  =  [SELECT Id,ProcessDefinitionId,TargetObjectId,Status,CompletedDate,LastActorId,ElapsedTimeInDays,ElapsedTimeInHours,ElapsedTimeInMinutes,SubmittedById,IsDeleted,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp from ProcessInstance];
       Opportunity_approval obj01 = new  Opportunity_approval(new ApexPages.StandardController(acc[0]));
        obj01.OpportunityWrapperList= new List<Opportunity_approval.OpportunityWrapper>();
        obj01.itemsToApprove = pr;
        obj01.allSelect = false;
        obj01.selectedOpportunityIds = new set<Id>();
        obj01.selectAll();
        
        
    }
    static testMethod void test_selectAll_UseCase3(){
      List<opportunity> acc  =  [SELECT IsPrivate,Name,StageName,CloseDate from Opportunity]; 
        opportunity a1=new opportunity();
        a1.Name='Name354';
        a1.Name='Name354';
        a1.StageName='prospecting';
        a1.CloseDate=date.today();
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
        List<opportunity> acc  =  [SELECT IsPrivate,Name,StageName,CloseDate from Opportunity]; 
        System.assertEquals(true,acc.size()>0);
        List<ProcessInstance> processinstance_Obj  =  [SELECT Id,ProcessDefinitionId,TargetObjectId,Status,CompletedDate,LastActorId,ElapsedTimeInDays,ElapsedTimeInHours,ElapsedTimeInMinutes,SubmittedById,IsDeleted,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp from ProcessInstance];
         Opportunity_approval obj01 = new  Opportunity_approval(new ApexPages.StandardController(acc[0]));
        obj01.OpportunityWrapperList= new List<Opportunity_approval.OpportunityWrapper>();
        obj01.itemsToApprove = processinstance_Obj;
        obj01.allSelect = false;
        obj01.selectedOpportunityIds = new set<Id>();
        obj01.selectAll();
        
        opportunity a1=new opportunity();
        a1.Name='Name354';
        a1.Name='Name354';
        a1.StageName='prospecting';
        a1.CloseDate=date.today();
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
        obj01.approveOpportunity();
    }
    
    @isTest
    public static void testSendEmail() {
        opportunity account_Obj = [SELECT Id, Name, Owner.Email FROM opportunity LIMIT 1];
        ApexPages.StandardController sc = new ApexPages.StandardController(account_Obj);
        Opportunity_approval obj01 = new Opportunity_approval(sc);
        obj01.opp = account_Obj;
        obj01.toAddress = account_Obj.Owner.Email;
        obj01.ccAddress = account_Obj.Owner.Email;
        obj01.bccAddress = account_Obj.Owner.Email;
        obj01.subject = 'Test Subject';
        obj01.emailBody = 'Test Body';
        obj01.recordId = account_Obj.Id;
        obj01.openModal();
        obj01.sendEmail();
        obj01.returntolist();
       // obj01.clearrecords();
    }
}