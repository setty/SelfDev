public with sharing class LinkedInRestApiCtl {
	
	private static String strMessage = 'Sample message posted on LinkedIn from Salesforce.com. ';
	private static String strLink = 'http://sample.message@sfdc.com';
	private String strKey = '2Gc6zHjPfSnlAE195diURn3Bqd0hhzH5LiLPMsoDcOEX8wVJQPxf9I1wVB2FJTt-';
	
	public LinkedInRestApiCtl()
	{}

	//Properties
	public String LinkedInResponse {get; set;}
	public String getCurrentPageUrl(){
		return Apexpages.currentPage().getUrl();
	}
	
	//Methods	
	public PageReference connectToLinkedIn(){
		try{
			Httprequest oRequest = new Httprequest();
		
			oRequest.setEndpoint('http://api.linkedin.com/v1/people/~/person-activities');
			oRequest.setMethod('POST');
			oRequest.setHeader('auth', strKey);
			oRequest.setBody(getLinkedInMessageBody());
			
			Http oHttp = new Http();
			Httpresponse oResponse = oHttp.send(oRequest);
			LinkedInResponse = 'Response: ' + oResponse.getBodyDocument().toXmlString();
		}
		catch(Exception ex){
			LinkedInResponse = 'Exception: ' + ex.getMessage();
		}
		return NULL;
	}
	
	public static String getLinkedInMessageBody(){
		return '<activity locale="en_US">' + 
			   '<content-type>linkedin-html</content-type>' + 
			   '<body>' + strMessage + strLink + 
			   '</body>' + '</activity>';
	}

}