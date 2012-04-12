public with sharing class SendSms 
{
	public SendSms()
	{
		
	}
	
	public Pagereference SendSms()
	{
		SendSmsTest();
		return null;
	}
	
	@future(callout = true)
	public static void SendSmsTest()
	{
		try
		{
		smsPostmasterCoIn.SendSmsService objSendSmsService = new smsPostmasterCoIn.SendSmsService();
		objSendSmsService.inputHttpHeaders_x = new Map<String,String>();
		objSendSmsService.outputHttpHeaders_x = new Map<String,String>();
		objSendSmsService.timeout_x = 119999;
		//objSendSmsService.clientCert_x = '';
		
		//smsPostmasterCoIn.SendSmsRequestRequest_element objRequest = new smsPostmasterCoIn.SendSmsRequestRequest_element();
		//smsPostmasterCoIn.SendSmsRequestResponse_element objResponce = new smsPostmasterCoIn.SendSmsRequestResponse_element(); 
		
		
		String strResult = objSendSmsService.SendSMSRequest('12821_ciel_sms', 'c3i9e5l3', '@919730250818', '@919730250818', 'This is test msg from Salesforce');
		System.Debug('==========================> strResult'+strResult);
		}
		catch(Exception ex)
		{
			System.Debug('Exception ==========>'+ex);			
		}
	}
	
}