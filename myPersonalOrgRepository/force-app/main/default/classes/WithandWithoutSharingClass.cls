public without Sharing class WithandWithoutSharingClass {
    public List<Vehicle__c> vehicleList {set;get;}
    public WithandWithoutSharingClass(){
        
        WithandWithoutSharingClass.showVehicle();
        vehicleList = [Select id, name from Vehicle__c];
        
    } 
    
    
    public static void showVehicle(){
        User u = new User();
        u = [Select id, name from User where name = 'Soni'];
        
            System.debug(Userinfo.getUserName()+'  By Admin profile '+[Select id, name from Vehicle__c]);
       
       
    }
}