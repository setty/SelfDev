public with sharing class Logincontrol
{
public String Name{get;set;}
public pagereference welcome()
{
 pagereference obj =new pagereference('/apex/welcome?myname='+Name);
 return obj;
}
}