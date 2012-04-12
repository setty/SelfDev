global class DynamicApexTrial 
{
	public static void getObjects()
	{
	   Map<String, Schema.Sobjecttype> SobjectMap = Schema.getGlobalDescribe();
	   
	   Integer intCount = 1;
	   List<String> KeyList = new List<String>();
	   List<String> SObjectNameList = new List<String>();
	   Map<Integer, List<String>> ObjProcessingBatchMap = new Map<Integer, List<String>>();
	   
	   KeyList.addAll(SobjectMap.keySet());
	   for(Integer intIndex = 0; intIndex < KeyList.size(); intIndex++)
	   {
	   	 SObjectNameList.add(KeyList.get(intIndex));
	   	 if(Math.mod(SObjectNameList.size(), 50) == 0 || intIndex == KeyList.size() - 1)	
	 	 {
	 	 	ObjProcessingBatchMap.put(intCount, SObjectNameList);
	 	 	++intCount;
	 	 	SObjectNameList.clear();
	 	 } 	
	   }
	   System.debug('############Selected Object Count: ' + ObjProcessingBatchMap.size());
	   
	   for(Integer intIndex : ObjProcessingBatchMap.keySet())
	   {
	   	 if(ObjProcessingBatchMap.containsKey(intIndex))
	   	 {
	   	 	System.debug('############Processed Object Count: ' + intIndex);
	   	 	getFieldsTest(ObjProcessingBatchMap.get(intIndex));
	   	 } 
	   }
	}

	@future
	global static void getFieldsTest(List<String> pSObjectNameList)
	{
		Map<String, Schema.Sobjecttype> SobjectMap = Schema.getGlobalDescribe();
		
		for(String strObjName : pSObjectNameList)
		{
			System.debug('################Object Name: ' + strObjName);
	 		Schema.DescribeSObjectResult descr =  SobjectMap.get(strObjName.toLowerCase()).getDescribe();
	 				
			Map<String, Schema.SObjectField> fields = descr.fields.getMap(); 
			for (String fieldName : fields.keySet())
			{
				Schema.Sobjectfield field = fields.get(fieldName); 
				Schema.Describefieldresult fldResult = field.getDescribe();
				System.debug('################Field Name: ' + fldResult.getName() +  ' #######Datatype: ' + fldResult.getType());
			}	
		}
	}

}//Class