global class SolicitationUpdateBatchJobsched implements Schedulable 
{
        string constantcont = 'Constant Contact';
        Date d= Date.Today();
        Time t = Time.newInstance(0,0,0,0);
        DateTime dt = DateTime.newInstanceGMT(d, t);
        global String query = 'Select Id, Name,IsActive,Type,StartDate,EndDate,Status,Campaign_Source__c,ParentId, CazoomiId__c,CampaignMemberRecordTypeId, RecordTypeId From Campaign Where Campaign_Source__c=:constantcont and createdDate>:dt '; 
        
    global void execute(SchedulableContext sc) 
    {
        
       
        UpdateSolicitationByCampaignBatches sol = new UpdateSolicitationByCampaignBatches(query); 
        database.executebatch(sol);
    //     // system.debug('database.executebatch(b)==='+database.executebatch(b));
    }
}