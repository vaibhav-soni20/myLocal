Public class LH_CustomIterable{
/*global class LH_CustomIterable implements Iterator<Account>{ 
  
    public List<Account> accs {get; set;} 
    
    Integer i {get; set;}
    //---------------------------------------------------------------------------------------------
    
    List<String> RestrictedUserIds = new List<String>();
    //Select the user from restricted to generate Idoc on change of BP's from custom setting
    public void RestrictUser(){
        List <RestrictedUsersForBPBatch__c> RestrictedUser = [SELECT Id, Name, Valid_Till__c FROM RestrictedUsersForBPBatch__c WHERE RestrictedUsersForBPBatch__c.Valid_Till__c>: System.today() OR RestrictedUsersForBPBatch__c.Valid_Till__c=: System.today()];
        //Integer NoOfUsers = RestrictedUser.size();
        
        for(RestrictedUsersForBPBatch__c ru:RestrictedUser)
        {
            Id Uid = [Select Id, Name From user where Name =: ru.Name].Id;
            RestrictedUserIds.add(Uid);
            System.debug('Check1'+Uid);
            
        }
        //return RestrictedUserIds;
        
    }
    
    //---------------------------------------------------------------------------------------------
    Id integrationUser = [Select Id From User where name = 'Integration User'].Id;
    //For storing unique company id which are already added in the list
    Set<Id> uniqueAcc = new Set<Id>();
    
    public List<Account> fetchAllUpdatedAccounts(){ 
        
        //Calling the method to update the value of Restricted User Ids
        RestrictUser();
        //Checking the contents of RestrictedUderIds
        System.debug(RestrictedUserIds);
        accs = new List<Account>();
        Datetime interval;
        
        Id autoBillTo = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Bill-To Automatic').getRecordTypeId();
        Id autoPayer =  Schema.SObjectType.Account.getRecordTypeInfosByName().get('Payer Automatic').getRecordTypeId();
        
        List<AsyncApexJob> testSch = [SELECT ApexClassId,CompletedDate,CreatedDate,JobType,LastProcessed 
                                      FROM AsyncApexJob where JobType='BatchApex' 
                                      and (Status='Completed' or Status='Aborted' OR Status = 'Processing') 
                                      and ApexClassId IN (Select Id from ApexClass where Name = 'LH_sendBPToSAPBatchClass')
                                      order by CreatedDate desc limit 1];
        
        if(testSch.size() > 0)
            interval = testSch[0].CreatedDate; 
        else
            interval = DateTime.now().addDays(-1);
        
        //For business partner insert/update/delete
        List<Business_Partner__c> bpList = [Select Company__r.SAP_No__c,Business_Partner__r.name,Company__r.name, LastModifiedDate, CreatedDate,
                                            Business_Partner__r.CRM_Company_No__c,Company__r.id,Company__r.RecordType.name, company__r.SendToSAP__c, company__r.set_to_sync__c,
                                            Business_Partner__r.id,Business_Partner__r.SAP_No__c,Business_Partner__r.RecordType.name, company__r.opco__c 
                                            from Business_Partner__c where LastModifiedDate >:interval and Company__r.SAP_No__c != null 
                                            and LastModifiedById NOT IN: RestrictedUserIds and Business_Partner__c != null
                                            and Company__r.Company_Type__c NOT IN ('Z008','Z004','Z011') AND Company__r.Consider_for_interface_batch__c = true]; 
        System.debug('------bplist check----------'+bpList);
        System.debug('Bp List Size ' +bpList.size());
        for(Business_Partner__c bp:bplist){
            if(bp.Business_Partner__r.SAP_No__c != null && bp.Business_Partner__r.RecordTypeId != autoBillTo 
                   && bp.Business_Partner__r.RecordTypeId != autoPayer)
                {
                    Account a1 = new Account();
                    a1.Id = bp.Company__c;
                    accs.add(a1);
                    uniqueAcc.add(a1.Id); 
                } 
            }
        
        //For updation of any customer,ship-to,Bill-to and payer
        List<Account> accountList = [Select Id, Name, OpCo__c, RecordType.name, SendToSAP__c, set_to_sync__c, SAP_No__c from Account 
                                     where LastModifiedDate >:interval and SAP_No__c != null and field1__c = false and id not in:uniqueAcc 
                                     and Company_Type__c NOT IN ('Z008','Z004','Z011')
                                     and (LastModifiedById NOT IN: RestrictedUserIds OR (DAP_Number_Updated__c = true and LastModifiedById =: integrationUser)) AND Consider_for_interface_batch__c = true];
        System.debug(accountList+'------query------'+'Select Id,RecordType.name from Account where LastModifiedDate >:'+interval+' and SAP_No__c != null');
        
        for(Account acc: accountList){
            Account a = new Account();
            a.Id = acc.Id;
            accs.add(a);
            uniqueAcc.add(a.Id);
            
            System.debug('----- Updated Account ----'+a);
        }
        
        List<Sales_Area_Data__c> salesAreas = [Select Company__c,Company__r.RecordType.name,Company__r.Name,Company__r.SAP_No__c, Company__r.Opco__c, company__r.SendToSAP__c, company__r.set_to_sync__c
                                               from Sales_Area_Data__c where LastModifiedDate >:interval and field1__c = false and Company__r.SAP_No__c != null and Company__c not in: uniqueAcc 
                                               and LastModifiedById NOT IN: RestrictedUserIds and Company__r.Company_Type__c NOT IN ('Z008','Z004','Z011') AND Company__r.Consider_for_interface_batch__c = true];
        for(Sales_Area_Data__c sa:salesAreas){
            Account a = new Account();
            a.Id = sa.Company__c;
            accs.add(a);
            uniqueAcc.add(sa.Company__c);
            
            System.debug('-----Updated Sales_Area_Data__c ----'+a); 
        }
        
        //Fetching all company code data which are modified in last one hour
        List<Company_Code_Data__c> companyCodeData = [Select Account__r.SAP_No__c,Account__r.Name,Account__c,Account__r.RecordType.name, Account__r.Opco__c, Account__r.SendToSAP__c, Account__r.set_to_sync__c 
                                                      from Company_Code_Data__c where LastModifiedDate >:interval and Account__c not in: uniqueAcc and Account__r.SAP_No__c != null 
                                                      and LastModifiedById NOT IN: RestrictedUserIds and Account__r.Company_Type__c NOT IN ('Z008','Z004','Z011') AND Account__r.Consider_for_interface_batch__c = true];
        
        for(Company_Code_Data__c ccd:companyCodeData){    
            
            Account a = new Account();
            a.Id = ccd.Account__c;
            accs.add(a);
            uniqueAcc.add(ccd.Account__c);
            System.debug('-----Updated Company_Code_Data__c ----'+a);
        }
        
        //Fetch All Bank details Parent
        List<Bank_Details__c> bankData = [Select Account__c,Account__r.RecordType.name,Account__r.SAP_No__c,Account__r.Name, Account__r.Opco__c, Account__r.SendToSAP__c, Account__r.set_to_sync__c 
                                          from Bank_Details__c where LastModifiedDate >:interval and Account__c not in: uniqueAcc and Account__r.SAP_No__c != null 
                                          and Account__r.Company_Type__c NOT IN ('Z008','Z004','Z011')and LastModifiedById NOT IN: RestrictedUserIds AND Account__r.Consider_for_interface_batch__c = true];
        List<Account> blist = getBankDetails(bankData);
        if(blist.size() > 0)
            accs.addAll(blist);
        
        //For Tax Classification insert/Update
        Set<Id> sadSet = new Set<Id>();
        List<Tax_Classification__c> listTaxCl = [Select Id,Sales_Area_Data__r.Company__c,Sales_Area_Data__r.Company__r.RecordType.name,Sales_Area_Data__r.Company__r.Name,Sales_Area_Data__r.Company__r.SAP_No__c, Company__r.Opco__c, Company__r.SendToSAP__c, Company__r.set_to_sync__c from Tax_Classification__c where LastModifiedDate >:interval and Sales_Area_Data__r.Company__r.SAP_No__c != null and Sales_Area_Data__r.Company__c not in: uniqueAcc and LastModifiedById NOT IN: RestrictedUserIds AND Sales_Area_Data__r.Company__r.Consider_for_interface_batch__c = true];
        List<Account> taxlist = getTaxClassification(listTaxCl );
        if(taxlist.size() > 0)
            accs.addAll(taxlist);
        
        
        
        //Send Distance if it's updated
        List<Distance__c> distanceCompList = [Select Id,Company__c ,Company__r.RecordType.name,Company__r.Name,Company__r.SAP_No__c, Company__r.Opco__c, Company__r.SendToSAP__c, Company__r.set_to_sync__c 
                                              from Distance__c where LastModifiedDate >:interval and Company__r.SAP_No__c != null and Company__c not in: uniqueAcc 
                                              and Company__r.Company_Type__c NOT IN ('Z008','Z004','Z011') and LastModifiedById NOT IN: RestrictedUserIds And Company__r.Consider_for_interface_batch__c = true ];
        List<Account> distList = getDistance(distanceCompList);
        if(distList.size() > 0)
            accs.addAll(distList);
        System.debug('-----accs----'+accs);  
        System.debug('-----uniqueAcc---'+uniqueAcc);
        
        Set<Account> setScope = new Set<Account>(accs);
        List<Account> accountLst = new List<Account>(setScope );
        List<Account> finalAccList = new List<Account>();
        
        system.debug(accountLst + ' accountLst values');
        
        //Added for finding the records which needs Approval and not to send to the Batch Class
        User lstuserData =[Select id, name, Opco__c, user_country__c from User where id =:  UserInfo.getUserId()] ;
        
        List<Account> acclist = [Select Id, Sap_No__c, Opco__c, OpcoList__c, SendToSap__c, Set_To_Sync__c, RecordType.name from Account where Id IN: accountLst];
        
        List<Approval_Field_Criterias__c> ApprovalFieldCriteriaList = new List<Approval_Field_Criterias__c>();
        ApprovalFieldCriteriaList = [select id, name, Opco__c, Business_Partner_Category__c from Approval_Field_Criterias__c];
        system.debug('ApprovalFieldCriteriaList values '+ ApprovalFieldCriteriaList);
        
        Map<string,set<string>> ApprovalMap=new Map<string,set<string>>();
        
        for(Approval_Field_Criterias__c apprl:ApprovalFieldCriteriaList)
        {
            if(!ApprovalMap.containskey(apprl.opco__c))
            {
                set<string> bpTypeList=new set<string>();
                bpTypeList.add(apprl.Business_Partner_Category__c.substring(0,7));
                ApprovalMap.put(apprl.Opco__c,bpTypeList);
            }
            else
            {
                set<string> oldlist=ApprovalMap.get(apprl.Opco__c);
                oldlist.add(apprl.Business_Partner_Category__c.substring(0,7));
                ApprovalMap.put(apprl.Opco__c,oldlist);
            }       
        }
        system.debug('ApprovalMap structure '+ApprovalMap.size()+' '+ApprovalMap);
        
        for(Account acc : acclist){
            system.debug('in acc.OpCoList__c'+ acc.OpCoList__c + ' Values2 '+ acc.SendToSAP__c+ ' Values3 '+ acc.Set_To_Sync__c);
            
            //Finding the user opco from Opcos of Account
            List<string> Filters = new List<String>();
            if(String.isNotBlank(acc.opco__c)){
                Filters=acc.opco__c.split(',');                      
                system.debug(Filters+'.............filters');
            } 
            String OpcoAcc = '';        
            for(String str : Filters){
                if(str==lstuserData.user_country__c){
                    OpcoAcc = str;                 
                }
            } 
            System.debug(OpcoAcc +'....OpcoAcc Values');
            
            if(ApprovalMap.containskey(OpCoAcc)){
                system.debug('in if');
                set<string> SetToCompare=ApprovalMap.get(OpcoAcc); 
                
                String rectype=acc.RecordType.name.substring(0,7);                   
                system.debug(rectype + ' ' + SetToCompare );
                
                if(SetToCompare.contains(rectype)){
                    system.debug('contains');
                    if(acc.SendToSAP__c == TRUE && acc.Set_To_Sync__c == TRUE){
                        system.debug(SetToCompare + ' Values ' +rectype+ ' Values2 '+ acc.SendToSAP__c+ ' Values3 '+ acc.Set_To_Sync__c);
                        finalAccList.add(acc);
                    }
                }                                     
            }
            else{
                system.debug('in else');
                finalAccList.add(acc);
            }
        } 
        
        system.debug('finalAccList '+finalAccList);
        return finalAccList;
    }
    
    public List<Account> getDistance(List<Distance__c> distanceCompList)
    {    
        List<Account> ac = new List<Account>();
        for(Distance__c dist:distanceCompList){
            Account a = new Account();
            a.Id = dist.Company__c;
            ac.add(a);
            uniqueAcc.add(dist.Company__c);
        }
        return ac;
    }
    
    public List<Account> getBankDetails(List<Bank_Details__c> bankData){
        List<Account> ac = new List<Account>();
        for(Bank_Details__c ccd:bankData){
            Account a = new Account();
            a.Id = ccd.Account__c;
            ac.add(a);
            uniqueAcc.add(ccd.Account__c);
        }
        return ac;
    }
    
    public List<Account> getTaxClassification(List<Tax_Classification__c> listTaxCl){
        List<Account> ac = new List<Account>();
        for(Tax_Classification__c tcl:listTaxCl ){
            Account a = new Account();
            a.Id = tcl.Sales_Area_Data__r.Company__c;
            ac.add(a);
            uniqueAcc.add(tcl.Sales_Area_Data__r.Company__c);
        }
        return ac;
    }
    
    global boolean hasNext(){ 
        if(i >= accs.size()) {
            return false; 
        } else {
            return true; 
        }
    }    
    
    global Account next(){ 
        
        return null;
    }
    
}*/
    }