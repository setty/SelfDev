public with sharing class CutomSettingComponent 
{
	// Assesing Custome Component 
	public Configuration__c config 
	{
		get
		{
			if(config!= null)
			return config;
			else
			{	Error.DebugLog('Value not set');
				return null;
			}
				
		}
		set;
	}
	
	public CutomSettingComponent()
	{
		//Apexpages.currentPage().
		Error.DebugLog('Inside the component value of the custome setting ==>'+config);
	} 
}