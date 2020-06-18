trigger TriggerToUpdateOpportunityRelatives on opportunity (before Update) {
    
    List<Account> accList = new List<Account>();
    List<OppLineItem__c> itemList = new List<OppLineItem__c>();
    TriggerToUpdateOpportunityHandler handler = new TriggerToUpdateOpportunityHandler();
    
    for(Opportunity opp : trigger.new){
        OppLineItem__c camp = new OppLineItem__c();
        Account acc = new Account();
        acc = handler.getParent(opp.AccountId);
        camp = handler.getFirstChild(opp.id);
        //acc = [Select id, name from Account Where id = :opp.AccountId];
        //camp = [Select id, name__c, Opportunity__c from OppLineItem__c Where Opportunity__c = :opp.Id limit 1 ];
        
        acc.name =  acc.name+' Update parent by Vaibhav';
        camp.name__c = camp.name__c + ' Update Child by Vaibhav';
        accList.add(acc);
        itemList.add(camp);
        
       
        System.debug('Hakuna Matata'); 
    }
    //update accList;
    //update itemList;
     handler.updateParent(accList);
        handler.updateChild(itemList);
        
}