public class AccountSearchController_Ideavate {

    public Account acc {set; get;} 
    public String msg {set; get;}
    public List<Account> accList {set;get;}
    public List<Account> accList2 {set;get;}
    public String accName {set; get;}
    public String accIndustry {set; get;}
    public ApexPages.StandardSetController setCont {set; get;}
    
    public AccountSearchController_Ideavate(ApexPages.StandardController controller) {
       System.debug('Controller '+ Account.Industry);
       acc = (Account)controller.getRecord();
       msg = '';
    }
    
    public void AccountSearchMethod(){
        try{
            accList = new List<Account>();
            accList2 = new List<Account>();
            accIndustry = Account.Industry + '';
            System.debug('Account Name '+acc.Name );
            System.debug(' Account Industry '+acc.Industry);
            accname = acc.name +'  -  '+acc.Industry;
            
            if(acc.name != null && acc.Industry != null){
                accList = [Select Id, name, Industry from Account where name = :acc.name AND Industry = :acc.Industry ];
                setCont = new ApexPages.StandardSetController([Select Id, name, Industry from Account where name = :acc.name AND Industry = :acc.Industry ]);
            }else if(acc.name != null && acc.Industry == null){
                accList = [Select Id, name, Industry from Account where name = :acc.name];
                setCont = new ApexPages.StandardSetController([Select Id, name, Industry from Account where name = :acc.name]);
            }else if(acc.name == null && acc.Industry != null){
                accList = [Select Id, name, Industry from Account where Industry = :acc.industry];
                setCont = new ApexPages.StandardSetController([Select Id, name, Industry from Account where Industry = :acc.industry]);
            }else if(acc.name == null && acc.Industry == null){
                accList = [Select Id, name, Industry from Account];
                setCont = new ApexPages.StandardSetController([Select Id, name, Industry from Account]);
            }
            msg = 'Data Retrived';
            ApexPages.Message m = new ApexPages.Message(ApexPages.Severity.INFO,msg);
            ApexPages.addMessage(m);
            //setCont = new ApexPages.StandardSetController(accList);  
            setCont.setPageSize(10);
            accList2.addAll((List<Account>)setCont.getRecords());
        //getaccList2(); 
        }catch(Exception e){
            System.debug('Error e '+e);
            msg = e.getMessage();
        }
    }
    
    public void Next(){
    accList2.clear();
        setCont.next();
         accList2.addAll((List<Account>)setCont.getRecords());
       
    }
}