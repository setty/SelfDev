public with sharing class RecruitmentFormController 
{
	public Contact contact{get;set;}
	public Attachment attachment{get;set;}
	
	 public RecruitmentFormController()
	 {
	 	contact = new Contact();
	 	attachment = new Attachment();
	 }
	 
	 public Pagereference Save()
	 {
	 	savepoint sp ;
	 	if(contact != null)
	 	{
	 		 Database.Saveresult saveResult = Database.insert(contact);
	 		/*if(Saveresult != null && saveResult.)
	 		{
	 			
	 		}
	 		if(attachment != null)
	 		{
	 			attachment.ParentId = contact.id; 
	 		}*/
	 	}
	 	return null;
	 }
}