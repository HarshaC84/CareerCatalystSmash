public class Icons_Controoler {
    public account accrec {get;set;}
    public string accId {get;set;}
    public String contId {get;set;}
    public Icons_Controoler (ApexPages.StandardController controller){
        contId =controller.getRecord().id;        
        accrec= new account();
         if(contId!=null){
        accrec= [Select id,name,Do_Not_Contact__c,SMASH_Alum__c,HIPPA_Out_put__c,Active__c,RecordType.name,Volunteer__c,Special_Handling__c,Need_to_qualify__c,Disqualified__c 
                 from account where id=:ApexPages.currentPage().getParameters().get('id')];       
    }
    }}