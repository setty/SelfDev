/*
	Summary : Java Script Remoting comes from the summer 11 realse note.
	Note : 1. JavaScript Remoting function must be in the Global class
	 	   2. JavaScript function must be static one.
*/

public global with sharing class JavaScriptremoting2Controller 
{
	@RemoteAction
	static global List<Contact> getResultJSR(String strQuery)
	{
		if(strQuery != null && strQuery != '')
		{
			return Database.query('Select FirstName,LastName,Email From Contact'
						+'Where firstname Like\"'+'%'+strQuery+'%\''+
						'OR lastName LIKE \"'+'%'+strQuery+'%\'');
		}
		else
		{		return null;}
	
	}
}