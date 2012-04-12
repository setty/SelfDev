global with sharing class JavaScriptRemoting {

	@RemoteAction
	global static List<Account> getAccountByName(String name)
	{
		List<account> account = [select id, Name from Account where name =:name];
		Error.debuglog('account ==>'+account);
		return account;
	}
}