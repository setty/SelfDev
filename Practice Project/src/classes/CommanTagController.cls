public with sharing class CommanTagController 
{
	public Configuration__c objConfiguration {get;set;}
	
	public CommanTagController()
	{
		objConfiguration = Configuration__c.getInstance();
		Error.DebugLog('objConfiguration ==>'+objConfiguration);
	}
	
	// Google Map Information Url 
	//http://salesforce.phollaio.com/tag/script/page/3/
	
}