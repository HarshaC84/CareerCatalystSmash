trigger Email_attachments_Trigger on ContentDocumentLink (before insert) {
    
    Set<Id> Parents = new Set<Id>(); 
    Map<String,string> ids = new Map<String,String>();
    for (ContentDocumentLink a : trigger.new) { 
        if(a.LinkedEntityId.getSObjectType() == EmailMessage.getSObjectType()) 
            Parents.add(a.LinkedEntityId); 
       
    }
       system.debug(Parents);
    for(EmailMessage  msgList:[SELECT Id, RelatedToId  FROM EmailMessage where id=:Parents] ){
        SYstem.debug('///message lit///'+msgList);
         if(msgList.RelatedToId !=null && msgList.RelatedToId.getSObjectType() == Opportunity.getSObjectType()) 
             ids.put(msgList.id,msgList.RelatedToId );
        SYstem.debug('///message lit///'+ids);
    }
        try
        {    
    for (ContentDocumentLink a : trigger.new) {
        if(ids.get(a.LinkedEntityId)!=null)
           
        a.LinkedEntityId =ids.get(a.LinkedEntityId);
            }
        }catch(Exception e)
            {
                System.debug('You are tring to insering the duplicate Attachment'+e);
            }
    


}