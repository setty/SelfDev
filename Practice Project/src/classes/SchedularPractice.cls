global public with sharing class SchedularPractice implements Schedulable
{
	global void execute(SchedulableContext sc)
	{
		SendMail(sc);
		// Crom expression for to schedule the class
		//Seconds Minutes Hours Day_of_month Month Day_of_week optional_year
	}
	
	public void SendMail(SchedulableContext sc)
	{
		Messaging.Singleemailmessage objEmail = new Messaging.Singleemailmessage();
		objEmail.setSubject('Schedular number '+sc.getTriggerId());
		objEmail.setSenderDisplayName('Niket Schedular');
		objEmail.setReplyTo('Niket.2009@gmail.com');
		objEmail.setToAddresses(new String[]{'niket.c2009@gmail.com'});
		Messaging.sendEmail(new Messaging.Email[]{objEmail});
	}
}