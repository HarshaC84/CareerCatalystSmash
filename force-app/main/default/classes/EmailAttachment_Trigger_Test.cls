@isTest
public class EmailAttachment_Trigger_Test {
     @testSetup
    static void setupTestData(){
        EmailMessage emailmessage_Obj = new EmailMessage(Incoming = false, Status = '0');
        Insert emailmessage_Obj; 
        System.debug('EmailMessage obj:'+emailmessage_Obj);
    }
    
    static testMethod void test_ContentDocumentLinkTrigger(){
        test.startTest();
        List<EmailMessage> emailmessage_Obj  =  [SELECT Incoming,Status,IsExternallyVisible from EmailMessage];
        System.debug('EmailMessage obj:'+emailmessage_Obj);
        System.assertEquals(1,emailmessage_Obj.size());
        Blob beforeblob=Blob.valueOf('Unit Test Attachment Body');
        ContentVersion ContentVersion_obj = new ContentVersion();
        ContentVersion_obj.title = 'test content trigger';      
        ContentVersion_obj.PathOnClient ='test';           
        ContentVersion_obj.VersionData =beforeblob;          
        insert ContentVersion_obj;         
        System.debug('Content version:'+ContentVersion_obj);
        ContentVersion testContent = [SELECT id, ContentDocumentId FROM ContentVersion where Id = :ContentVersion_obj.Id];
        ContentDocumentLink contentdocumentlink_Obj = new ContentDocumentLink(LinkedEntityId = emailmessage_Obj[0].id,ShareType= 'V',ContentDocumentId = testContent.ContentDocumentId);
        System.debug('Content version:'+testContent.ContentDocumentId);
        Insert contentdocumentlink_Obj; 
        System.debug('Content version:'+contentdocumentlink_Obj);
        test.stopTest();
    }

}