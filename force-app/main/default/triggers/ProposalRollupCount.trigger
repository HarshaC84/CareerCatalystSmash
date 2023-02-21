trigger ProposalRollupCount on Proposal__c (before insert,before update,after insert,after update,after delete,after undelete){
   
    Set<Id> accountId = new Set<Id>();
    Set<Id> campaignId = new Set<Id>();
    Set<Id> contactID = new Set<Id>();
    
    set<id> accountold = new set<Id>();
    set<id> campaignold = new set<Id>();
    set<string> yearold = new set<string>();
     set<id> contactold = new set<Id>();
    
    Map<id,Map<Id,Integer>> rollupRes = new Map<id,Map<Id,Integer>>();
    Map<id,decimal> amounts = new Map<id,decimal>();
    list<string> dateaskedyear = new list<String>();
    
    List<Proposal__c> propLst = new List<Proposal__c>();
 
    if(trigger.isBefore && (trigger.isUpdate || trigger.isinsert))
    { 
        for(Proposal__c p : Trigger.New){
             Integer year = p.Date_Asked__c.year(); 
             p.dateaskedyear1__c =string.valueOf(year);
            
            if(p.Account__c<>null && p.Proposal_Type__c=='Organization'){
            accountId.add(p.Account__c);
                p.Contact__c=null;
            }
            campaignId.add(p.Campaign__c); 
            if(p.contact__c<>null && p.Proposal_Type__c=='Individual' ){
            contactID.add(p.contact__c); 
            p.Account__c=null;
            }
           if(p.Status__c <>'Approved' && p.Linked_Gift__c<>null)
           {
               p.Linked_Gift__c=null;
           }
            
            system.debug(p.contact__c);
            dateaskedyear.add(p.dateaskedyear1__c);
             system.debug(p.dateaskedyear1__c);
            
        }
        if(accountId.size()>0 || contactID.size()>0 ){  
            
            system.debug('nullcheck'+accountId);
            // query to get count,and sum of amount for same account and campaign 
            for(AggregateResult agr : [select count(Id),sum(Amount_Asked__c),account__c,campaign__c,contact__c,dateaskedyear1__c from proposal__c GROUP BY account__c,campaign__c,contact__c,dateaskedyear1__c having (account__c <>''
                                       AND campaign__c <> '' AND dateaskedyear1__c !=null AND dateaskedyear1__c=:dateaskedyear AND Account__c =:accountId AND Campaign__c =:campaignId) OR (contact__c <>''
                                       AND campaign__c <> '' AND dateaskedyear1__c !=null AND dateaskedyear1__c=:dateaskedyear AND contact__c =:contactID AND Campaign__c =:campaignId)]){
                                           Map<id,integer> campwithCount = new Map<id,integer>();
                                           amounts.put((Id)agr.get('account__c'),(decimal)agr.get('expr1'));
                                            amounts.put((Id)agr.get('contact__c'),(decimal)agr.get('expr1'));
                                           campwithCount.put((Id)agr.get('campaign__c'),(Integer)agr.get('expr0'));
                                           rollupRes.put((Id)agr.get('account__c'),campwithCount);
                                            rollupRes.put((Id)agr.get('contact__c'),campwithCount);
                                           system.debug(campwithCount);
                                           system.debug(rollupRes);
                                       }
           
                             
            for(Proposal__c p : Trigger.New){
                
                if((p.Account__c <> null && p.Campaign__c <> null && p.dateaskedyear1__c<>null ) || (p.contact__c <> null && p.Campaign__c<>null && p.dateaskedyear1__c<>null)) 
                {
                   
                    if(rollupRes.size()>0){
                        if(trigger.isbefore && trigger.isinsert){
                            system.debug(rollupRes.get(p.Account__c).get(p.Campaign__c));
                            p.Total_Number_Of_Proposals1__c = rollupRes.get(p.Account__c).get(p.Campaign__c)+1;
                             p.Total_Number_Of_Proposals1__c = rollupRes.get(p.contact__c).get(p.Campaign__c)+1;
                            system.debug(p.Amount_Asked__c);
                             p.Total_Amount_Asked__c = amounts.get(p.account__c) + p.Amount_Asked__c ;
                             p.Total_Amount_Asked__c = amounts.get(p.contact__c) + p.Amount_Asked__c ;
                            system.debug(amounts.get(p.account__c));
                            system.debug(p.Total_Amount_Asked__c);
                        }
                        if(trigger.isbefore && trigger.isupdate && ((p.Account__c== trigger.oldmap.get(p.Id).Account__c && p.Campaign__c== trigger.oldmap.get(p.Id).Campaign__c && p.dateaskedyear1__c== trigger.oldmap.get(p.Id).dateaskedyear1__c)||(p.contact__c== trigger.oldmap.get(p.Id).contact__c && p.Campaign__c== trigger.oldmap.get(p.Id).Campaign__c && p.dateaskedyear1__c== trigger.oldmap.get(p.Id).dateaskedyear1__c))){
                            system.debug(rollupRes.get(p.Account__c).get(p.Campaign__c));
                            p.Total_Number_Of_Proposals1__c = rollupRes.get(p.Account__c).get(p.Campaign__c);
                              p.Total_Number_Of_Proposals1__c = rollupRes.get(p.contact__c).get(p.Campaign__c);
                            system.debug(p.Amount_Asked__c);
                            p.Total_Amount_Asked__c = amounts.get(p.account__c);
                              p.Total_Amount_Asked__c = amounts.get(p.contact__c);
                            system.debug(amounts.get(p.account__c));
                            system.debug(p.Total_Amount_Asked__c);
                        }
                        if(trigger.isbefore && trigger.isupdate && ((p.Account__c!= trigger.oldmap.get(p.Id).Account__c && p.Campaign__c!= trigger.oldmap.get(p.Id).Campaign__c && p.dateaskedyear1__c!= trigger.oldmap.get(p.Id).dateaskedyear1__c)||(p.contact__c!= trigger.oldmap.get(p.Id).contact__c && p.Campaign__c!= trigger.oldmap.get(p.Id).Campaign__c && p.dateaskedyear1__c== trigger.oldmap.get(p.Id).dateaskedyear1__c))){
                            system.debug(rollupRes.get(p.Account__c).get(p.Campaign__c));
                            p.Total_Number_Of_Proposals1__c = rollupRes.get(p.Account__c).get(p.Campaign__c)+1;
                             p.Total_Number_Of_Proposals1__c = rollupRes.get(p.contact__c).get(p.Campaign__c)+1;
                            system.debug(p.Amount_Asked__c);
                            p.Total_Amount_Asked__c = amounts.get(p.account__c) + p.Amount_Asked__c ;
                              p.Total_Amount_Asked__c = amounts.get(p.contact__c) + p.Amount_Asked__c ;
                            system.debug(amounts.get(p.account__c));
                            system.debug(p.Total_Amount_Asked__c);
                        }
                        
                    }
                  
                    else
                    { 
                        p.Total_Number_Of_Proposals1__c = 1;
                        p.Total_Amount_Asked__c = p.Amount_Asked__c;
                        
                    }
                
                }
                else
                {
                    system.debug(p.Total_Number_Of_Proposals1__c);
                    p.Total_Number_Of_Proposals1__c = 1; 
                    p.Total_Amount_Asked__c = p.Amount_Asked__c;
                    system.debug(p.Total_Number_Of_Proposals1__c);
                }
            
            }
            
        }
    }
            if(trigger.isAfter && (trigger.isUpdate || trigger.isinsert))   
            {
                 
                 if(ProposalUpdate.runOnce())
             {
             for(Proposal__c p : Trigger.new){
             if(p.Account__c<>null)
            accountId.add(p.Account__c); 
               
            campaignId.add(p.Campaign__c); 
             if(p.contact__c<>null)
            contactID.add(p.contact__c); 
            system.debug(p.contact__c);
             dateaskedyear.add(p.DateAskedYear__c); 
                 
            
                }
                                     
                for(AggregateResult agr : [select count(Id),sum(Amount_Asked__c),account__c,campaign__c,contact__c,dateaskedyear1__c from proposal__c GROUP BY account__c,campaign__c,contact__c,dateaskedyear1__c having (account__c <>''
                                       AND campaign__c <> '' AND dateaskedyear1__c !=null AND dateaskedyear1__c=:dateaskedyear AND Account__c =:accountId AND Campaign__c =:campaignId) OR (contact__c <>''
                                       AND campaign__c <> '' AND contact__c =:contactID AND Campaign__c =:campaignId)]){
                                           Map<id,integer> campwithCount = new Map<id,integer>();
                                           amounts.put((Id)agr.get('account__c'),(decimal)agr.get('expr1'));
                                            amounts.put((Id)agr.get('contact__c'),(decimal)agr.get('expr1'));
                                           campwithCount.put((Id)agr.get('campaign__c'),(Integer)agr.get('expr0'));
                                           rollupRes.put((Id)agr.get('account__c'),campwithCount);
                                            rollupRes.put((Id)agr.get('contact__c'),campwithCount);
                                           system.debug(campwithCount);
                                           system.debug(rollupRes);
                                       }
        
        
        for(Proposal__c p : Trigger.new){
            if(rollupRes.size()>0)
            {
                
            list<proposal__c> plist=new list<proposal__c>();
            list<proposal__c> proplist=[select id,Total_Amount_Asked__c,Account__c,contact__c,Campaign__c,Total_Number_Of_Proposals1__c,dateaskedyear1__c from Proposal__c where (Account__c =:accountId AND Campaign__c =:campaignId AND dateaskedyear1__c=:dateaskedyear  AND account__c <>'' AND campaign__c <> '' AND dateaskedyear1__c <>'')
                                       OR (contact__c =:contactID AND Campaign__c =:campaignId AND dateaskedyear1__c=:dateaskedyear AND contact__c <>'' AND campaign__c <> '' AND dateaskedyear1__c <>'')];
            for(Proposal__c p1 : proplist){
                system.debug(Amounts.get(p.Account__c));
                system.debug(rollupRes.get(p.account__c));
                
                Proposal__c pp = new Proposal__c(id=p1.Id,Total_Amount_Asked__c=Amounts.get(p1.Account__c),Total_Number_Of_Proposals1__c=rollupRes.get(p1.account__c).get(p1.campaign__c));
                plist.add(pp);
            } 
            if(plist.size()>0)
                update plist;   
            }
            
        } 
                   if(trigger.isAfter && trigger.isUpdate) 
                 {
                   
                     for(Proposal__c p : Trigger.new){
                         if(p.Account__c<>null)
                   accountId.add(p.Account__c); 
               
                campaignId.add(p.Campaign__c); 
                if(p.contact__c<>null)
               contactID.add(p.contact__c); 
               system.debug(p.contact__c);
                 dateaskedyear.add(p.DateAskedYear__c); 
                      
                  if(trigger.oldmap.get(p.id).account__c!=null)
                  accountold.add(trigger.oldmap.get(p.id).account__c); 
                  
                  if(trigger.oldmap.get(p.id).campaign__c!=null)
                  campaignold.add(trigger.oldmap.get(p.id).campaign__c); 
                  
                  if(trigger.oldmap.get(p.id).dateaskedyear1__c!=null)
                  yearold.add(trigger.oldmap.get(p.id).dateaskedyear1__c);
                         
                    if(trigger.oldmap.get(p.id).contact__c!=null)
                  contactold.add(trigger.oldmap.get(p.id).contact__c); 
                     
                 
                     if(((trigger.oldmap.get(p.id).account__c!=null || trigger.oldmap.get(p.id).contact__c!=null)|| trigger.oldmap.get(p.id).campaign__c!=null ||trigger.oldmap.get(p.id).dateaskedyear1__c!=null)&&((p.Account__c!= trigger.oldmap.get(p.Id).Account__c ||p.contact__c!= trigger.oldmap.get(p.Id).contact__c )|| p.Campaign__c!= trigger.oldmap.get(p.Id).Campaign__c || p.dateaskedyear1__c!= trigger.oldmap.get(p.Id).dateaskedyear1__c))
                     {
                        for(AggregateResult agr : [select count(Id),sum(Amount_Asked__c),account__c,campaign__c,contact__c,dateaskedyear1__c from proposal__c GROUP BY account__c,campaign__c,contact__c,dateaskedyear1__c having (account__c <>''
                                       AND campaign__c <> '' AND dateaskedyear1__c !=null AND (dateaskedyear1__c=:dateaskedyear OR dateaskedyear1__c=:yearold) AND (Account__c =:accountId OR Account__c=:accountold) AND (Campaign__c =:campaignId OR Campaign__c=:campaignold)) OR (contact__c <>''
                                       AND campaign__c <> '' AND dateaskedyear1__c<>'' AND (dateaskedyear1__c=:dateaskedyear OR dateaskedyear1__c=:yearold) AND (contact__c =:contactID OR contact__c=:contactold) AND (Campaign__c =:campaignId OR Campaign__c=:campaignold))]){
                                           Map<id,integer> campwithCount = new Map<id,integer>();
                                           amounts.put((Id)agr.get('account__c'),(decimal)agr.get('expr1'));
                                            amounts.put((Id)agr.get('contact__c'),(decimal)agr.get('expr1'));
                                           campwithCount.put((Id)agr.get('campaign__c'),(Integer)agr.get('expr0'));
                                           rollupRes.put((Id)agr.get('account__c'),campwithCount);
                                            rollupRes.put((Id)agr.get('contact__c'),campwithCount);
                                           system.debug(campwithCount);
                                           system.debug(rollupRes);
                                       } 
                     }
                         
                     }
                     
                      for(Proposal__c p : Trigger.new){
            if(rollupRes.size()>0)
            {
                
                
            list<proposal__c> plist=new list<proposal__c>();
                     if(((trigger.oldmap.get(p.id).account__c!=null || trigger.oldmap.get(p.id).contact__c!=null)|| trigger.oldmap.get(p.id).campaign__c!=null ||trigger.oldmap.get(p.id).dateaskedyear1__c!=null)&&((p.Account__c!= trigger.oldmap.get(p.Id).Account__c ||p.contact__c!= trigger.oldmap.get(p.Id).contact__c )|| p.Campaign__c!= trigger.oldmap.get(p.Id).Campaign__c || p.dateaskedyear1__c!= trigger.oldmap.get(p.Id).dateaskedyear1__c))
                     {
            list<proposal__c> proplist=[select id,Total_Amount_Asked__c,Account__c,contact__c,Campaign__c,Total_Number_Of_Proposals1__c,dateaskedyear1__c from Proposal__c where (Account__c=:accountold AND  Campaign__c =:campaignold AND  dateaskedyear1__c=:yearold AND account__c <>'' AND campaign__c <> '' AND dateaskedyear1__c <>'')
                                       OR (contact__c =:contactold AND Campaign__c =:campaignold AND dateaskedyear1__c=:yearold AND contact__c <>'' AND campaign__c <> '' AND dateaskedyear1__c <>'')];
                
            for(Proposal__c p1 : proplist){
                system.debug(Amounts.get(p.Account__c));
                system.debug(rollupRes.get(p.account__c));
                
                Proposal__c pp = new Proposal__c(id=p1.Id,Total_Amount_Asked__c=Amounts.get(p1.Account__c),Total_Number_Of_Proposals1__c=rollupRes.get(p1.account__c).get(p1.campaign__c));
                plist.add(pp);
            } 
            if(plist.size()>0)
                update plist;   
            }
            }
            
        } 
                 }
                 
               
               
                // Account Rollups for proposal
                if(accountId.size()>0){
            
                map<id,double> pamtmap = new map<id,double>();
                map<id,Integer> pcntmap= new map<id,Integer>();
                map<id,Integer> pstatusmap= new map<id,Integer>();
                       
                 map<id,double> amtmap = new map<id,double>();
                map<id,Integer> cntmap= new map<id,Integer>();
                map<id,Integer> statusmap= new map<id,Integer>();
                       
                              for(aggregateresult pag : [select account__c,count(Id),sum(Amount_Asked__c) from Proposal__c where account__c IN :accountId AND  Date_Asked__c = LAST_YEAR GROUP BY account__c ] )
                                        {
                    pamtmap.put((ID)pag.get('account__c'), (double)pag.get('expr1'));
                    pcntmap.put((ID)pag.get('account__c'), (Integer)pag.get('expr0'));
                                             system.debug(pag);
                }
                
                for(aggregateresult pag1 : [select account__c,count(Id) from Proposal__c where account__c IN :accountId AND Date_Asked__c = LAST_YEAR AND Status__c <> 'Approved' AND Status__c <> 'Declined' 
                                           GROUP BY account__c] ){
                                               pstatusmap.put((ID)pag1.get('account__c'),(Integer)pag1.get('expr0')); 
                                               
                                           }
                         
                  list<account>pacclist = new list<account>();
                    
                for(id acc :accountId){
                    account acnt = new account();
                    acnt.id=acc;
                    
                    acnt.Total_Amount_For_Proposals__c = pamtmap.get(acc);
                    acnt.Total_Number_Of_Proposals__c = pcntmap.get(acc);
                    acnt.Total_Proposals_Open_Previous_Year__c = pstatusmap.get(acc);        
                    system.debug(pstatusmap.get(acc));
                    pacclist.add(acnt);       
                }
                
                if(pacclist.size()>0){
                   update pacclist;
                } 

                
                for(aggregateresult ag : [select account__c,count(Id),sum(Amount_Asked__c) from Proposal__c where account__c IN :accountId AND  Date_Asked__c = THIS_YEAR GROUP BY account__c
                                         ] ){
                    amtmap.put((ID)ag.get('account__c'), (double)ag.get('expr1'));
                    cntmap.put((ID)ag.get('account__c'), (Integer)ag.get('expr0'));
                }
                
                for(aggregateresult ag1 : [select account__c,count(Id) from Proposal__c where account__c IN :accountId AND  Date_Asked__c = THIS_YEAR AND Status__c <> 'Approved' AND Status__c <> 'Declined' 
                                           GROUP BY account__c ] ){
                                               statusmap.put((ID)ag1.get('account__c'),(Integer)ag1.get('expr0')); 
                                               
                                           }
                
                
               
                  list<account>acclist = new list<account>();
                    
                for(id acc :accountId){
                    account acnt = new account();
                    acnt.id=acc;
                    
                    acnt.Total_Amount_For_Proposals_This_Year__c = amtmap.get(acc);
                    acnt.Total_Number_Of_Proposals_This_Year__c = cntmap.get(acc);
                    acnt.Total_Number_Of_Proposals_Open_This_Year__c = statusmap.get(acc);        
                    system.debug(statusmap.get(acc));
                    acclist.add(acnt);       
                }
                
                if(acclist.size()>0){
                   update acclist;
                } 
                
                   }  
                //contact Rollups for proposal
                  
        else if(contactID.size()>0){
            
                map<id,double> pamtmap1 = new map<id,double>();
                map<id,Integer> pcntmap1= new map<id,Integer>();
                map<id,Integer> pstatusmap1= new map<id,Integer>();
            
              map<id,double> camtmap = new map<id,double>();
             map<id,Integer> ccntmap= new map<id,Integer>();
             map<id,Integer> cstatusmap= new map<id,Integer>();
    
            
             for(aggregateresult pag : [select contact__c,count(Id),sum(Amount_Asked__c) from Proposal__c where contact__c IN :contactID AND  Date_Asked__c = LAST_YEAR GROUP BY contact__c
                                  ] ){
        pamtmap1.put((ID)pag.get('contact__c'), (double)pag.get('expr1'));
        pcntmap1.put((ID)pag.get('contact__c'), (Integer)pag.get('expr0'));
    }
    
   for(aggregateresult pag1 : [select contact__c,count(Id) from Proposal__c where contact__c IN :contactID AND  Date_Asked__c = LAST_YEAR AND Status__c <> 'Approved' AND Status__c <> 'Declined' 
                               GROUP BY contact__c] ){
       pstatusmap1.put((ID)pag1.get('contact__c'),(Integer)pag1.get('expr0')); 
                                   
                    }
        
    
    list<contact>conlist1 = new list<contact>();
    
    for(id con :contactID){
        contact cnt = new contact();
             cnt.id=con;
        
            cnt.Total_Amount_For_Proposals_Previous_Year__c = pamtmap1.get(con);
            cnt.Total_Number_Of_Proposals_Previous_Year__c = pcntmap1.get(con);
           cnt.Total_Proposals_Open_Previous_Year__c = pstatusmap1.get(con);        
                               system.debug(pstatusmap1.get(con));
        conlist1.add(cnt);       
         system.debug(conlist1);
    }
   
    if(conlist1.size()>0)
        update conlist1;
            
    
    for(aggregateresult ag : [select contact__c,count(Id),sum(Amount_Asked__c) from Proposal__c where contact__c IN :contactID AND  Date_Asked__c = THIS_YEAR GROUP BY contact__c
                             ] ){
        camtmap.put((ID)ag.get('contact__c'), (double)ag.get('expr1'));
        ccntmap.put((ID)ag.get('contact__c'), (Integer)ag.get('expr0'));
    }
    
   for(aggregateresult ag1 : [select contact__c,count(Id) from Proposal__c where contact__c IN :contactID AND  Date_Asked__c = THIS_YEAR AND  Status__c <> 'Approved' AND Status__c <> 'Declined' 
                               GROUP BY contact__c] ){
       cstatusmap.put((ID)ag1.get('contact__c'),(Integer)ag1.get('expr0')); 
                                   
                    }
        
    
    list<contact>conlist = new list<contact>();
    
    for(id con :contactID){                          
        contact cnt = new contact();                   
             cnt.id=con;                                  
        
            cnt.Total_Amount_For_Proposals_This_Year__c	 = camtmap.get(con);
            cnt.Total_Number_Of_Proposals_This_Year__c = ccntmap.get(con);
           cnt.Total_Number_Of_Proposals_Open_This_Year__c = cstatusmap.get(con);        
                               system.debug(cstatusmap.get(con));
        conlist.add(cnt);       
         system.debug(conlist);
    }
   
    if(conlist.size()>0)
        update conlist;
        }
        
    }
}
                
    
    if(Trigger.isAfter && Trigger.isdelete){
        
        for(Proposal__c p : Trigger.old){
             if(p.Account__c<>null)
            accountId.add(p.Account__c); 
               
            campaignId.add(p.Campaign__c); 
             if(p.contact__c<>null)
            contactID.add(p.contact__c); 
            system.debug(p.contact__c);
             dateaskedyear.add(p.DateAskedYear__c); 
                 
            
                }
                                     
                for(AggregateResult agr : [select count(Id),sum(Amount_Asked__c),account__c,campaign__c,contact__c,dateaskedyear1__c from proposal__c GROUP BY account__c,campaign__c,contact__c,dateaskedyear1__c having (account__c <>''
                                       AND campaign__c <> '' AND dateaskedyear1__c !=null AND dateaskedyear1__c=:dateaskedyear AND Account__c =:accountId AND Campaign__c =:campaignId) OR (contact__c <>''
                                       AND campaign__c <> '' AND dateaskedyear1__c !=null AND contact__c =:contactID AND dateaskedyear1__c=:dateaskedyear AND Campaign__c =:campaignId)]){
                                           Map<id,integer> campwithCount = new Map<id,integer>();
                                           amounts.put((Id)agr.get('account__c'),(decimal)agr.get('expr1'));
                                            amounts.put((Id)agr.get('contact__c'),(decimal)agr.get('expr1'));
                                           campwithCount.put((Id)agr.get('campaign__c'),(Integer)agr.get('expr0'));
                                           rollupRes.put((Id)agr.get('account__c'),campwithCount);
                                            rollupRes.put((Id)agr.get('contact__c'),campwithCount);
                                           system.debug(campwithCount);
                                           system.debug(rollupRes);
                                       }
        
        
        for(Proposal__c p : Trigger.old){
            if(rollupRes.size()>0)
            {
                
            list<proposal__c> plist=new list<proposal__c>();
            list<proposal__c> proplist=[select id,Total_Amount_Asked__c,Account__c,contact__c,Campaign__c,Total_Number_Of_Proposals1__c,dateaskedyear1__c from Proposal__c where (Account__c =:accountId AND Campaign__c =:campaignId AND dateaskedyear1__c=:dateaskedyear  AND account__c <>'' AND campaign__c <> '' AND dateaskedyear1__c <>'')
                                       OR (contact__c =:contactID AND Campaign__c =:campaignId AND dateaskedyear1__c=:dateaskedyear AND contact__c <>'' AND campaign__c <> '' AND dateaskedyear1__c <>'')];
            for(Proposal__c p1 : proplist){
                system.debug(Amounts.get(p.Account__c));
                system.debug(rollupRes.get(p.account__c));
                
                Proposal__c pp = new Proposal__c(id=p1.Id,Total_Amount_Asked__c=Amounts.get(p1.Account__c),Total_Number_Of_Proposals1__c=rollupRes.get(p1.account__c).get(p1.campaign__c));
                plist.add(pp);
            } 
            if(plist.size()>0)
                update plist;   
            }
            
        } 
             
                 
        
    
              //add  
          if(accountId.size()>0){
                map<id,double> pamtmap = new map<id,double>();
                map<id,Integer> pcntmap= new map<id,Integer>();
                map<id,Integer> pstatusmap= new map<id,Integer>();
                       
                 map<id,double> amtmap = new map<id,double>();
                map<id,Integer> cntmap= new map<id,Integer>();
                map<id,Integer> statusmap= new map<id,Integer>();
                       
                               for(aggregateresult pag : [select account__c,count(Id),sum(Amount_Asked__c) from Proposal__c where account__c IN :accountId AND  Date_Asked__c = LAST_YEAR GROUP BY account__c ] )
                                        {
                    pamtmap.put((ID)pag.get('account__c'), (double)pag.get('expr1'));
                    pcntmap.put((ID)pag.get('account__c'), (Integer)pag.get('expr0'));
                                             system.debug(pag);
                }
                
                for(aggregateresult pag1 : [select account__c,count(Id) from Proposal__c where account__c IN :accountId AND Date_Asked__c = LAST_YEAR AND Status__c <> 'Approved' AND Status__c <> 'Declined' 
                                           GROUP BY account__c] ){
                                               pstatusmap.put((ID)pag1.get('account__c'),(Integer)pag1.get('expr0')); 
                                               
                                           }
                          list<account>pacclist = new list<account>();
                
                for(id acc :accountId){
                    account acnt = new account();
                    acnt.id=acc;
                    
                    acnt.Total_Amount_For_Proposals__c = pamtmap.get(acc);
                    acnt.Total_Number_Of_Proposals__c = pcntmap.get(acc);
                    acnt.Total_Proposals_Open_Previous_Year__c = pstatusmap.get(acc);        
                    system.debug(pstatusmap.get(acc));
                    pacclist.add(acnt);       
                }
                
                if(pacclist.size()>0){
                   update pacclist;
                } 

                
                for(aggregateresult ag : [select account__c,count(Id),sum(Amount_Asked__c) from Proposal__c where account__c IN :accountId AND  Date_Asked__c = THIS_YEAR GROUP BY account__c
                                         ] ){
                    amtmap.put((ID)ag.get('account__c'), (double)ag.get('expr1'));
                    cntmap.put((ID)ag.get('account__c'), (Integer)ag.get('expr0'));
                }
                
                for(aggregateresult ag1 : [select account__c,count(Id) from Proposal__c where account__c IN :accountId AND  Date_Asked__c = THIS_YEAR AND Status__c <> 'Approved' AND Status__c <> 'Declined' 
                                           GROUP BY account__c ] ){
                                               statusmap.put((ID)ag1.get('account__c'),(Integer)ag1.get('expr0')); 
                                               
                                           }
                
                
                
                list<account>acclist = new list<account>();
                
                for(id acc :accountId){
                    account acnt = new account();
                    acnt.id=acc;
                    
                    acnt.Total_Amount_For_Proposals_This_Year__c = amtmap.get(acc);
                    acnt.Total_Number_Of_Proposals_This_Year__c = cntmap.get(acc);
                    acnt.Total_Number_Of_Proposals_Open_This_Year__c = statusmap.get(acc);        
                    system.debug(statusmap.get(acc));
                    acclist.add(acnt);       
                }
                
                if(acclist.size()>0){
                   update acclist;
                } 

        //here    
        }
         
         else if(contactID.size()>0){
            //add
               map<id,double> pamtmap = new map<id,double>();
                map<id,Integer> pcntmap= new map<id,Integer>();
                map<id,Integer> pstatusmap= new map<id,Integer>();
            
              map<id,double> camtmap = new map<id,double>();
             map<id,Integer> ccntmap= new map<id,Integer>();
             map<id,Integer> cstatusmap= new map<id,Integer>();
    
            
            
             for(aggregateresult pag : [select contact__c,count(Id),sum(Amount_Asked__c) from Proposal__c where contact__c IN :contactID AND  Date_Asked__c = LAST_YEAR GROUP BY contact__c
                                  ] ){
        pamtmap.put((ID)pag.get('contact__c'), (double)pag.get('expr1'));
        pcntmap.put((ID)pag.get('contact__c'), (Integer)pag.get('expr0'));
    }
    
   for(aggregateresult pag1 : [select contact__c,count(Id) from Proposal__c where contact__c IN :contactID AND  Date_Asked__c = LAST_YEAR AND Status__c <> 'Approved' AND Status__c <> 'Declined' 
                               GROUP BY contact__c] ){
       pstatusmap.put((ID)pag1.get('contact__c'),(Integer)pag1.get('expr0')); 
                                   
                    }
        
    
    list<contact>conlist1 = new list<contact>();
    
    for(id con :contactID){
        contact cnt = new contact();
             cnt.id=con;
        
            cnt.Total_Amount_For_Proposals_Previous_Year__c = pamtmap.get(con);
            cnt.Total_Number_Of_Proposals_Previous_Year__c = pcntmap.get(con);
           cnt.Total_Proposals_Open_Previous_Year__c = pstatusmap.get(con);        
                               system.debug(pstatusmap.get(con));
        conlist1.add(cnt);       
         system.debug(conlist1);
    }
   
    if(conlist1.size()>0)
        update conlist1;
            
    
     for(aggregateresult ag : [select contact__c,count(Id),sum(Amount_Asked__c) from Proposal__c where contact__c IN :contactID AND  Date_Asked__c = THIS_YEAR GROUP BY contact__c
                             ] ){
        camtmap.put((ID)ag.get('contact__c'), (double)ag.get('expr1'));
        ccntmap.put((ID)ag.get('contact__c'), (Integer)ag.get('expr0'));
    }
    
   for(aggregateresult ag1 : [select contact__c,count(Id) from Proposal__c where contact__c IN :contactID AND  Date_Asked__c = THIS_YEAR AND  Status__c <> 'Approved' AND Status__c <> 'Declined' 
                               GROUP BY contact__c] ){
       cstatusmap.put((ID)ag1.get('contact__c'),(Integer)ag1.get('expr0')); 
                                   
                    }
        
        
    
    list<contact>conlist = new list<contact>();
    
    for(id con :contactId){                          
        contact cnt = new contact();                   
             cnt.id=con;                                  
        
            cnt.Total_Amount_For_Proposals_This_Year__c	 = camtmap.get(con);
            cnt.Total_Number_Of_Proposals_This_Year__c = ccntmap.get(con);
           cnt.Total_Number_Of_Proposals_Open_This_Year__c = cstatusmap.get(con);        
                               system.debug(cstatusmap.get(con));
        conlist.add(cnt);       
         system.debug(conlist);
    }
   
    if(conlist.size()>0)
        update conlist;
        //here
    }
    }
    
    if(trigger.isundelete)
    {
       for(Proposal__c p : Trigger.new){
             if(p.Account__c<>null)
            accountId.add(p.Account__c); 
               
            campaignId.add(p.Campaign__c); 
             if(p.contact__c<>null)
            contactID.add(p.contact__c); 
            system.debug(p.contact__c);
             dateaskedyear.add(p.DateAskedYear__c); 
                 
            
                }
                                     
                for(AggregateResult agr : [select count(Id),sum(Amount_Asked__c),account__c,campaign__c,contact__c,dateaskedyear1__c from proposal__c GROUP BY account__c,campaign__c,contact__c,dateaskedyear1__c having (account__c <>''
                                       AND campaign__c <> '' AND dateaskedyear1__c !=null AND dateaskedyear1__c=:dateaskedyear AND Account__c =:accountId AND Campaign__c =:campaignId) OR (contact__c <>''
                                       AND campaign__c <> '' AND dateaskedyear1__c !=null AND dateaskedyear1__c=:dateaskedyear AND contact__c =:contactID AND Campaign__c =:campaignId)]){
                                           Map<id,integer> campwithCount = new Map<id,integer>();
                                           amounts.put((Id)agr.get('account__c'),(decimal)agr.get('expr1'));
                                            amounts.put((Id)agr.get('contact__c'),(decimal)agr.get('expr1'));
                                           campwithCount.put((Id)agr.get('campaign__c'),(Integer)agr.get('expr0'));
                                           rollupRes.put((Id)agr.get('account__c'),campwithCount);
                                            rollupRes.put((Id)agr.get('contact__c'),campwithCount);
                                           system.debug(campwithCount);
                                           system.debug(rollupRes);
                                       }
        
        
        for(Proposal__c p : Trigger.new){
            if(rollupRes.size()>0)
            {
                
            list<proposal__c> plist=new list<proposal__c>();
            list<proposal__c> proplist=[select id,Total_Amount_Asked__c,Account__c,contact__c,Campaign__c,Total_Number_Of_Proposals1__c,dateaskedyear1__c from Proposal__c where (Account__c =:accountId AND Campaign__c =:campaignId AND dateaskedyear1__c=:dateaskedyear  AND account__c <>'' AND campaign__c <> '' AND dateaskedyear1__c <>'')
                                       OR (contact__c =:contactID AND Campaign__c =:campaignId AND dateaskedyear1__c=:dateaskedyear AND contact__c <>'' AND campaign__c <> '' AND dateaskedyear1__c <>'')];
            for(Proposal__c p1 : proplist){
                system.debug(Amounts.get(p.Account__c));
                system.debug(rollupRes.get(p.account__c));
                
                Proposal__c pp = new Proposal__c(id=p1.Id,Total_Amount_Asked__c=Amounts.get(p1.Account__c),Total_Number_Of_Proposals1__c=rollupRes.get(p1.account__c).get(p1.campaign__c));
                plist.add(pp);
            } 
            if(plist.size()>0)
                update plist;   
            }
            
        } 
           
    }
}