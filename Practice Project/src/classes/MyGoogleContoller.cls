public with sharing class MyGoogleContoller {
	public String ChartData{get;set;}
	
	public MyGoogleContoller()
	{
		Schema.DescribeFieldResult AccountSchema = Account.Type.getDescribe();
		List<Schema.PicklistEntry> SchemaEntry = AccountSchema.getPicklistValues();
 		List<ChartDataItem> items = new List<ChartDataItem>();
 		for(Schema.PicklistEntry pValue : SchemaEntry)
		 {
		    integer Count = [select count() from Account where Type = :pValue.getValue() limit 10000];
		    if (Count > 0)
		      items.add(new ChartDataItem(pValue.getValue()+ '-['+ Count.format() + ']' , Count.format()));
		 }
		
		 //Prepare the chart URL
		 String chartPath = 'http://chart.apis.google.com/chart?chs=600x200&cht=p3';
		 ChartData = chartPath +  getChartData(items);
		 
		 /*
		 for (i = 0; i < month; i++)
		{
			interest = amt * rate / 1200;
			result = result + interest;
			amt = amt + amt1;
		}
		*/
		 
		 Decimal dPrinciple = 100;
		 Decimal dRate = 0.06/12;
		 double temp = 0;
		 Error.DebugLog('*** dRate ****'+dRate);
		 Error.DebugLog('*** Added value per Months ***'+(2^2));
		 Double dd = 0.083;
		 temp = RaiseToPower(double.valueOf(1.09),dd);
		 Error.DebugLog('======== ==='+temp);
	}
	
	
	public static double RaiseToPower(double a, double b)
    {
        return Math.Exp(b * Math.Log(a));
    }
	
	private static decimal Pow(decimal base, decimal exponent)
	{
	    decimal result = base;
	    for (decimal iteration = 1; iteration < exponent; iteration += 1)
	    {
	        result *= base;
	    }
	
	    return result;
	}
	
	private String getChartData(List<ChartDataItem> items)
	{
	 String chd = ''; //23,34,56
	 String chl = ''; //Hello|World
	
	 for(ChartDataItem citem : items)
	 {
	    chd += citem.ItemValue + ',';
	    chl += citem.Label + '|';
	 }
	 //remove the last comma or pipe
	 chd = chd.substring(0, chd.length() -1);
	 chl = chl.substring(0, chl.length() -1);
	
	 String result = '&chd=t:' + chd + '&chl=' + chl;
	 return result;
	}
	
	public class ChartDataItem
	{
		 public String ItemValue
		 {
		  get;
		  set;
		 }
		
		 public String Label
		 {
		   get;
		   set;
		 }
		
		 public ChartDataItem(String Label, String Value)
		 {
		    this.Label = Label;
		    this.ItemValue = Value;
		 }
	}
}