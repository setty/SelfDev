public with sharing class CommanTagPage{
	public Account acc{get;set;}
	
	public CommanTagPage (Apexpages.Standardcontroller stdContoller)
	{
		acc = (Account)stdContoller.getRecord();
	}
	
}