@RestResource(urlMapping='/secureApexRest')
global with sharing class SecureApexRest {
    @HttpGet
    global static Contact doGet(){
        Id recordId = RestContext.request.params.get('id');
        Contact result;
        if (recordId == null){
            throw new FunctionalException('Id parameter is required');
        }
         List<Contact> results = new  List<Contact>();
        try{    
        	results = [SELECT id, Name, Secret_Key__c FROM Contact WHERE Id = :recordId];
        }catch(System.QueryException q){
            System.debug('Error in Queue');
        }
       if (!results.isEmpty()) {
                result = results[0];
            }
      
        return result;
    }
    public class FunctionalException extends Exception{}
   // public class SecurityException extends Exception{}
}