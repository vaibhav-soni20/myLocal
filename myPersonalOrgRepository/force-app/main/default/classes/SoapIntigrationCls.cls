public class SoapIntigrationCls{
    //public String welcomemsg{get;set;}
  //  public String output{get;set;}
  //  public String search{get;set;}
    public string sessonid1{get;set;} 
   // public List<SoapAccountLST> resultlst{get;set;}
  //  Public List<Account> accList{get;set;}
  //  Public List<Account> accList2{get;set;}
  //  Public List<Cases> caseList{get;set;}
  //  public Integer searchResultsCount{get;set;}
    
    public SoapIntigrationCls(){
     //   searchResultsCount =0;
      //  caseList = new List<Cases>();
      //  accList = new List<Account>();
       // accList2 = new List<Account>();
        //resultlst = new List<SoapAccountLST>();
        //
          //partnerSoapSforceCom.Soap obj = new partnerSoapSforceCom.Soap();
          // partnerSoapSforceCom.LoginResult loginResult = obj.login('org@username.com', 'Password');
          //  obj.SessionHeader = new partnerSoapSforceCom.SessionHeader_element();
          //  obj.endpoint_x =loginResult.ServerUrl;
          //  obj.Sessionheader.sessionid = loginResult.sessionid;
        
        
         partnerSoapSforceCom.Soap stub = new partnerSoapSforceCom.Soap();
        System.debug('SOAP '+stub);
            partnerSoapSforceCom.LoginResult loginResult = stub.login('vaibhav@soni2.com','Ge@a1234$'+'fPk4wh1sfO4rM8BBlj8soWxly');
            stub.SessionHeader = new partnerSoapSforceCom.SessionHeader_element();
            stub.endpoint_x = loginResult.serverUrl;
            stub.SessionHeader.sessionId = loginResult.sessionId;
            sessonid1 =stub.SessionHeader.sessionId;
            accRecordMethod();
    }
    public PageReference accRecordMethod(){
           
        soapSforceComSchemasClassAccountpla.AccountPlan  sobj= new soapSforceComSchemasClassAccountpla.AccountPlan();
                
        soapSforceComSchemasClassAccountpla.SessionHeader_element ssid= new soapSforceComSchemasClassAccountpla.SessionHeader_element();
        ssid.sessionId=sessonid1; 
        sobj.SessionHeader = ssid;
        
       // Start Get Records  Through JSON 
       
        //System.debug('Json string:'+sobj.SearcDisplayRecords(search)); 
        System.debug('Json string:'+sobj.createAccountPlan()); 
        //System.debug('Get All account in json '+sobj.getAccounts());
       /*
        JSONParser parser = JSON.createParser(sobj.SearcDisplayRecords(search));
        while (parser.nextToken() != null) {
            // Start at the List of Accounts.
            if (parser.getCurrentToken() == JSONToken.START_ARRAY) {
                while (parser.nextToken() != null) {
                    // Advance to the start object marker to
                    //  find next Account  object.
                    if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
                        // Read entire Acc object, including its List of line items.
                        Account acc = (Account)parser.readValueAs(Account.class);
                        System.debug('acc values:'+acc.Cases);
                        accList.add(acc);
                        searchResultsCount =accList.size();
                       // for(Cases cs:acc.Cases){
                         //   caseList.add(cs);
                        //}
                        //Cases cs=(Cases)acc.Cases;
                        //System.debug('Cases object is:'+cs);
                        //caseList.addAll((Cases)acc.Cases);
                        System.debug('caseList is:'+caseList.size());
                        system.debug('Acc Namr Is: ' + acc.Name);
                        system.debug('Acc id is: ' + acc.Id);
                   
                    }
                }
            }
        }
*/  
     // End get records
            
       
    return null;
    }
   
}