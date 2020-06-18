global class AccountBatch implements Database.Batchable<sObject> {
    Integer i;
    /*
        global final String Query;
        global final String Entity;
        global final String Field;
        global final String Value;
        
        global AccountBatch(String q, String e, String f, String v){
        
        Query=q; Entity=e; Field=f;Value=v;
        }
	*/
    
    global AccountBatch(){
        i=0;
    }
    
  	
    global Database.QueryLocator Start(Database.BatchableContext b){
        System.debug('Start() Get Called');
        return DataBase.getQueryLocator('Select id, name from Account where name like \'test Batch Account %\'');
    }
	

    global void execute(Database.BatchableContext bc, List<account> aList){
        try{
        List<Account> aList2 = new List<Account>();
        System.debug('Execute() get Callesd');
            
            //to delete record
            /*
             * 
             * 
             * 
            For(Account a: aList){
             aList2.add(a);
            }    
            List<DataBase.DeleteResult> s = DataBase.delete(aList2, false); 
           */
            
            //To insert record
             
        for(i=1;i<=5000;i++){
            
            account a = new Account();
            a.name = 'test Batch Account '+i;
            a.NumBIsBlank__c = i;
            aList2.add(a);
           }
       	insert(aList2);
        
        }catch(Exception e){
            System.debug('error in batch '+e);
        }
               
    }
	
    Global void finish(DataBase.BatchableContext bc){
        System.debug('Finish    ');
        AsyncApexJob a = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed,TotalJobItems, CreatedBy.Email FROM AsyncApexJob WHERE Id =:BC.getJobId()];

	   // Send an email to the Apex job's submitter notifying of job completion.

	   Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

	   String[] toAddresses = new String[] {a.CreatedBy.Email};

	   mail.setToAddresses(toAddresses);

	   mail.setSubject('Apex Sharing Recalculation ' + a.Status);

	   mail.setPlainTextBody
	   ('The batch Apex job processed ' + a.TotalJobItems +
	   ' batches with '+ a.NumberOfErrors + ' failures.');
	   Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
}
/*
global class AccountBatch implements Database.Batchable<sObject>{

   global final String Query;
   global final String Entity;
   global final String Field;
   global final String Value;

   global AccountBatch(String q, String e, String f, String v){

      Query=q; Entity=e; Field=f;Value=v;
   }

   global Database.QueryLocator start(Database.BatchableContext BC){
      return Database.getQueryLocator(query);
   }

   global void execute(Database.BatchableContext BC, List<sObject> scope){
     for(sobject s : scope){
     s.put(Field,Value); 
     }
     update scope;
    }

   global void finish(Database.BatchableContext BC){
   }
}*/