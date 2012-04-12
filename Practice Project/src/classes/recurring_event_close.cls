public with sharing class recurring_event_close 
{
	 public static void eventClosemethod(set<id> userids)
	 {
        list<Event> EventList = new list<Event>();
        list<Event> EventUpdateList = new list<Event>();
        list<Event> RecurringList = new list<Event>();
         EventList= [select id,RecurrenceEndDateOnly,RecurrenceActivityId from Event where ownerid IN : userids and Isrecurrence=true ];
    	 Set<id> reccid=new Set<id>();
    
    for(Event e:EventList){
        reccid.add(e.RecurrenceActivityId);
    }
    
  RecurringList =[select id,RecurrenceActivityId,RecurrenceEndDateOnly from Event where RecurrenceActivityId  IN: reccid ];
     
   for(Event e:RecurringList){
       e.RecurrenceEndDateOnly=System.today();
       EventUpdateList.add(e);
   }
   
   update EventUpdateList;                
         
   }
}