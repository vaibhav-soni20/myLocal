public class FusionChartController {
    public List<Account> accList {set;get;}
    public List<FusionChartData> fusionList {set;get;}
    Public String fusionData {set; get;}
    public FusionChartController(){
        fusionList = new List<FusionChartData>();
        accList = new List<Account>(); 
        accList = [Select name, AnnualRevenue from Account where AnnualRevenue != null limit 2];
        
        for(Account acc : accList){
            FusionChartData fusion = new FusionChartData();
            fusion.value = acc.AnnualRevenue+'' ;
            fusion.label = acc.name ;
            fusionList.add(fusion);
        }
        fusionData = JSON.serialize(fusionList);
        System.debug(' json '+JSON.serialize(fusionList));

    }
    public void renderFusionChart(){
        fusionData = JSON.serialize(fusionList);
    }
    public Class FusionChartData{
        String value {set;get;}
        String label {set;get;}
        
        public FusionChartData(){
            label = '';
            value = '';
        }
    
    }

}