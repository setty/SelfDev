public with sharing class ActionFunctionVersionController {
	public String name{get;set;}
	public List<Account> lstAcccount{get;set;}
	
	public Pagereference getAccountsByName()
	{
		lstAcccount = [Select Name,Id from Account where Name =:name];
		Error.DebugLog('List ==>'+lstAcccount);
		return null;
	}
}