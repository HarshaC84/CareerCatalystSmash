public class IconsForContact {
    public contact conrec {get;set;}
    public string accId {get;set;}
    public String contId {get;set;}
    public IconsForContact (ApexPages.StandardController controller){
        contId =controller.getRecord().id;

        system.debug('contId===='+contId);
        conrec= new contact();
        if(contId!=null){
 
        conrec= [Select id,name,Board_Committee__c,Donor__c,npsp__Do_Not_Contact__c,SMASH_Alum__c,Volunteer__c,Special_Handling__c,Need_to_qualify__c,Disqualified__c
                 from contact where id=:ApexPages.currentPage().getParameters().get('id')];
        system.debug('Id:'+conrec);
                        }}
                           }