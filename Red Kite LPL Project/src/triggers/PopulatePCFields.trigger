trigger PopulatePCFields on Account (before insert, before update) {

  for (account a :trigger.new){
    a.PersonEmail_Copy__c = a.PersonEmail;
    a.PersonHomePhone_Copy__C = a.PersonHomePhone;
    a.PersonBusinessPhone_Copy__c = a.Business_Phone__pc;
  }

}