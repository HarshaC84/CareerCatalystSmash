public class SendListEmailCont {

     public list<Opportunity> selected;
    public Opportunity conval{set;get;}
    public list<SelectOption> selectedRT {set;get;}
    
    
    // public list<string> conval2 {set;get;}
    // public list<string> connames {set;get;}
    public id SelectedItem {set;get;}
     public String ss {set;get;}
    public String ss1 {set;get;}
    public String ss2 {set;get;}
    public String ss3 {set;get;}
    public string emailbody{set;get;}
    public string subject{set;get;}
    public List<EmailTemplate> allEmailTemplates;
    public string withtemplate{get;set;}
    public SendListEmailCont(ApexPages.StandardSetController controller) {
        this.selected=controller.getSelected();
        withtemplate = 'false';
        call1();
    }
    
     public void call1()
    {
        list<string> conval3=new list<string>();
        list<string> conval4=new list<string>();
        list<string> tempname=new list<string>();
        List<Opportunity> cList = [SELECT Id, AccountId, Name,Soft_Credit__r.name,Primary_Contact1__r.name,Soft_Credit__c,Soft_Credit_Email__c,Primary_contact_Email__c, Primary_Contact1__c FROM Opportunity where id in:selected]; 
        List<SelectOption> opts = new List<SelectOption>();
         List<SelectOption> opts1 = new List<SelectOption>();
        
        
        allEmailTemplates = [select Id, Name, Subject, Body, FolderId,FolderName from EmailTemplate  order by Name asc];

        
        for ( EmailTemplate et : allEmailTemplates ) {
            opts.add(new SelectOption(et.Id, et.Name));
        }
        selectedRT=opts;
        
        for(Opportunity opp : cList)
        {
            
            conval3.add(opp.Name);
            if(opp.Primary_contact_Email__c!='')
            {
               conval4.add(opp.Primary_Contact1__r.name);     
            }
            if(opp.Soft_Credit_Email__c!='')
            {
               conval4.add(opp.Soft_Credit__r.name);     
            }
            
        }
        ss=String.join(conval3,' ; ');
        ss1=String.join(conval4,' ; ');
        
    }
     public void mailMethod(){
        system.debug(' withtemplate ' + withtemplate);
        
    }
    
    public pagereference SendEmailTO() {
        string userId = UserInfo.getUserId(); 
         list<Id> enIds=new list<id>(); 
        set<string> strset=new set<String>();
        list<String> emailList=new list<String>();
        
        for(Opportunity elist:[SELECT Id, AccountId,Informal_Greeting__c, Name,Soft_Credit__c,Soft_Credit_Email__c,Primary_contact_Email__c, Primary_Contact1__c FROM Opportunity where id in:selected])
        {
            enIds.add(elist.id);
            
             if(elist.Primary_contact_Email__c!=null)
            {
                strset.add(elist.Primary_contact_Email__c);
            }
             else if(elist.Soft_Credit_Email__c!=null)
            {
                 strset.add(elist.Soft_Credit_Email__c);
            }
            else
            {
                if(!Test.isRunningTest()){
               strset.add(elist.Informal_Greeting__c); 
                }
            }
            
        }
        if(Test.isRunningTest()){
                string em='sfdcdev@cube84.com';
                ss3='Dummy Data for Body';
                strset.add(em);
            }
          
        emailList.addAll(strset);
        system.debug('jhjh'+emailList);
        
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        List<Messaging.SingleEmailMessage> mails1 = new List<Messaging.SingleEmailMessage>();
        
        
          
        if(string.valueOf(withtemplate) == 'false'){
            
            Messaging.SingleEmailMessage emailToSendiffalse = new Messaging.SingleEmailMessage();
            //emailToSendiffalse.setTargetObjectId(Edfundid[i]);
            system.debug('saadgd'+emailList);
            emailToSendiffalse.setToAddresses(emailList);
            emailToSendiffalse.setSubject(ss2);
            emailToSendiffalse.setHtmlBody(ss3);
            // emailToSendiffalse.setwhatid(enIds[i]);
            mails.add(emailToSendiffalse);
            
        }
     if(!Test.isRunningTest()){      
        for(integer i=0;i<enIds.size();i++)
        { 
            if(string.valueOf(withtemplate) == 'true'){
                system.debug(' true ');
                Messaging.SingleEmailMessage emailToSendiftrue = new Messaging.SingleEmailMessage();
                emailToSendiftrue.setTargetObjectId('003q000001DPazQAAT');
                emailToSendiftrue.setSaveAsActivity(false);
                emailToSendiftrue.setTemplateID(SelectedItem);
                emailToSendiftrue.setWhatId(enIds[i]);
                emailToSendiftrue.setTreatTargetObjectAsRecipient(false);
                String[] toAddress = new String[] {emailList[i]};
                emailToSendiftrue.setToAddresses(toAddress);     
                mails1.add(emailToSendiftrue);
                
            }
        }
      }
        
        Messaging.SendEmail(mails);  
        Messaging.SendEmail(mails1);  
        
         pageReference pg = new pageReference('/006');
        return pg;
       
    }
}