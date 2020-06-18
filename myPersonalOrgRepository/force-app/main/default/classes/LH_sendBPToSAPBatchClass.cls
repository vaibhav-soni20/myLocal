public class LH_sendBPToSAPBatchClass {
    /*

global class LH_sendBPToSAPBatchClass implements Database.batchable<Account>, Schedulable,Database.AllowsCallouts,Database.stateful{ 
    
    //batch class start method for fetching the Accounts
    List<Id> accList= new List<Id>();
    Map<Id,Account> mapAcc= new Map<Id,Account>();
    
    global Iterable<Account> start(Database.batchableContext info){     
        LH_CustomIterable c = new LH_CustomIterable();
        return c.fetchAllUpdatedAccounts(); 
    }
    
    //Process updated Accounts here     
    global void execute(Database.batchableContext info, List<Account> scope){ 
        
        //Sending to SAP all the accountid's according to the record type
        Set<Account> setScope = new Set<Account>(scope);
        List<Id> setId = new List<Id>();
        For(Account getId: setScope){
            setId.add(getId.id);
            
        }
        List<Sales_area_data__c> SADListToUpdate = new List<Sales_area_data__c>();
        List<Account> AccListToUpdate = new List<Account>();
        List<Account> accountList = [Select Id, Name, RecordType.name, SAP_No__c, DAP_Number_Updated__c,Consider_for_interface_batch__c
                                     from Account where id in: setId];
        
        for(Account bp:accountList){
            
            //Re-ordered so that the ship to ,bill to and payer goes first
            if(!mapAcc.containsKey(bp.Id))
            {
                if(bp.RecordType.name.contains('Ship-To')){
                    LH_InterfaceBPINCallingClass.CreateShipTO(bp.id);
                }
                
                else if(bp.RecordType.name.contains('Bill-To Only')){
                    LH_InterfaceBPINCallingClass.CreateBillTO(bp.id);
                }
                
                else if(bp.RecordType.name.contains('Payer Only') || bp.RecordType.name.contains('Competitor')){
                    LH_InterfaceBPINCallingClass.CreatePayer(bp.id);
                }
                
                else if(bp.RecordType.name.contains('Customer')){
                    LH_InterfaceBPINCallingClass.CreateCompany(bp.id);
                    //LH_InterfaceBPINCallingClass.SendtoSAp(bp.id);
                }
                mapAcc.put(bp.Id,bp);
                accList.add(bp.Id);
            }    
        }
        
        //to Make DAP number flag false after the customer is sent to SAP after DAP Number update. 
        for(Account acc:accountList){
            if(acc.DAP_Number_Updated__c){
                acc.DAP_Number_Updated__c = false;
                AccListToUpdate.add(acc);
            }
        }
        If(AccListToUpdate.size()>0)
            update AccListToUpdate;
        
        List<Sales_area_data__c> SADList = [Select Id, Synced_with_SAP__c from Sales_area_data__c 
                                     where Company__c in: accountList and field1__c=false and Synced_with_SAP__c = false];
        
        For(Sales_area_data__c SAD: SADList){
            SAD.Synced_with_SAP__c = true;
            SADListToUpdate.add(SAD);
        }
        If(SADListToUpdate.size()>0)
            update SADListToUpdate;
        System.debug('------Account list for Batch-----'+accList);
        System.debug('**********Account Map for Batch**********'+mapAcc); 
        
    } 
    
    //Finish method to send an email    
    global void finish(Database.batchableContext info){ 
        
        System.debug('Bachable Processed record '+accList);
        Set<Account> tempAccSet = new Set<Account>();
		List<Account> tempAccList = new List<Account>();
        
        For(Account acc : mapAcc.values()){
            if(acc.Consider_for_interface_batch__c == true){
                acc.Consider_for_interface_batch__c = false;
                tempAccSet.add(acc);
            }  
        }
        For(Account acc : tempAccSet){
        	tempAccList.add(acc);
        }
        update tempAccList;
        
        AsyncApexJob a = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed, TotalJobItems, CreatedBy.Email
                          FROM AsyncApexJob WHERE Id =: info.getJobId()];
    }
    
    
    //Schedulabe method
    global void execute(SchedulableContext sc) {
        LH_sendBPToSAPBatchClass myBatchObject = new LH_sendBPToSAPBatchClass(); 
        database.executebatch(myBatchObject,5);
    }
    
}

*/
    
    /*** to call
     * 
     LH_sendBPToSAPBatchClass  m = new LH_sendBPToSAPBatchClass();
String sch = '0 00 * * * ?';
system.schedule('BP Job', sch, m);

String sch1 = '0 15 * * * ?';
system.schedule('BP Job1', sch1, m);

String sch2 = '0 30 * * * ?';
system.schedule('BP Job2', sch2, m);

String sch3 = '0 45 * * * ?';
system.schedule('BP Job3', sch3, m);




*/

}