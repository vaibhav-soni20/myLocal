@istest(seeAllData = false)
public class TriggerToUpdateOpportunityTest {
    
     public static testMethod void getTestCoverage(){
         Account acc = new Account();
         acc.name = 'Parent Acc';
         insert acc;
         
        opportunity opp = new Opportunity();
        opp.name = 'OppTest 1';
        opp.StageName = 'Won';
        opp.CloseDate = Date.today();
        opp.AccountId = acc.Id;
        insert opp;
         
         OppLineItem__c lineItem = new OppLineItem__c();
         lineItem.name__c = 'Child 1 ';
         lineItem.Opportunity__c = opp.Id;
         insert lineItem;
        
         opp.Name = 'oppTest ';
         Test.startTest();
         update opp;
         Test.stopTest();
    }

}