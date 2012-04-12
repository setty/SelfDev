public with sharing class facebookController 
{
	public Account objAccount {get;set;} //FacebookUserName__C,FacebookPassword__c
	
	public facebookController()
	{
		objAccount  = new Account();
	}
	
	public Pagereference Login()
	{
		objAccount.Description = 'Facebook patient';
		objAccount.Name ='Facebook User';
		
		System.debug('objAccount=======>'+objAccount);
		insert objAccount;
	  return null;
	}
}