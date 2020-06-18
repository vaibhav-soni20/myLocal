public class AccountRESTController{
   
    public static String searchtext {get; set;}
       
   // public List<Records> lst_Records{get; set;}
   // public List<caseRecords> lst_Case {get; set;}
    public List<Account> lst_Account {get; set;}

    //oauth
    public static JSONObject oauthLogin(String loginUri, String clientId, String clientSecret, String username, String password)
    {
        HttpRequest req = new HttpRequest();
//https://login.salesforce.com/services/oauth2/authorize
        req.setMethod('POST');
        //req.setEndpoint(loginUri+'/services/oauth2/token');
        req.setEndpoint('https://login.salesforce.com/services/oauth2/token');
        
        req.setBody('grant_type=password' +
            '&client_id=' + clientId +
            '&client_secret=' + clientSecret +
            '&username=' + EncodingUtil.urlEncode(username, 'UTF-8') +
            '&password=' + EncodingUtil.urlEncode('Ge@a1234$'+'fPk4wh1sfO4rM8BBlj8soWxly', 'UTF-8')+
            '&redirect_uri=https://van-dev-ed.my.salesforce.com/home/home.jsp' 
            
            );
   
        Http http = new Http();
 
        HTTPResponse res = http.send(req);
System.debug('Responce '+res);
        return new JSONObject(res.getBody());
    }
 //Rest API webservice 
 public void restTest() {
       JSONObject oauth = oauthLogin('https://login.salesforce.com',
            '3MVG9YDQS5WtC11qIxszIJvsm7aiby6wLRNm2Bpy3NGOW_3Y9UzfScOoqPxFWDxfM3SZhE7kHLvOZwd7Z3aez',
            '499771591623743023',
            'vaibhav@soni2.com',
            'Ge@a1234$'+'fPk4wh1sfO4rM8BBlj8soWxly');
            
            System.debug( 'Result before'+oauthLogin('http://login.salesforce.com',
            '3MVG9YDQS5WtC11qIxszIJvsm7aiby6wLRNm2Bpy3NGOW_3Y9UzfScOoqPxFWDxfM3SZhE7kHLvOZwd7Z3aez',
            '499771591623743023',
            'vaibhav@soni2.com',
            'Ge@a1234$'+'fPk4wh1sfO4rM8BBlj8soWxly'));
            
            /*
            String oauth = oauthLogin('https://login.salesforce.com',
            '3MVG9YDQS5WtC11qIxszIJvsm7aiby6wLRNm2Bpy3NGOW_3Y9UzfScOoqPxFWDxfM3SZhE7kHLvOZwd7Z3aez',
            '499771591623743023',
            'vaibhav@soni2.com',
            'Ge@a1234$'+'fPk4wh1sfO4rM8BBlj8soWxly');*/
            System.debug('Calling Oauth '+oauth );
           //searchtext = oauth;
        String accessToken = oauth.getValue('access_token').str,
     instanceUrl = oauth.getValue('instance_url').str;

        // Fetch records 
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        
        req.setEndpoint('https://ap5.salesforce.com/services/apexrest/fetchAccounts');
        req.setHeader('Authorization', 'OAuth '+accessToken);
       
        Http http = new Http();
 
        HTTPResponse res = http.send(req);

       System.debug('res.getBody()  '+res.getBody());        
       searchtext = res.getBody();
            
        // End of Fetch Records 
    }
    
  /* public void restTest() {
        JSONObject oauth = oauthLogin('https://login.salesforce.com',
            '3MVG9YDQS5WtC11qIxszIJvsm7aiby6wLRNm2Bpy3NGOW_3Y9UzfScOoqPxFWDxfM3SZhE7kHLvOZwd7Z3aez',
            '499771591623743023',
            'vaibhav@soni2.com',
            'Ge@a1234$');
            
            System.debug('Calling Oauth '+oauth );
           
        String accessToken = oauth.getValue('access_token').str,
               instanceUrl = oauth.getValue('instance_url').str;

        // Fetch records 
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        if(searchtext.contains(' '))
        {
              searchtext = searchtext.replaceAll(' ','%20');      //searchtext = searchtext.replaceAll('\\s+','%20');
        }
        req.setEndpoint(instanceUrl+'/services/apexrest/fetchAccounts?name='+searchtext);
        req.setHeader('Authorization', 'OAuth '+accessToken);
       
        Http http = new Http();
 
        HTTPResponse res = http.send(req);

        lst_Records = new List<Records>();
        lst_Case = new List<caseRecords>();
        lst_Account = new List<Account>();
       
        JSONParser parser = JSON.createParser(res.getBody());

        while (parser.nextToken() != null)
        {
            if (parser.getCurrentToken() == JSONToken.START_ARRAY)
            {
                while (parser.nextToken() != null)
                {                  
                    if (parser.getCurrentToken() == JSONToken.START_OBJECT)
                    {
                        Records objRecord = new Records();
                        CaseRecords objCaseRecord = new CaseRecords();
                        Account objAccount = new Account();
                        Case objCase = new Case();
                       
                        // Read entire account object.
                        Records rec = (Records)parser.readValueAs(Records.class);
                        if(rec.AccId != NULL)
                        {
                            objAccount.Id = rec.AccId;
                            objAccount.Name = rec.AccName;
                            objAccount.AccountNumber = rec.AccountNumber;
                            objAccount.Type = rec.AccType;
                            objAccount.Phone = rec.AccPhone;
                            objAccount.Website = rec.AccWebsite;
                            lst_Account.add(objAccount);
                        }
                                               
                        if(rec.CseId != NULL)
                        {
                            objCaseRecord.Id = rec.CseId;
                            objCaseRecord.CaseNumber = rec.CaseNumber;
                            objCaseRecord.Priority = rec.CsePriority;
                            objCaseRecord.Status = rec.CseStatus;
                            objCaseRecord.Subject = rec.CseSubject;
                            lst_Case.add(objCaseRecord);               
                        }
                        // For debugging purposes, serialize again to verify what was parsed.
                        String s = JSON.serialize(rec);
   
                        // Skip the child start array and start object markers.
                        parser.skipChildren();
                    }
                }
            }
        }       
        // End of Fetch Records 
    }
   
    public class Records
    {
        public String AccID{get; set;}
        public String AccName{get; set;}
        public String AccountNumber{get; set;}
        public String AccType{get;set;}
        public String AccPhone{get; set;}
        public String AccWebsite{get; set;}
       
        public String CseId{get; set;}
        public String CaseNumber{get; set;}
        public String CsePriority{get; set;}
        public String CseStatus{get;set;}
        public String CseSubject{get; set;}
    }   
public class caseRecords
    {
        public String Id{get; set;}
        public String CaseNumber{get; set;}
        public String Priority{get; set;}
        public String Status{get;set;}
        public String Subject{get; set;}
    }   */ 
}