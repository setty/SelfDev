/**
 * 	Portal user : niket.c2009@gmail.com.dev2
 	Password    : test@123 
 *
 */
global with sharing class SiteLoginController {
    global String username {get; set;}
    global String password {get; set;}

    global PageReference login() {
        String startUrl = System.currentPageReference().getParameters().get('startURL');
        return Site.login(username,password,'/home/home.jsp');
    }
    
   	global SiteLoginController () 
   	{
   		Error.debuglog('startUrl==============>'+System.currentPageReference().getParameters().get('startURL'));
   	}
    
    @IsTest(SeeAllData=true) global static void testSiteLoginController () {
        // Instantiate a new controller with all parameters in the page
        SiteLoginController controller = new SiteLoginController ();
        controller.username = 'test@salesforce.com';
        controller.password = '123456'; 
                
        System.assertEquals(controller.login(),null);                           
    }    
}