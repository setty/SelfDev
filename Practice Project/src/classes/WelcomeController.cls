global with sharing class WelcomeController 
{
	@RemoteAction
 	global static List<account> getAccountsByName(String name){
  		List<account> account = [select id, Name from Account where name = :name];
  		return account;
 	}
}