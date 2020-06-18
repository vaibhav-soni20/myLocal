public class LH_PaginationVFwithController {
    
    /*
<!-- 
Edited By Priya Ranjan
Date: 20th July, 2017
Description:- Added City column in order to solve jira issue 1061
-->
<apex:page id="Page" standardController="Business_Partner__c" extensions="LH_AddSalesAreaData" showHeader="false" sidebar="false">
    <html xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"> 
        <apex:stylesheet value="{!URLFOR($Resource.SLDS0122, 'assets/styles/salesforce-lightning-design-system-vf.css')}" />
        <head>   
            <title>Add Sales Area To Partner</title>
            <apex:stylesheet value="{!URLFOR($Resource.SLDS0122, 'assets/styles/salesforce-lightning-design-system-vf.css')}" />
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
            <link rel="stylesheet" href="//code.jquery.com/ui/1.12.0/themes/base/jquery-ui.css"/>
                <link rel="stylesheet" href="/resources/demos/style.css"/>
                    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
            <script src="https://code.jquery.com/ui/1.12.0/jquery-ui.js"></script>
            
            <script>
                $j = jQuery.noConflict();
            $j(document).ready(function(){               
                $j('input[type="checkbox"]').click(function(event) {
                    if (this.checked && $j('input:checked').length > 1) {
                        event.preventDefault();
                        alert('You\'re not allowed to choose more than 1 at a time');
                    }
                });
                $j(".saveComp").click(function(e){
                    if ($j('input:checked').length==0) {
                        event.preventDefault();
                        alert('You should choose atleast one business partner');
                    }
                    
                });
            }); 
            </script>
        </head>   
        <body> 
            <apex:form id="frm">
                
                <!--<apex:pageMessages ></apex:pageMessages> -->
                <!-- <apex:sectionHeader title="Add"  subtitle="{!parnterName}" />-->
                <div class="slds">    
                    <!-- PAGE HEADER -->
                    <div class="slds-page-header" role="banner">
                        <!-- LAYOUT GRID -->
                        <div class="slds-grid">
                            <!-- GRID COL -->
                            <div class="slds-col">
                                <!-- HEADING AREA -->
                                <div class="slds-button" id="saveAction1">
                                    <h1 class="slds-text-heading--medium">{!parnterName}</h1>
                                </div>
                                <!-- /HEADING AREA -->
                            </div>
                            <!-- GRID COL -->
                            <div class="slds-col slds-no-flex slds-align-middle">
                                <div class="slds-button-group" role="group">                               
                                    <apex:commandButton id="btnAdd" value="Add" action="{!SaveandSubmit}" styleClass="slds-button slds-button--neutral slds-m-top--medium saveComp"/> 
                                    <a href="/{!accountId}" class="slds-button slds-button--neutral slds-m-top--medium"> Cancel</a>
                                </div>
                                
                            </div>
                            <!-- / GRID COL -->
                        </div>
                        <!-- / LAYOUT GRID -->
                    </div>
                    <!-- / PAGE HEADER --> 
                    <apex:outputpanel id="details2">    
                        <!--<apex:commandButton value="First Page" rerender="details2" action="{!FirstPage}" disabled="{!prev}" status="searchStatus"/>-->
                        <div class="error" style="color:red;padding:10px;font-weight:bold;font-size:14px;"><apex:pageMessages ></apex:pageMessages></div>
                     
                        <apex:commandButton value="Previous" id="prev2" rerender="details2" action="{!previous}" disabled="{!prev}" status="searchStatus2" styleClass="slds-button slds-button--neutral slds-m-top--medium"/>
                        <apex:commandButton value="Next" rerender="details2,prev2,prev" action="{!next}" disabled="{!nxt}"  status="searchStatus2" styleClass="slds-button slds-button--neutral slds-m-top--medium"/>
                        
                        <!--<apex:actionstatus id="searchStatus2" starttext="Searching" />  -->
                        <apex:actionStatus id="searchStatus2">
                            <apex:facet name="start">
                                <div style="position: fixed; top: 0; left: 0; right: 0; bottom: 0; opacity: 0.25; z-index: 1000; background-color: black;">
                                    &nbsp;
                                </div>
                                <div style="position: fixed; left: 0; top: 0; bottom: 0; right: 0; z-index: 1001; margin: 15% 50%">
                                    <div style="display: inline-block; padding: 2px; background-color: #fff; width: 125px;">
                                        <img src="/img/loading.gif" style="float: left; margin: 8px;" />
                                        <span style="display: inline-block; padding: 10px 0px;">Please Wait...</span>
                                    </div>
                                </div>
                            </apex:facet>
                        </apex:actionStatus> 
                        
                        <div class="myapp" id="details" style="margin-top:10px !important;">
                            <table class="slds-table slds-table--bordered slds-table--cell-buffer" width="100%" id="details1">
                                <fieldset class="slds-box slds-theme--default slds-container--large">
                                    <legend id="newaccountform" class="slds-text-heading--small slds-p-vertical--large">Search {!parnterName}</legend>  
                                    <div class="slds-form-element">
                                        <div class="slds-grid">
                                            <div class="slds-col--padded slds-size--2-of-4">
                                                <label class="slds-form-element__label" for="accountName">Name:</label>
                                                <div class="slds-form-element__control">
                                                    <div class="slds-form-element__control">
                                                        <apex:inputText id="searchCompanyName" value="{!companyName}" styleclass="slds-input" />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="slds-col--padded slds-size--2-of-4">
                                                <label class="slds-form-element__label" for="accountName">CRM Company No:</label>
                                                <div class="slds-form-element__control">
                                                    <div class="slds-form-element__control">
                                                        <apex:inputText id="searchCRMCompanyNo" value="{!companyCRMNO}" styleclass="slds-input" />
                                                    </div>
                                                </div>
                                            </div>
                                            </div>
                                            <div class="slds-grid">
                                            <div class="slds-col--padded slds-size--2-of-4">
                                                <label class="slds-form-element__label" for="accountName">SAP No:</label>
                                                <div class="slds-form-element__control">
                                                    <div class="slds-form-element__control">
                                                        <apex:inputText id="searchSAPNo" value="{!companySAPNO}" styleclass="slds-input" />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="slds-col--padded slds-size--2-of-4">
                                                <label class="slds-form-element__label" for="accountName">CITY:</label>
                                                <div class="slds-form-element__control">
                                                    <div class="slds-form-element__control">
                                                        <apex:inputText id="searchCity" value="{!companyCity}" styleclass="slds-input" />
                                                    </div>
                                                </div>
                                            </div>
                                            </div>
                                            <div class="slds-col--padded slds-size--2-of-4">  
                                                <label class="slds-form-element__label" for="accountName"></label>
                                                <div class="slds-form-element__control">
                                                    <apex:commandButton value="Search" action="{!runSearch}" styleClass="slds-button slds-button--brand" reRender="frm" Style="Margin-top:20px;"/>
                                                    &nbsp;<apex:actionstatus id="searchStatuses" starttext="Searching" />
                                                </div>
                                            </div> 
                                        
                                    </div>
                                </fieldset>
                                <thead>
                                    <tr class="slds-text-heading--label">
                                        <th scope="col" title="Select">
                                            <div class="slds-truncate">Select</div>
                                        </th>
                                        <th scope="col" title="Sales Area Data">
                                            <div class="slds-truncate">{!parnterName}</div>
                                        </th>
                                          <!--added recordtype column: to fix : LHEF-1563 -->
                                    
                                        <th scope="col" title="Record Type">
                                            <div class="slds-truncate">Record Type</div>
                                        </th> 
                                        <th scope="col" title="CM Company">
                                            <div class="slds-truncate">CRM Company No</div>
                                        </th>
                                        <th scope="col" title="SAP NO">
                                            <div class="slds-truncate">SAP NO</div>
                                        </th>
                                         <th scope="col" title="CITY">
                                            <div class="slds-truncate">CITY</div>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    
                                    <apex:repeat value="{!Accountlist}" var="s" id="results">
                                        <tr>
                                            <td scope="row" data-label="Account Name" title="Cloudhub">
                                                <div class="slds-truncate">
                                                    <apex:inputCheckbox id="checkbox"  value="{!s.check}"/>
                                                </div>    
                                            </td >
                                            <td data-label="Account Name" title="Cloudhub">
                                                <div class="slds-truncate">
                                                    <apex:outputLink value="/{!s.accList.Id}">{!s.accList.Name}</apex:outputLink>
                                                </div>
                                            </td>
                                            <td data-label="Account Name" title="Cloudhub">
                                                <div class="slds-truncate">
                                                    <apex:outputtext value="{!s.accList.recordtype.name}"></apex:outputtext>
                                                </div>
                                            </td>
                                            
                                            <td data-label="Account Name" title="Cloudhub">
                                                <div class="slds-truncate">
                                                    <apex:outputtext value="{!s.accList.CRM_Company_No__c}"></apex:outputtext>
                                                </div>
                                            </td>
                                            <td data-label="Account Name" title="Cloudhub">
                                                <div class="slds-truncate">
                                                    <apex:outputtext value="{!s.accList.SAP_No__c}"></apex:outputtext>
                                                </div>
                                            </td>
                                            <td data-label="Account Name" title="Cloudhub">
                                                <div class="slds-truncate">
                                                    <apex:outputtext value="{!s.accList.City__c}"></apex:outputtext>
                                                </div>
                                            </td>
                                        </tr>    
                                    </apex:repeat> 
                                </tbody>
                                
                            </table>
                        </div>
                    </apex:outputpanel>      
                    <div class="slds-grid">
                        <!-- GRID COL -->
                        <div class="slds-col">
                            <!-- HEADING AREA -->
                            <div class="slds-button saveAction1" id="">
                                <!--<apex:commandButton value="First Page" rerender="details2" action="{!FirstPage}" disabled="{!prev}" status="searchStatus"/>-->
                                <apex:commandButton value="Previous" id="prev" rerender="details2" action="{!previous}" disabled="{!prev}" status="searchStatus" styleClass="slds-button slds-button--neutral slds-m-top--medium"/>
                                <apex:commandButton value="Next" rerender="details2,prev" action="{!next}" disabled="{!nxt}"  status="searchStatus" styleClass="slds-button slds-button--neutral slds-m-top--medium"/>
                                <!--<apex:commandButton value="Last Page" rerender="details2" action="{!LastPage}" disabled="{!nxt}" status="searchStatus"/>-->
                                <apex:actionStatus id="searchStatus">
                                    <apex:facet name="start">
                                        <div style="position: fixed; top: 0; left: 0; right: 0; bottom: 0; opacity: 0.25; z-index: 1000; background-color: black;">
                                            &nbsp;
                                        </div>
                                        <div style="position: fixed; left: 0; top: 0; bottom: 0; right: 0; z-index: 1001; margin: 15% 50%">
                                            <div style="display: inline-block; padding: 2px; background-color: #fff; width: 125px;">
                                                <img src="/img/loading.gif" style="float: left; margin: 8px;" />
                                                <span style="display: inline-block; padding: 10px 0px;">Please Wait...</span>
                                            </div>
                                        </div>
                                    </apex:facet>
                                </apex:actionStatus> 
                            </div>
                            <!-- /HEADING AREA -->
                        </div>
                        <!-- GRID COL -->
                        <div class="slds-col slds-no-flex slds-align-middle">
                            <div class="slds-button-group" role="group">                               
                                <apex:commandButton id="btnAdd1" value="Add" action="{!SaveandSubmit}" styleClass="slds-button slds-button--neutral slds-m-top--medium saveComp"/> 
                                <!--<a href="/001" class="slds-button slds-button--neutral slds-m-top--medium">Cancel</a>-->
                                <a href="/{!accountId}" class="slds-button slds-button--neutral slds-m-top--medium"> Cancel</a>
                                
                            </div>
                            
                        </div>
                        <!-- / GRID COL -->
                    </div>
                </div>
            </apex:form>
        </body>
    </html>
</apex:page>

*/
    
    /*


//description:- Querry CITY__c field from Account in order to resolve the jira issue Seri-1061

public with sharing class LH_AddSalesAreaData{
   // public Id contactId{get; set;}
   // Public String customerAccountName{get;set;}
    public Id accountId {get; set;}
    public Id billId {get; set;}
    public ID payId{get;set;}
    public ID shiptoId{get;set;}
    public String type {get; set;}
    public Id recordType {get; set;}
    public String parnterName {get; set;}
    public Business_Partner__c businessPartner{get;set;}
    public RecordType rT;
    public Boolean displaySA{get; set;}
    Public List<innerclass> IClist{get;set;}
    Public List<accountsinnerclass> Accountlist{get;set;}
    Public Map<Id,Sales_Area_Data__c> salesareadataofcompany{get;set;}
    public List<Account> accounts {get; set;}
    public  List<Business_Partner__c> BpList{get; set;}
    Public Id SaleAreaDatarecTypeId;
    Public Id BusinesPartnerrecTypeId;
    Public Id recTypeId_ship_to;
    Public Id recTypeId_bill_to;
    Public Id recTypeId_Payer;
    private integer totalRecs = 0;
    private integer OffsetSize = 0;
    private integer LimitSize= 50;
    
    private integer totalRecs1 = 0;
    private integer OffsetSize1 = 0;
    private integer LimitSize1= 50;
    
    public String userCountry,userProfile;
    public String companyName{get;set;}
    public String companyCRMNO{get;set;}
    public String companySAPNO{get;set;}
    public String companyCity{get;set;}
    public String soql {get;set;}
    public String soqlCount {get;set;}
    public user useCntry;
    Public Id bpid{get;set;}
    Public Id bpid1{get;set;}
    public Id SADRecid {get;set;}
    public String identifier;
    public Map<Id, List<SelectOption>> SalesOfficeMap {get;set;}
    public string rowNumber{get;set;}
    public string cancelButton{get;set;}
    public static id businesspartId;
    public id bprecid;
    public boolean isFreshSearch;
   
    
    public LH_AddSalesAreaData(ApexPages.StandardController controller) {
        BpList = new List<Business_Partner__c>();
        this.businessPartner = new Business_Partner__c ();
        accountId= ApexPages.currentPage().getParameters().get('accId');
        billId= ApexPages.currentPage().getParameters().get('billId');
        payId= ApexPages.currentPage().getParameters().get('payId');
        shiptoId =ApexPages.currentPage().getParameters().get('shiptoId');
        type= ApexPages.currentPage().getParameters().get('type');
        bpid=ApexPages.currentPage().getParameters().get('bpid');
        bprecid=ApexPages.currentPage().getParameters().get('bprecid');
        
        recordType  = ApexPages.currentPage().getParameters().get('recId');
        SADRecid= ApexPages.currentPage().getParameters().get('SADRecid');
        identifier=ApexPages.currentPage().getParameters().get('identifier');
        string IsSecondPage = ApexPages.currentPage().getParameters().get('secondPage');
        businessPartner.Company__c = accountId;
        isFreshSearch=true;
       
       
      if(IssecondPage== 'true'){ 
      
        if(identifier!='adding')
        {
                //System.debug('///////////////////////////////'+ bpid+accountId);
                 List<Business_Partner__c> bps=[select id,name,business_partner__c,company__c from business_partner__c where company__c =:accountId ];
                Set<Id> companies=new Set<Id>();
                for(Business_partner__c bp:bps)
                {
                companies.add(bp.company__c);
                }
               List<Sales_area_data__c> sads=[select id,sales_area__c,field1__c  from sales_area_data__c where company__c=:bpid and Field1__c=false];
                Set<Id> sales=new Set<Id>();
               for(Sales_area_data__c sad:sads)
               {
               sales.add(sad.sales_area__c);
               }
               system.debug('LH_AddSalesAreaData.LH_AddSalesAreaData ----> sales size' + sales.size()+ sales);
                salesareadataofcompany=new Map<Id,Sales_Area_Data__c>([Select Id,name,Sales_Area__c,Sales_Area__r.Company_Code__r.Name,
                                                              Sales_Area__r.Name from Sales_Area_Data__c where Company__c =: accountId and Field1__c=false and sales_area__c NOT in:sales]);
        }
        else
        {
              //   System.debug('************************');
               List<Business_Partner__c> bps=[select id,name,business_partner__c,company__c from business_partner__c where business_partner__c=:bpid];
                Set<Id> companies=new Set<Id>();
                for(Business_partner__c bp:bps)
                {
                companies.add(bp.company__c);
                }
                List<Sales_area_data__c> sads=[select id,sales_area__c,field1__c  from sales_area_data__c where company__c=:bpid and Field1__c=false];
                Set<Id> sales=new Set<Id>();
               for(Sales_area_data__c sad:sads)
               {
               sales.add(sad.sales_area__c);
               }
               system.debug('LH_AddSalesAreaData.LH_AddSalesAreaData ----> Companies : ' + companies);
               system.debug('LH_AddSalesAreaData.LH_AddSalesAreaData ----> sales : ' + sales);
               
                 salesareadataofcompany=new Map<Id,Sales_Area_Data__c>([Select Id,name,Sales_Area__c,Sales_Area__r.Company_Code__r.Name,
                                                              Sales_Area__r.Name from Sales_Area_Data__c where Company__c =: companies and Field1__c=false and sales_area__c NOT in:sales limit 1000]);
                                                              
              system.debug('salesareadataofcompany : ' + salesareadataofcompany);
        }
        
        SalesOfficeMap =  new Map<Id, List<SelectOption>>();
         Set<String> salesArea=new Set<String>();
          for(Sales_Area_Data__c s: salesareadataofcompany.Values()){
              salesArea.add(s.Sales_Area__c);
              
          }
         list<Sales_Area_Office__c > transport= [select id, Sales_Office__c,Sales_Area__c,Sales_Office__r.Name from Sales_Area_Office__c where  Sales_Area__c IN:salesArea order by Sales_Office__r.Name];                                                      
             for(String sa:salesArea)
              {
                  LIST<SelectOption> newList = new LIST<SelectOption>();
                  newList.add(new SelectOption('--None--','--None--'));
                  SalesOfficeMap.put(sa, newList);
               }
        for(Sales_Area_Office__c saOffice : transport){
                
               if(SalesOfficeMap.get(saOffice.Sales_Area__c) == NULL){
                    LIST<SelectOption> newList = new LIST<SelectOption>();
                     newList.add(new SelectOption('--None--','--None--'));
                     SelectOption so = new SelectOption(saOffice.Sales_Office__c,saOffice.Sales_Office__r.Name );
                newList.add(so);
                SalesOfficeMap.put(saOffice.Sales_Area__c, newList );
               }else{
                      LIST<SelectOption> oldList = SalesOfficeMap.get(saOffice.Sales_Area__c);
                SelectOption so = new SelectOption(saOffice.Sales_Office__c,saOffice.Sales_Office__r.Name );
                oldList.add(so);
               }
         }                                                         
        Integer cnt = 0;    
        IClist = new List<innerclass>();
        system.debug('LH_AddSalesAreaData.LH_AddSalesAreaData ----> sales area count:'+ salesareadataofcompany.Values().size());
             for(Sales_Area_Data__c s: salesareadataofcompany.Values()){
                 innerclass ic=new innerclass(s);
                 ic.SalesOffice= SalesOfficeMap.get(s.Sales_Area__c);
                 system.debug('LH_AddSalesAreaData.LH_AddSalesAreaData ----> ic list name '+s.Sales_Area__r.Name);
                 IClist.add(ic);
                 cnt++;
        }
        
        //**********For user Copuntry***************
        useCntry = LH_utils.getUserCountry();
        if(useCntry != null){
            CountryCurrencies__c cc = LH_utils.getCountryCurrency(useCntry.OpCo__c);
             if(!test.isRunningTest())
            userCountry = cc.Country_Code__c;
            userProfile = useCntry.Profile.name;  
        }
     }  
        
       // recTypeId_ship_to=LH_utils.getRecordTypeIds('Ship-To'+' '+useCntry.OpCo__c,'Ship-To');
       // recTypeId_bill_to =LH_utils.getRecordTypeIds('Bill-To Only'+' '+useCntry.OpCo__c,'Bill-To Only');
       // recTypeId_Payer =LH_utils.getRecordTypeIds('Payer Only'+' '+useCntry.OpCo__c,'Payer Only');
      
        Map<ID,Schema.RecordTypeInfo> accrt_Map = Account.sObjectType.getDescribe().getRecordTypeInfosById();        
        if(accrt_Map.get(recordType).getName().containsIgnoreCase('Ship')  ){    
            parnterName = 'Ship-To';
            cancelButton = 'Back to ShipTo';
            SaleAreaDatarecTypeId = Schema.SObjectType.Sales_Area_Data__c.getRecordTypeInfosByName().get('Ship-To Sales Area').getRecordTypeId();
            BusinesPartnerrecTypeId = Schema.SObjectType.Business_Partner__c.getRecordTypeInfosByName().get('Ship-To').getRecordTypeId();
            
        }else if(accrt_Map.get(recordType).getName().containsIgnoreCase('Bill-To')){
            parnterName = 'Bill-To';
            cancelButton = 'Back to Bill-To';
            SaleAreaDatarecTypeId = Schema.SObjectType.Sales_Area_Data__c.getRecordTypeInfosByName().get('Bill-To Sales Area').getRecordTypeId();
            BusinesPartnerrecTypeId = Schema.SObjectType.Business_Partner__c.getRecordTypeInfosByName().get('Bill-To').getRecordTypeId();
            
        }else if(accrt_Map.get(recordType).getName().containsIgnoreCase('Payer Only')){
            parnterName = 'Payer';
             cancelButton = 'Back to Payer';
            SaleAreaDatarecTypeId = Schema.SObjectType.Sales_Area_Data__c.getRecordTypeInfosByName().get('Payer Sales Area').getRecordTypeId();
            BusinesPartnerrecTypeId = Schema.SObjectType.Business_Partner__c.getRecordTypeInfosByName().get('Payer Only').getRecordTypeId();
            
        }
        system.debug('LH_AddSalesAreaData.LH_AddSalesAreaData ----> Is second Page value passed '+IssecondPage);
          if(IssecondPage==null){
           getAccounts(accountId,parnterName);}
    }
    
    public void getAccounts(String accountId,string parnterName ){    
            string tempInput;
             String Customer='%'+'Customer'+'%';
            if(parnterName=='Ship-To')
            tempInput='%Ship-To%';
            else if(parnterName=='Bill-To' || parnterName=='Payer')
            tempInput = '%' + parnterName+' '+'Only'+ '%';
            system.debug('LH_AddSalesAreaData.getAccounts ----> parter name '+parnterName+' '+tempInput );
            string partnerAsLike = '%'+parnterName+'%';
            Integer totalacc=0;
            
            if(parnterName=='Bill-To')
            {
              accounts = [Select Id, CRM_Company_No__c,CITY__c, SAP_No__c,Sort_field__c,Name,Address__c,recordtype.name from Account where Central_Deletion_flag__c != true and (RecordType.name like:tempInput OR ((company_type__c='Z001' OR company_type__c='Z008' OR Company_type__c='Z007') and( RecordType.name like:Customer))) and Field1__c=:false and id!=:accountId and
                    id not in (Select Business_Partner__c from Business_Partner__c where Company__c =: accountId and recordtype.name like:partnerAsLike )order by recordtype.name limit :LimitSize OFFSET :OffsetSize];
              
              totalacc = [Select count()  from Account where Central_Deletion_flag__c != true and (RecordType.name like:tempInput OR ((company_type__c='Z001' OR company_type__c='Z008' OR Company_type__c='Z007' ) and (RecordType.name like:Customer)))  and field1__c=false and id!=:accountId and
                    id not in (Select Business_Partner__c from Business_Partner__c where Company__c =: accountId and recordtype.name like:partnerAsLike ) limit 10000];
                   
           }  
           
           else if(parnterName=='Payer')
            {
              accounts = [Select Id, CRM_Company_No__c,CITY__c, SAP_No__c,Sort_field__c,Name,Address__c,recordtype.name from Account where Central_Deletion_flag__c != true and (RecordType.name like:tempInput OR ((company_type__c='Z001' OR company_type__c='Z008' OR Company_type__c='Z007') and( RecordType.name like:Customer))) and Field1__c=:false and id!=:accountId and
                    id not in (Select Business_Partner__c from Business_Partner__c where Company__c =: accountId and recordtype.name like:partnerAsLike )order by recordtype.name desc limit :LimitSize OFFSET :OffsetSize];
              
              totalacc = [Select count()  from Account where Central_Deletion_flag__c != true and (RecordType.name like:tempInput OR ((company_type__c='Z001' OR company_type__c='Z008' OR Company_type__c='Z007' ) and (RecordType.name like:Customer)))  and field1__c=false and id!=:accountId and
                    id not in (Select Business_Partner__c from Business_Partner__c where Company__c =: accountId and recordtype.name like:partnerAsLike ) limit 10000];
                   
           }  
           else if(parnterName=='Ship-To')
           {
             accounts = [Select Id, CRM_Company_No__c,CITY__c, SAP_No__c,Sort_field__c,Name,Address__c,recordtype.name from Account where Central_Deletion_flag__c != true and RecordType.name like:tempInput  and Field1__c=:false and
                    id not in (Select Business_Partner__c from Business_Partner__c where Company__c =: accountId and recordtype.name like:partnerAsLike ) order by recordtype.name desc limit :LimitSize OFFSET :OffsetSize];
                    
                    
             totalacc = [Select count() from Account where Central_Deletion_flag__c != true and RecordType.name like:tempInput and field1__c=false and 
                    id not in (Select Business_Partner__c from Business_Partner__c where Company__c =: accountId and recordtype.name like:partnerAsLike ) limit 10000];
                    
           }   
        
           
                 system.debug('LH_AddSalesAreaData.getAccounts ----> size '+accounts.size());   
              
            totalRecs = totalacc ; 
            Accountlist = new List<accountsinnerclass>();
           
            for(Account accts: accounts ){
                 accountsinnerclass ic=new accountsinnerclass(accts);
                 system.debug('LH_AddSalesAreaData.getAccounts ----> in for loop');
                 Accountlist.add(ic);
            }
                    
        } 
        
    public  PageReference SaveandSubmit(){
    
    Account currentAccount = new Account();
    currentAccount = [Select id, name, recordTypeId from Account Where id =:accountId ];
    Id prospectRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Prospect').getRecordTypeId();

    Boolean noCommonSA;
    List<Boolean> bpselected=new List<Boolean>();
    for(accountsinnerclass iclst: Accountlist){
    if(iclst.check == true){
    bpselected.add(true);
    }
    }
    if(bpselected.size()==0 || bpselected.size()>1)
    {
    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info,'Please choose one Business Partner'));
    return null;
    }
   // try 
    {    
    list<id> bpvalue=new list<id>();
            for(accountsinnerclass iclst: Accountlist){
                if(iclst.accList.Id!=null)
                    bpvalue.add(iclst.accList.Id);
            }
            list<business_partner__c> existingbps=[select id,name,business_partner__c,company__c,recordtypeid from business_partner__c where company__c=:accountId and business_partner__c=:bpvalue];
            set<string> existingPair=new set<string>();
            system.debug('LH_AddSalesAreaData.SaveandSubmit ----> existingbps values '+existingbps);
            for(business_partner__c bp:existingbps)
            {
                existingPair.add(bp.company__c+'_'+bp.business_partner__c+'_'+bp.recordtypeid);
                //system.debug('*********** '+bp.company__c+'_'+bp.business_partner__c+'_'+bp.recordtypeid);
            }  
            BpList = new list<business_partner__c>();
            for(accountsinnerclass iclst: Accountlist){
                if(iclst.check == true){
                    businesspartId =iclst.accList.Id;
                   // system.debug('@@@@@@@@@'+businesspartId );
                    Business_Partner__c bps = new Business_Partner__c();
                    bps.Business_Partner__c =  iclst.accList.Id;
                    bps.Company__c =  accountId;
                    bps.RecordTypeId = BusinesPartnerrecTypeId ;
                    if(!existingPair.isempty() && !existingPair.contains( bps.Company__c+'_'+ bps.Business_Partner__c+'_'+bps.RecordTypeId)){
                        system.debug('LH_AddSalesAreaData.SaveandSubmit ----> no duplication so inserting');
                        BpList.add(bps);
                        existingPair.add( bps.Company__c+'_'+ bps.Business_Partner__c+'_'+bps.RecordTypeId);
                        //system.debug('*********** '+bps.Company__c+'_'+ bps.Business_Partner__c+'_'+bps.RecordTypeId);
                    }
                    else
                    {
                        BpList.add(bps);
                        existingPair.add( bps.Company__c+'_'+ bps.Business_Partner__c+'_'+bps.RecordTypeId);
                    }
                    
                }
            }
            noCommonSA = saveCommonSalesArea(BpList[0].Business_Partner__c, BpList[0].Company__c);
               if(noCommonSA == true){
                System.Debug('Ther is common Sale Area----------------');
                Insert BpList;
                
                if(currentAccount.recordTypeId != prospectRecordTypeId ){
                       return  redirect();
                   }else{
                       
                        PageReference demoPage = new PageReference('/'+accountId ); 
                        demoPage.setRedirect(true);
                        return demoPage; 
                   
                   }             
                 
            }
        else if(noCommonSA == false){
                System.Debug('Ther is no common Sale Area hence entering here----------------');
                Insert BpList;
                
                if(currentAccount.recordTypeId != prospectRecordTypeId ){
                       return  redirect();
                   }
                else{
                       
                        PageReference demoPage = new PageReference('/'+accountId ); 
                        demoPage.setRedirect(true);
                        return demoPage; 
                   
                   } 
            
            }
            
        } 
       
        
        return null;
    }
    
    public Boolean saveCommonSalesArea(Id bP, Id CompBP){
        Map<String, Sales_Area_Data__c> comSAMap = new Map<String, Sales_Area_Data__c>();
        List<Sales_Area_Data__c> bpSA= [Select Id,Sales_Area__c, Sales_Area__r.Name from Sales_Area_Data__c where Company__c =:bP and Field1__c=false];
        List<Sales_Area_Data__c> companySA= [Select Id,Sales_Area__c, Sales_Area__r.Name from Sales_Area_Data__c where Company__c =:CompBP and Field1__c=false];
        
        boolean isCommonSA;
        isCommonSA = false;
        for(Sales_Area_Data__c companysaleArea : companySA){
             comSAMap.put(companysaleArea.Sales_Area__c, companysaleArea);
            System.debug('LH_AddSalesAreaData.saveCommonSalesArea ----> the sales area in the accounts are'+companysaleArea.Id);
        }
        
        if(bpSA.size() == 0){
             return false;
        }
        
        for(Sales_Area_Data__c bpsaleArea : bpSA){
            
            if(comSAMap.containsKey(bpsaleArea.Sales_Area__c)){
            System.debug('LH_AddSalesAreaData.saveCommonSalesArea ----> the sales area in the the particular business partner are '+bpsaleArea.Id);
                return true;
             }
        }
        
        return isCommonSA;
    }
    
    public void fetchSaleArea(){
        displaySA = true;
    }
    
    public PageReference runSearch() {
    //OffsetSize = 0;
    //LimitSize= 50;
    
        if(isFreshSearch)
        {    
         OffsetSize1 = 0;
        }
    
     string tempInput;
      String Customer='%'+'Customer'+'%';
            if(parnterName=='Ship-To')
            tempInput='%Ship-To%';
            else if(parnterName=='Bill-To' || parnterName=='Payer')
            tempInput = '%' + parnterName+' '+'Only'+ '%';
      Accountlist.clear();
      string partnerAsLike = '%'+parnterName+'%';
      
      soql = 'Select Id,CITY__c,CRM_Company_No__c,SAP_No__c, Sort_field__c,Name,Address__c,recordtype.name from Account';
      
     if(parnterName=='Bill-To' || parnterName=='Payer'){
         soql += ' where (RecordType.name like:tempInput OR ((company_type__c=\'Z001\' OR Company_type__c=\'Z007\'  OR Company_type__c=\'Z008\')  AND (RecordType.name like:Customer))) and id!=\''+accountId+'\'';
     }
     else if(parnterName=='Ship-To')
     {
      soql += ' where RecordType.name like:tempInput';
     }
     
     soql += ' and Central_Deletion_flag__c=false';
     
      soql += ' and field1__c=false';
    If(!String.isBlank(companyName)) {
        soql += ' and Name LIKE \'%'+String.escapeSingleQuotes(companyName).replace('*','%')+'%\'';
    }
    If(!String.isBlank(companyCRMNO)) {
        soql += ' and CRM_Company_No__c LIKE \'%'+String.escapeSingleQuotes(companyCRMNO).replace('*','%')+'%\'';
    }

   If(!String.isBlank(companySAPNO)) {
        soql += ' and SAP_No__c LIKE \'%'+String.escapeSingleQuotes(companySAPNO).replace('*','%')+'%\'';

    }
    If(!String.isBlank(companyCity)) {
        soql += ' and CITY__c LIKE \'%'+String.escapeSingleQuotes(companyCity).replace('*','%')+'%\'';

    }
      soql += ' and id not in (Select Business_Partner__c from Business_Partner__c where recordtype.name like:partnerAsLike and Company__c =\''+accountId+'\' ) limit :LimitSize1 OFFSET :OffsetSize1'; 
      accounts = Database.query(soql);  
      
     
     if(parnterName=='Ship-To'){
              soqlCount  = 'Select count() from Account';
              soqlCount += ' where  RecordType.name like:tempInput ';
              If(!String.isBlank(companyName)) {
        soqlCount += ' and Name LIKE \'%'+String.escapeSingleQuotes(companyName).replace('*','%')+'%\'';
    }
    If(!String.isBlank(companyCRMNO)) {
        soqlCount += ' and CRM_Company_No__c LIKE \'%'+String.escapeSingleQuotes(companyCRMNO).replace('*','%')+'%\'';
    }

   If(!String.isBlank(companySAPNO)) {
        soqlCount += ' and SAP_No__c LIKE \'%'+String.escapeSingleQuotes(companySAPNO).replace('*','%')+'%\'';

    } 
    If(!String.isBlank(companyCity)) {
        soqlCount += ' and CITY__c LIKE \'%'+String.escapeSingleQuotes(companyCity).replace('*','%')+'%\'';

    }      // soqlCount  += 'and field1__c=false and (Name LIKE \'%'+String.escapeSingleQuotes(companyName).replace('*','%')+'%\' OR CRM_Company_No__c LIKE \'%'+String.escapeSingleQuotes(companyName).replace('*','%')+'%\' OR SAP_No__c LIKE \'%'+String.escapeSingleQuotes(companyName).replace('*','%')+'%\' )';
              soqlCount  += ' and id not in (Select Business_Partner__c from Business_Partner__c where recordtype.name like:partnerAsLike and Company__c =\''+accountId+'\') limit :LimitSize OFFSET :OffsetSize1'; 
      }
      else if(parnterName=='Bill-To' || parnterName=='Payer'){
          soqlCount  = 'Select count() from Account';
          soqlCount += ' where  (RecordType.name like:tempInput OR ((company_type__c=\'Z001\' OR Company_type__c=\'Z007\'  OR Company_type__c=\'Z008\' ) AND (RecordType.name like:Customer))) and id!=\''+accountId+'\'';
          If(!String.isBlank(companyName)) {
        soqlCount += ' and Name LIKE \'%'+String.escapeSingleQuotes(companyName).replace('*','%')+'%\'';
    }
    If(!String.isBlank(companyCRMNO)) {
        soqlCount += ' and CRM_Company_No__c LIKE \'%'+String.escapeSingleQuotes(companyCRMNO).replace('*','%')+'%\'';
    }

   If(!String.isBlank(companySAPNO)) {
        soqlCount += ' and SAP_No__c LIKE \'%'+String.escapeSingleQuotes(companySAPNO).replace('*','%')+'%\'';

    }
    If(!String.isBlank(companyCity)) {
        soqlCount += ' and CITY__c LIKE \'%'+String.escapeSingleQuotes(companyCity).replace('*','%')+'%\'';

    }
    
          soqlCount  += ' and id not in (Select Business_Partner__c from Business_Partner__c where recordtype.name like:partnerAsLike and Company__c =\''+accountId+'\') limit :LimitSize OFFSET :OffsetSize1'; 
     
      
      }
      
      integer count= database.countQuery(soqlCount);
      totalRecs1 = count; 
      Accountlist = new List<accountsinnerclass>();
            for(Account accts: accounts ){
                 accountsinnerclass ic=new accountsinnerclass(accts);
                 Accountlist.add(ic);
            }
      isFreshSearch=true;      
      return null;
    }
    
    public PageReference redirect(){   
        //system.debug('********' + businesspartId );     
        PageReference demoPage = new PageReference('/apex/LH_AddSalesAreaDaTaPartner?type=fetchSA&accid='+accountId+'&bpid='+businesspartId +'&recid='+recordType+'&bprecid='+BusinesPartnerrecTypeId + '&secondPage=true'  );
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info, 'There is no common sales Area for this. Please Select any sales area'));
        demoPage.setRedirect(true);
        return demoPage;    }
    
    public PageReference cancel(){ 
        PageReference demoPage=null;
        demoPage = new PageReference('/'+bpid);
        demoPage.setRedirect(true);
            return demoPage;
    }
    
  
    Public PageReference runAdd(){
        
         list<business_partner__c> existingbps=[select id,name,business_partner__c,company__c,recordtypeid from business_partner__c where company__c=:accountId and business_partner__c=:bpid];
        set<string> existingPair=new set<string>();
        system.debug('LH_AddSalesAreaData.runAdd ----> existingbps values '+existingbps);
        for(business_partner__c bp:existingbps)
        {
            existingPair.add(bp.company__c+'_'+bp.business_partner__c+'_'+bp.recordtypeid);
            //system.debug('*********** '+bp.company__c+'_'+bp.business_partner__c+'_'+bp.recordtypeid);
        }
        Business_Partner__c bps = new Business_Partner__c();
        bps.Business_Partner__c =  bpid;
        bps.Company__c =  accountId;
        bps.RecordTypeId = bprecid;
        if(!existingPair.isempty() && !existingPair.contains(accountId+'_'+bpid+'_'+bprecid)){
            system.debug('LH_AddSalesAreaData.runAdd ----> no duplication so inserting');
            BpList.add(bps);
            existingPair.add(accountId+'_'+bpid+'_'+bprecid);
          //  system.debug('*********** '+accountId+'_'+bpid+'_'+bprecid);
            
        }
        else
        {
            BpList.add(bps);
            existingPair.add( bps.Company__c+'_'+ bps.Business_Partner__c+'_'+bps.RecordTypeId);
        }
        
     system.debug('LH_AddSalesAreaData.runAdd ----> enterring run add and record type value '+RecordType);
        List<Sales_Area_Data__c> sd = new List<Sales_Area_Data__c>();
        for(innerclass iclst: IClist){
             if(iclst.check == true){
                 Sales_Area_Data__c ic = new Sales_Area_Data__c();
                
                 ic.Sales_Area__c = iclst.sales.Sales_Area__c;
                 //system.debug('^^^^^^^^'+BpList[0].Business_Partner__c);
                 ic.Company__c = BpList[0].Business_Partner__c;
                 ic.RecordTypeId = SaleAreaDatarecTypeId;
                 ic.Field1__c=true;
                 if(useCntry.OpCo__c !=null){
                     if(useCntry.OpCo__c!='Central Western Europe')
                         ic.User_Country__c=useCntry.OpCo__c;
                     else if(useCntry.OpCo__c=='Central Western Europe')
                           {
                             if(useCntry.user_country__c=='CH') 
                                   ic.User_Country__c='Switzerland';
                             else if(useCntry.user_country__c=='IT')   
                                   ic.User_Country__c='Italy';
                             else if(useCntry.user_country__c=='HHR')
                                   ic.User_Country__c='Haut Rhin France';
                             else if(useCntry.user_country__c=='SGE')
                                   ic.User_Country__c='South & East Germany';
                           }
                       }
                   else
                        ic.User_Country__c='ALL';
                 //LH_utils.setCountryWiseDefaultValues(ic,userCountry,userProfile);
                 if(parnterName=='Ship-To')
                 {
                     if(iclst.SelectedSalesOffice=='--None--' ||  iclst.SelectedSalesGroup=='--None--')
                       {
                          ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info,'Please choose Sales office and Sales Group'));
                          return null;
                       }
                     ic.Sales_Office__c = iclst.SelectedSalesOffice;
                     ic.Sales_Group__c =  iclst.SelectedSalesGroup;
                 }
                 sd.add(ic);
                 system.debug('ic===='+ic);
             }
         }
        try { 
            system.debug('sd===='+sd);
            
             Insert BpList;
             insert sd;
            } catch (Exception e){
                ApexPages.addMessages(e);
                return null;
            }
            //standard page redirection code
         PageReference demoPage = null;
        
        // demoPage=new Pagereference('/apex/LH_NewSalesAreaDataShipToCommon1?AccId='+sd[0].Company__c +'&RecId='+sd[0].RecordTypeId+'&SalesArea='+sd[0].Sales_Area__c ); 
        
        
        // demoPage=new PageReference('/'+sd[0].id+'/e?').setRedirect(true);
         //demoPage.setRedirect(true);
           return new ApexPages.StandardController(sd[0]).edit();
          return demoPage;
    }
    
    
    Public PageReference CommonSAAdd()
    {
    // SaleAreaDatarecTypeId = Schema.SObjectType.Sales_Area_Data__c.getRecordTypeInfosByName().get('Ship-To Sales Area').getRecordTypeId();
      List<Sales_Area_Data__c> sd = new List<Sales_Area_Data__c>();
        for(innerclass iclst: IClist){
             if(iclst.check == true){
                 Sales_Area_Data__c ic = new Sales_Area_Data__c();
                  
                 ic.Sales_Area__c = iclst.sales.Sales_Area__c;
                 ic.Company__c = bpid;
                 ic.RecordTypeId = SaleAreaDatarecTypeId;
                 ic.Field1__c=true;
                 if(useCntry.OpCo__c !=null){
                   if(useCntry.OpCo__c!='Central Western Europe')
                        ic.User_Country__c=useCntry.OpCo__c;
                   else if(useCntry.OpCo__c=='Central Western Europe')
                      {
                          if(useCntry.user_country__c=='CH') 
                               ic.User_Country__c='Switzerland';
                          else if(useCntry.user_country__c=='IT')   
                               ic.User_Country__c='Italy';
                          else if(useCntry.user_country__c=='HHR')
                               ic.User_Country__c='Haut Rhin France';
                          else if(useCntry.user_country__c=='SGE')
                               ic.User_Country__c='South & East Germany';
                       system.debug('LH_AddSalesAreaData.CommonSAAdd ----> else if --->'+ic.User_Country__c);        
                    }
                    system.debug('LH_AddSalesAreaData.CommonSAAdd ----> if --->'+ic.User_Country__c);
                  }
      else
         ic.User_Country__c='ALL';
         system.debug('LH_AddSalesAreaData.CommonSAAdd ----> else --->'+ic.User_Country__c);
                 //LH_utils.setCountryWiseDefaultValues(ic,userCountry,userProfile);
               if(parnterName=='Ship-To')
                 {
                     if(iclst.SelectedSalesOffice=='--None--' ||  iclst.SelectedSalesGroup=='--None--')
                       {
                          ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info,'Please choose Sales office and Sales Group'));
                          return null;
                       }
                     ic.Sales_Office__c = iclst.SelectedSalesOffice;
                     ic.Sales_Group__c =  iclst.SelectedSalesGroup;
                 }
                 sd.add(ic);
             }
         }
        try { 
             
             Insert sd;
            } catch (Exception e){
                ApexPages.addMessages(e);
                return null;
            }
         PageReference demoPage = null;
         
        
         //demoPage=new Pagereference('/apex/LH_NewSalesAreaDataShipToCommon1?AccId='+sd[0].Company__c +'&RecId='+sd[0].RecordTypeId+'&SalesArea='+sd[0].Sales_Area__c ); 
         //demoPage=new PageReference('/'+sd[0].id+'/e?').setRedirect(true);
        // demoPage.setRedirect(true);
         return new ApexPages.StandardController(sd[0]).edit();
          system.debug('LH_AddSalesAreaData.CommonSAAdd ----> After Return from SAD eDit Page --->'+bpid);
        demoPage = new PageReference('/'+sd[0].Company__c); 
        system.debug('DemoPage --->'+demoPage);
        //demoPage.setRedirect(true);
       
         return demoPage;
    
    }
   public class innerclass
    {
        Public Boolean check{get;set;}
        public Sales_Area_Data__c sales{get;set;} 
        public List<SelectOption> SalesOffice{get;set;}
        public String SelectedSalesOffice{get;set;}
        public String SelectedSalesGroup{get;set;}
        public List<SelectOption> SalesGroup{get;set;}
        public innerclass(Sales_Area_Data__c  sa)
        {
            sales = sa;
            check = false;
              
        }
         
        public void updateMarketOptions() {
        System.debug('?????????ddd??'+SelectedSalesOffice+'77777777777777777777'+sales.id);
            SalesGroup = new list<SelectOption>();
            SalesGroup.add(new SelectOption('--None--','--None--'));
            for (Sales_Office_Group__c  cp : [
                    select id, Sales_Group__c, Sales_Group__r.Name 
                    from Sales_Office_Group__c where  Sales_Office__c=:SelectedSalesOffice 
                    order by Sales_Group__r.Name]) {
                SalesGroup.add(new SelectOption(cp.Sales_Group__c, cp.Sales_Group__r.Name));
            }
        }
    }
    
    public class accountsinnerclass
    {
        Public Boolean check{get;set;}
        public Account accList{get;set;} 
        public accountsinnerclass(Account sa)
        {
            accList = sa;
            check = false;
        }
    }
    
     public void   getSalesgroup(){
        System.Debug('Ther is common Sale Area----------------');
        set<string> options_set= new set<string>();
        list<SelectOption> salesgroupOptions = new list<SelectOption>();
        list<Sales_Office_Group__c> salesgroup= [select id, Sales_Group__c, Sales_Group__r.Name from Sales_Office_Group__c where  Sales_Office__c=:options_set order by Sales_Group__r.Name];
        salesgroupOptions.add(new SelectOption('--None--','--None--'));
        for(Sales_Office_Group__c t1:salesgroup){
            salesgroupOptions.add(new SelectOption(t1.Sales_Group__c, t1.Sales_Group__r.Name));
        }
        
    }
    
  //***********Functions for pagination***************
  // returns the first page of records
    public void FirstPage(){
        OffsetSize = 0;
        getAccounts(accountId,parnterName );
    }
    
    public void previous(){
        isFreshSearch=false;
        if(companyName!=''){
         OffsetSize1 = OffsetSize1 - LimitSize1;
          runSearch();
        }
        else{
        OffsetSize = OffsetSize - LimitSize;
        getAccounts(accountId,parnterName );
        }
    
    
        
    }
    
    public void next(){
         isFreshSearch=false;
        system.debug('*******' + companyName + OffsetSize +'-'+ LimitSize);
        if(companyName!=''){
         OffsetSize1 = OffsetSize1 + LimitSize1;
          runSearch();
        }
        else{
        OffsetSize = OffsetSize + LimitSize;
        getAccounts(accountId,parnterName );
        }
    }
    
    public void LastPage(){
        OffsetSize = totalrecs - math.mod(totalRecs,LimitSize);
        getAccounts(accountId,parnterName  );
    }
    
    public boolean getprev(){
        if(OffsetSize == 0 && OffsetSize1==0){
            return true;
        }
        else {
            return false;
        }
    }
    
    public boolean getnxt(){
        if(((OffsetSize + LimitSize) > totalRecs) && ((OffsetSize1 + LimitSize1) > totalRecs1)){
           return true;
        }
        else {
            return false;
        }
   }
}

*/

}