trigger DeleteEvent on User (after update) // It must be after update 
{
	List<Event>EventList = new List<Event>();
    List<Event>RecurringList = new List<Event>();
   
    Set<Id>UId = new Set<Id>();
      
    for( User U: Trigger.new){
    
        // Check wheather the User is inactive
        if( U.IsActive==false && U.LastName.endsWith('-t'))
             UId.add(U.Id);
    }
    
    //recurring_event_close.eventClosemethod(UId);
    
  /*  EventList=[select id,RecurrenceEndDateOnly,RecurrenceActivityId from Event where ownerid IN : UId and Isrecurrence=true ];
    Set<id> reccid=new Set<id>();
    for(Event e:EventList){
        reccid.add(e.RecurrenceActivityId);
    }
  RecurringList =[select id,RecurrenceActivityId,RecurrenceEndDateOnly from Event where RecurrenceActivityId  IN: reccid ];
      
                        
   for(Event e:RecurringList){
       e.RecurrenceEndDateOnly=System.today();
   }  */              
               
}