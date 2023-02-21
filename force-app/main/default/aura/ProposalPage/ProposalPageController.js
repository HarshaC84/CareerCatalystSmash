({
    
     handleSuccess : function(component, event, helper) {
    var payload = event.getParams().response;
    var navService = component.find("navService");

    var pageReference = {
        type: 'standard__recordPage',
        attributes: {
            "recordId": payload.id,
            "objectApiName": "Proposal__c",
            "actionName": "view"
        }
    }
    event.preventDefault();
    navService.navigate(pageReference);  
    },
    
        
	savenew: function(cmp, event, helper) {
            
         var homeEvt = $A.get("e.force:navigateToObjectHome");
      homeEvt.setParams({
    "scope": "Proposal__c"
      });
     homeEvt.fire();

        
   },
   
    saveProposal: function(cmp, event, helper) {
        
         cmp.find("editForm").submit();
        
        
    },
    
    isRefreshed: function(component, event, helper) {

        location.reload();
        
        
    },
    
   onCancel : function(component, event) {
 
     var homeEvt = $A.get("e.force:navigateToObjectHome");
      homeEvt.setParams({
    "scope": "Proposal__c"
});
     homeEvt.fire();

}
})