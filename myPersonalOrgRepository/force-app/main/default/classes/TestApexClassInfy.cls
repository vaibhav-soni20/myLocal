public class TestApexClassInfy {
	public String name;
    public String ExpencesName {set;get;}
    public String CustomLabel {set;get;}
    
    public void setExpencesName(String ExpencesName){
        this.ExpencesName = ExpencesName;
    }
    public String getExpencesName(){
        return ExpencesName;
    }
    
    public TestApexClassInfy(){
        name = 'Iron Man';
    }
    public void getNameValue(){
        
        System.debug('ExpencesName  '+ExpencesName);
        System.debug('CustomLabel  '+CustomLabel);
        
    }
    
    
    
}