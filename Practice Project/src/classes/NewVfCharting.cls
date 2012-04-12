public with sharing class NewVfCharting 
{
	public List<Data> getPieData() {
	List<Data> data = new List<Data>();
	data.add(new Data('Jan', 30));
	data.add(new Data('Feb', 15));
	data.add(new Data('Mar', 10));
	data.add(new Data('Apr', 20));
	data.add(new Data('May', 20));
	data.add(new Data('Jun', 5));
	return data;
	}
	// Wrapper class
	public class Data {
	public String name { get; set; }
	
	public Integer data1 { get; set; }
	public Data(String name, Integer data1) {
	this.name = name;
	this.data1 = data1;
	}
	}
}