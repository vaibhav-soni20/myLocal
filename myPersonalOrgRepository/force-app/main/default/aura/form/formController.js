({
    doInit : function(component, event, helper) {
        //Update expense counters
        helper.getExpenses(component);
    },//Delimiter for future code
    
    createExpense : function(component, event, helper){
        var amtField = component.find("Amount");
        var amt = amtField.get("v.value");
        if (isNaN(amt)||amt==''){
            amtField.set("v.errors", [{message:"Enter an expense amount."}]);
        }else{
            amtField.set("v.errors", null);
            var newExpense = component.get("v.newExpense");
            helper.createExpense(component, newExpense);
        }
    }
})