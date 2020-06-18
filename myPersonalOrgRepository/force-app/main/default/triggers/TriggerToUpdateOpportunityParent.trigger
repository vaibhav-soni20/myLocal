trigger TriggerToUpdateOpportunityParent on opportunity(before insert, before Update) {
    Opportunity opp = new Opportunity();
    OppLineItem__c camp = new OppLineItem__c();
    Account acc = new Account();
    
    opp = [Select id, name, AccountId from Opportunity where id = :trigger.new[0].id];
    acc = [Select id, name from Account Where id = :opp.AccountId];
    camp = [Select id, name__c, Opportunity__c from OppLineItem__c Where Opportunity__c = :opp.Id limit 1 ];
    
    acc.name =  acc.name+' Update parent by Vaibhav';
    camp.name__c = camp.name__c + ' Update Child by Vaibhav';
    update acc;
    update  camp;
    
    System.debug('Hakuna Matata');
}