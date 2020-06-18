trigger TriggerOnAccount on Account (after update) {
    Account acc = new Account();
    System.debug('error '+trigger.old[0]);
    acc = [Select id, name from Account where id = :trigger.old[0].id];
    System.debug('error '+acc);
	acc.name = acc.Name+' add by trigger in after updt';
    if(TriggHandler.Count ==0  ){
    System.debug('Not contain going to update '+acc.name);
        TriggHandler.getCount();
        update acc;
        
    TriggHandler.getCount();
    }
}