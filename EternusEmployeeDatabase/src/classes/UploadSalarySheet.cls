public with sharing class UploadSalarySheet 
{
	public Contact contact{get;set;}
	public Attachment SalaryAttachment{get;set;}
	public String FileName{get;set;}
	
	public UploadSalarySheet(ApexPages.StandardController stdController)
	{
		SalaryAttachment = new Attachment();
		SalaryAttachment.ContentType = 'application/vnd.ms-excel#contacts.xls';
		this.contact = (Contact) stdController.getRecord();
	}
	
	public Pagereference ReadFile()
	{
		if(SalaryAttachment != null)
		{
			Blob myBIGblob = SalaryAttachment.Body;
			String strValue = myBIGblob.toString();
			String[] arr = strValue.split('\n');
		//	Error.DebugLog('arr==>'+arr);
			// Regular Expression
			
		}
		return null;
	}
	
	// Inner Class 
	public class SalarySheet
	{
		public String EmpName{get;set;}
		public String Designation{get;set;}
		public Double Salary{get;set;}
	}
}