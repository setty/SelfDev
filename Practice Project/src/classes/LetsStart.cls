public with sharing class LetsStart 
{
	public string Query{get;set;}
	
	public LetsStart()
	{
		Query = GetDynamiCQuery('Account');
	}
	
	public String GetDynamiCQuery(String sObjectName)
	{
		List<String> fields = new List<String>(); 
		String Query ='Select ';
		try
		{
			Map<string, schema.sobjecttype> MapGlobalResult = Schema.getGlobalDescribe();
			if(MapGlobalResult.keySet().contains(sObjectName.toLowerCase()))
			{
				Schema.Sobjecttype sType = MapGlobalResult.get(sObjectName);
				Schema.DescribeSObjectResult r = sType.getDescribe();
				Map<String,Schema.SObjectField> M = r.fields.getMap();
				for(String fieldName : M.keyset())
				{
					Schema.SObjectField field = M.get(fieldName);                                                      
                    Schema.DescribeFieldResult fieldDesc = field.getDescribe();
                    Query +=' ,'+fieldName.toLowerCase();
                    fields.add(fieldName.toLowerCase());
				}
				
				Error.DebugLog(' returned Query ==>'+Query);
			}
		}
		catch(Exception ex)
		{
			System.debug('Error in Lets Start ==>'+ex);
		}
		return Query;
	}
}