global class UpdateSolicitationByCampaignBatches implements Database.Batchable<sObject>{
    
    string constantcont = 'Constant Contact';
    Date d= Date.Today();
    Time t = Time.newInstance(0,0,0,0);
    DateTime dt = DateTime.newInstanceGMT(d, t);
    global String query = 'Select Id, Name,IsActive,Type,StartDate,EndDate,Status,Campaign_Source__c,ParentId, CazoomiId__c,CampaignMemberRecordTypeId, RecordTypeId From Campaign Where Campaign_Source__c=:constantcont and createdDate>:dt '; 
    // global String query = 'Select Id, Name,IsActive,Type,StartDate,EndDate,Status,Campaign_Source__c,ParentId, CazoomiId__c,CampaignMemberRecordTypeId, RecordTypeId From Campaign Where Campaign_Source__c=:constantcont '; 

    public list<Solicitation_Member__c> cm {get;set;}
    public set<Id> campaignIdss {get;set;}
    public list<Solicitation__c> sol {get;set;}
    public list<Solicitation_Member__c> solMem {get;set;}
    
    global UpdateSolicitationByCampaignBatches(string query){
    this.query = query;
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC)
    {
    return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<Campaign> scope){
        
    sol = new List<Solicitation__c>(); 
    solMem = new list<Solicitation_Member__c>();
    Map<string, string> MapSol = new Map<string, string>();
    campaignIdss = new Set<Id>();
    cm=new list<Solicitation_Member__c>();
        
    for(Campaign cam:scope){ 
    if(cam.Campaign_Source__c=='Constant Contact'){  
    List<Solicitation__c> sollist = [Select Id From Solicitation__c Where Campaign__c =: cam.id];
    if(sollist.size()==0){
    Solicitation__c s=new Solicitation__c();
    s.Campaign_CazoomiId__c=cam.CazoomiId__c;
    s.name=cam.Name;
    s.Campaign__c=cam.id;
    s.Active__c=cam.IsActive;
    s.Type__c=cam.Type;
    s.End_date__c=cam.EndDate;
    s.Start_Date__c=cam.StartDate;
    s.Status__c=cam.Status;
    s.Campaign_Source__c=cam.Campaign_Source__c;
    s.Parent_Campaign__c=cam.ParentId;
    sol.add(s);
    }   
    }
    }
    
    upsert sol;
    
    for(Solicitation__c s:sol){
    MapSol.put(s.Campaign__c,s.Id);
    campaignIdss.add(s.Campaign__c);
    system.debug('campaignIdss=='+campaignIdss);
    }
    
    List<Campaign> campaignIds = [select Id, Name, CazoomiId__c, Campaign_Source__c,StartDate, EndDate, ParentId, Status, Type,
    (select Id, Name, Campaign.name, CampaignId, LeadId, ContactId, Bounces__c, Clicks__c,CompanyOrAccount, Type, Email, Opens__c, Phone, HasResponded, Status,MemberName__c,
                      Title, Contact.FirstName, Contact.LastName, Contact.Phone,CazoomiId__c,Lead.FirstName, Lead.LastName, Lead.Phone From CampaignMembers) From Campaign Where Id IN:campaignIdss];  
   
    for(campaign ca:campaignIds){
    for(CampaignMember c:ca.CampaignMembers){
    if(MapSol.get(c.campaignId)!=null){
    Solicitation_Member__c caa=new Solicitation_Member__c(); 
    caa.Solicitation__c=MapSol.get(c.CampaignId);
    caa.Name = c.MemberName__c;
    caa.Solicitation_Member_CazoomiId__c=c.CazoomiId__c;
    caa.Campaign__c=c.CampaignId;
    caa.Bounces__c=c.Bounces__c; 
    caa.Clicks__c=c.Clicks__c;
    caa.Contact__c=c.ContactId;
    caa.Company_Account__c=c.CompanyOrAccount;
    caa.Email__c=c.Email;
    caa.Lead__c=c.LeadId;
    caa.Opens__c=c.Opens__c;
    caa.Phone__c=c.Phone;
    caa.Responded__c=c.HasResponded;
    caa.Status__c=c.Status;
    caa.Title__c=c.Title;
    caa.Type__c = c.Type;
    cm.add(caa);
    }
    }
    }   
    upsert cm;
    }
    
    global void finish(Database.BatchableContext BC) {
    
    }
    }