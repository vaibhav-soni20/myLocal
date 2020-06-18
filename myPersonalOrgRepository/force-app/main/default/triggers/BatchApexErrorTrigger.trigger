trigger BatchApexErrorTrigger on BatchApexErrorEvent (after insert) {
    
    public List<BatchLeadConvertErrors__c> leadConvertErrList = new List<BatchLeadConvertErrors__c>();
    for(BatchApexErrorEvent errEvent : Trigger.new){
        BatchLeadConvertErrors__c leadConvertErrObj = new BatchLeadConvertErrors__c();
        leadConvertErrObj.AsyncApexJobId__c = errEvent.AsyncApexJobId;
        leadConvertErrObj.Records__c = errEvent.JobScope;
        leadConvertErrObj.StackTrace__c = errEvent.StackTrace;
        
        leadConvertErrList.add(leadConvertErrObj);
        
    }
    if(leadConvertErrList.size()>0){
		insert leadConvertErrList;
    }
}