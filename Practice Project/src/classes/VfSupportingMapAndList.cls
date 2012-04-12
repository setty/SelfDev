public with sharing class VfSupportingMapAndList 
{
	public List<String> people {
	get {
	return new List<String>{'Winston', 'Julia', 'Brien'};
	}
	set;
	}
	public List<Integer> iter{
	get {
	return new List<Integer>{0, 1, 2};
	}
	set;
	}
	
	public Map<String,String> directorsToCountry {
	get {
	return new Map<String, String>{'Kieslowski' => 'Poland', 'del Toro' => 'Mexico',
	'Gondry' => 'France'};
	}
	set;
	}
	public List<String> keys {
	get {
	return new List<String>{'Kieslowski', 'del Toro', 'Gondry'};
	}
	set;
	}
}