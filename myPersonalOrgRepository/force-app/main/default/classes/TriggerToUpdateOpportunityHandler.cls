public class TriggerToUpdateOpportunityHandler {
    Public Account getParent(id parentId){
    	return [Select Id, name from Account where id = :parentId ];   
    }
    
    public void updateParent(list<Account> acc){
        update Acc;
    }
    
    public OppLineItem__c getFirstChild(id oppId){
       return [Select id, name__C ,opportunity__c from OppLineItem__c where opportunity__c = : oppId limit 1]; 
    }
    
    public void updateChild(List<OppLineItem__c> OppItem){
        update OppItem;
    }
        
}