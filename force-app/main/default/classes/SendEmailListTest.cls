@isTest
public class SendEmailListTest {

    @isTest 
    public static void testWarmTemp() {
        
        contact cc= new contact();
        cc.lastname='test';
        cc.Email='test@gmail.com';
        insert cc;
        
        list<opportunity> listed= new list<opportunity>();
            
        opportunity opp= new opportunity();
        opp.Name='test1';
        opp.Primary_Contact1__c=cc.id;
        opp.StageName='Closed Won';
        opp.Amount=1000;
        opp.CloseDate=system.today();
        listed.add(opp);
        
        insert listed;
        
        
        
         test.startTest();    
        User u;
        User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
        // Insert account as current user
        
        System.runAs (thisUser) {
            list<EmailTemplate> etlist=new list<EmailTemplate>();
            EmailTemplate validEmailTemplate = new EmailTemplate();
            validEmailTemplate.isActive = true;
            validEmailTemplate.Name = 'name';
            validEmailTemplate.DeveloperName = 'unique_name_addSomethingSpecialHere';
            validEmailTemplate.TemplateType = 'text';
            validEmailTemplate.FolderId = UserInfo.getUserId();
            
            insert validEmailTemplate;
            etlist.add(validEmailTemplate);
            
            
            ApexPages.StandardSetController sc4 = new ApexPages.StandardSetController(listed);
            ApexPages.currentPage().getParameters().put('id', opp.id );
            SendListEmailCont  obj4 = new SendListEmailCont(sc4);
            
            PageReference pageRef4 = Page.SendListEmail; // Add your VF page Name here
            Test.setCurrentPage(pageRef4);
            obj4.withtemplate = 'false';
            obj4.emailbody = 'Test Body';
            obj4.subject = 'Test Subject';
            obj4.selected=listed;
            obj4.call1();
            obj4.allEmailTemplates=etlist;
            obj4.SelectedItem=validEmailTemplate.id;
            obj4.mailMethod();
            obj4.SendEmailTO();
            
        }
        test.stopTest();  

        
    }
}