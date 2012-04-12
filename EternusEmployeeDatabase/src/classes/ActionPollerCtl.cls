public class ActionPollerCtl 
{
	public ActionPollerCtl()
	{
		IsPollerEnabled = false;
		Counter = 0;	
	}
	
	public Integer Counter{get; set;}
	public Boolean IsPollerEnabled {get; set;}
	
	public void incrementCounter()
	{
		if((Counter + 1) > 5)
			IsPollerEnabled = false;
		else 
			++Counter; 
	}
	
	public void enablePoller()
	{ IsPollerEnabled = true; }
	
	public void disablePoller()
	{ IsPollerEnabled = false; }
	
}