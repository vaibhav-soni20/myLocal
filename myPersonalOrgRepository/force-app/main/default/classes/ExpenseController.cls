public with sharing class ExpenseController {
    @AuraEnabled
    public static List<Expense__c> getExpenses(){
        
        return [Select id, name, client__c, Amount__c, Date__c, reimbursed__C, createdDate from Expense__c];
    } 
    
    @AuraEnabled
    public static Expense__c saveExpense(Expense__c expense) {
        // Perform isUpdateable() check here
        upsert expense;
        return expense;
        
    }
    
}