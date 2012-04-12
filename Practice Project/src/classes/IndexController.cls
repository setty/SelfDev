public with sharing class IndexController{
	
	public CustomerPortal__c objPortalUser{get;set;}
	
	public List<Patient__c> lstPatient{get;set;}
	
	public IndexController(){
		// UserName Password URL
		objPortalUser = new CustomerPortal__c();
		lstPatient = new List<Patient__c>();
	}
	
	public Pagereference Init(){
		Error.DebugLog('startUrl ===========>'+Site.getPrefix());
		Pagereference page = site.login('niket.c2009@gmail.com.dev', 'neha@123','/home/home.jsp');
		System.debug('Current User ==>'+Userinfo.getSessionId());
		Error.DebugLog('Session Id ===========>'+Userinfo.getSessionId());
		Error.DebugLog('Name ===========>'+Userinfo.getName());
		Error.DebugLog('profile ===========>'+Userinfo.getProfileId());
		return null;
	}
	
	public Pagereference login(){
		if(objPortalUser.Name != null && objPortalUser.Password__c != null){
			lstPatient = [Select Id,Name from Patient__c where CustomerPortal__r.Name =:objPortalUser.Name];
			Error.DebugLog('lstPatient '+lstPatient);
		}
		return null;
	}
}