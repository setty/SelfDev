global class IterratorUsingClass implements Iterable<Account>
{
 	global Iterator<Account> Iterator()
 	{
 		Error.DebugLog('Inside the IterratorUsingClass which implements Iterable with list of account ');
 		return new IteratorConceptApex();
 	}
 	
 	/* 
 		Need to do following things
 		
 		global class batchClass implements Database.batchable<Account>{
		global Iterable<Account> start(Database.batchableContext info){
		return new foo();
		}
		global void execute(Database.batchableContext info, List<Account> scope){
		List<Account> accsToUpdate = new List<Account>();
		for(Account a : scope){
		a.Name = 'true';
		a.NumberOfEmployees = 69;
		accsToUpdate.add(a);
		}
		update accsToUpdate;
		}
		global void finish(Database.batchableContext info){
		}
		}
 	
 	
 	*/
}