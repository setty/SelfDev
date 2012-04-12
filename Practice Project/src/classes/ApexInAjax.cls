/*
	The AJAX toolkit includes built-in support for invoking Apex through anonymous blocks or public webService methods.
	To do so, include the following lines in your AJAX code:
	
	This is the first method of AJAX invoing APEX
*/
global with sharing class ApexInAjax 
{
	webService static ID makeContact(String lastName, Account a)
	{
		Contact c = new Contact(LastName = lastName, AccountId = a.Id);
		return c.id;
	}
}