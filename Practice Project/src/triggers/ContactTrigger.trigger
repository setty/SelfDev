trigger ContactTrigger on Contact (after update) 
{
	if(trigger.isAfter)
	{
		//DeleteContactRole();
	}
	
	public void DeleteContactRole()
	{
		 List<AccountContactRole> lstConRole = new List<AccountContactRole>();
		 Set<String> setConId = new Set<String>();
		 
		 for(Contact objCon : trigger.new)
		 {
		 	if(String.valueOf(objCon.status__c).equalsIgnoreCase('inactive'))
		 	{
		 		setConId.add(objCon.Id);
		 	}
		 }
		 
		 // Get the Contact Roles 
		 if(setConId.size() > 0)
		 {
		 	lstConRole = [select Id,ContactId from AccountContactRole where ContactId In : setConId];
		 	
		 	if(lstConRole.size() > 0)
		 	{
		 		Database.Deleteresult [] dbDeleteResult = Database.delete(lstConRole);
		 	}
		 }
	}
}