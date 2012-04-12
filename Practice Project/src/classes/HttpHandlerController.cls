public with sharing class HttpHandlerController
{
    public EmailServicesFunction ObjEmailServicesFunction {get;set;}
	public String HttpUrl{get;set;}
	
	public HttpHandlerController()
	{
		//http://salesforcesource.blogspot.com/2010/01/utilizing-apex-pattern-and-matcher.html
		
		/*
		Google map 
		http://maps.google.com/maps/geo?q=1600+Amphitheatre+Parkway,+Mountain+View,+CA&output=json&oe=utf8\
		&sensor=true_or_false&key=ABQIAAAAJmx15HrlcYlP-oAgQvOpERQDniXuQYAFepnXhuLuI7naU8MY0hRQgL8CSfiH5k1vIWkcdu-x2ywBKw
		
		********* Http Service Example
		http://maps.google.com/maps/geo?q=1600+Amphitheatre+Parkway,+Mountain+View,+CA&output=json&oe=utf8\
		&sensor=true_or_false&key=ABQIAAAAJmx15HrlcYlP-oAgQvOpERQDniXuQYAFepnXhuLuI7naU8MY0hRQgL8CSfiH5k1vIWkcdu-x2ywBKw
		
		*/
		
		Httprequest objReq = new Httprequest();
		objReq.setEndpoint('http://maps.google.com/maps/geo?q=1600+Amphitheatre+Parkway,+Mountain+View,+CA&output=json&oe=utf8&sensor=false&key=ABQIAAAAJmx15HrlcYlP-oAgQvOpERQDniXuQYAFepnXhuLuI7naU8MY0hRQgL8CSfiH5k1vIWkcdu-x2ywBKw');
    	objReq.setMethod('GET');
    	
		Http Ht = new Http();
		Httpresponse  responce = Ht.send(objReq);
		Error.DebugLog('Body ================> '+responce.getBody());
		Error.DebugLog('Status ================> '+responce.getStatus());
		Error.DebugLog('responce ================> '+responce.toString());
		 
	}
}