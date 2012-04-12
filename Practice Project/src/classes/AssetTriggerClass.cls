public with sharing class AssetTriggerClass 
{
    
  /*  public static void SetAssetFields(List<Asset> lstAsset)
    {
        List<Opportunity> lstOpp = new List<Opportunity>();                     // Hold the list of Oprtunities recpective with Asset's account
        Set<Id> setAccountId = new Set<Id>();                                   // Need the set of account id to fetch the Selected Opportunity
        Set<Id> SetOppId = new Set<Id>();                                       // Need the Set Opportunity Id to fetch the Selected Product Information
        Map<Id,Id> MapAssetAccountId = new Map<Id,Id>();                        // Map of AssesId and AccountId 
        Map<Id,Opportunity> MapAccountIdOpprtunity = new Map<Id,Opportunity>(); // Need recent Opprtunity with respect to Account 
        Map<Id,Product_Information__c> MapOppIdAndProdInfo = new Map<Id,Product_Information__c>();
        list <Product2> lstProd2 = [Select Name,Id from Product2 where Name =: 'Lender Development Program']; // Get product Id of type "Lender Development Program"
        
        // Collect Account Id
        for(Asset oAsset :lstAsset)
        {
            // Get only those Asset who is having LDP product
            if(oAsset.Product2Id == lstProd2[0].Id)
            {
                //MapAssetAccountId.put(oAsset.Id,oAsset.AccountId);
                setAccountId.add(oAsset.AccountId);
            }
        }
        
        // Get the record id type of "Deal" of Opprtunity Object 
        List<RecordType> lstRec = [Select r.SobjectType, r.Name, r.Id From RecordType r where r.Name='Deal' and r.SobjectType ='Opportunity' Limit 1] ;
        
        // get Recent Opprunity of the recpective Account and having Deal as a RecordType
        lstOpp = [Select o.CreatedDate,o.Name, o.Id, o.AccountId From Opportunity o where o.RecordTypeId =:lstRec[0].id and o.AccountId IN :setAccountId order By o.CreatedDate asc];
        
        // Create Map of Account Id and Recently Created Opportunity
        if(lstOpp.Size() > 0)
        {
            for(Opportunity opp : lstOpp)
            {
                // Add only Last Opportunity
                if(!MapAccountIdOpprtunity.ContainsKey(opp.AccountId))
                {
                    MapAccountIdOpprtunity.put(opp.AccountId,opp);
                }
                SetOppId.add(opp.Id);
            }
        }
        
        //Get the the product of the LDPProduct 
        List<Product_Information__c> lstProdInfo = [Select Id,Name,Number_of_Branches__c,Number_of_Coaches__c,
                                                            Number_of_Lenders__c,
                                                            Branch_State_Residency__c,
                                                            Sales_Practices_Same_Across_Branches__c,
                                                            Opportunity__c
                                                            from  Product_Information__c 
                                                            where RecordType.Name='Lender Development Program' 
                                                            and Opportunity__c In :SetOppId order By CreatedDate asc];
    
    // Here we are assuming One ooprtunity having one product Information of type "Lender Development Program"
    for(Product_Information__c oProductInfo : lstProdInfo)
    {
        if(!MapOppIdAndProdInfo.ContainsKey(oProductInfo.Opportunity__c))   
            MapOppIdAndProdInfo.put(oProductInfo.Opportunity__c,oProductInfo);
    }
    
    // Finaly Update the only those Assets having product of type Lender Development Program
    for(Asset oAsset : lstAsset)
    {
        if(oAsset.Product2Id == lstProd2[0].Id)
        {
            Opportunity oOpp = MapAccountIdOpprtunity.get(oAsset.AccountId);
            Product_Information__c objProductInfo   = MapOppIdAndProdInfo.get(oOpp.Id);
            oAsset.Number_of_Branches_for_LDP__c    = objProductInfo.Number_of_Branches__c;
            oAsset.Number_of_Lenders__c             = objProductInfo.Number_of_Lenders__c;
            oAsset.Number_of_Coaches__c             = objProductInfo.Number_of_Coaches__c;
            oAsset.Branch_State_Residency_for_LDP__c    = objProductInfo.Branch_State_Residency__c;
            
            if(objProductInfo.Sales_Practices_Same_Across_Branches__c)
            	oAsset.Same_Sales_Practices__c          = 'Yes';
            else
            	oAsset.Same_Sales_Practices__c          = 'No';
            	
        }
    }
    
    }*/
    
    public static testmethod void TestAssetTrigger()
    {
    	Test.startTest();
    	// Need to create Account First
    	Account objAcc = New Account();
		objAcc.Name ='TestAccount';
		Insert objAcc;
    	
    	// Need to fetch the Record type of Deal to Set Opportunity as Deal type
    	List<RecordType> lstRec = [Select r.SobjectType, r.Name, r.Id From RecordType r where r.Name='Deal' and r.SobjectType ='Opportunity' Limit 1] ;
    	// Need to Insert Opportunties for that Account
    	Opportunity objOpp = new Opportunity();
    	objOpp.Name		= 'Test Opp';
    	objOpp.StageName = 'Open';
    	objOpp.CloseDate	= System.today();
    	objOpp.RecordTypeId = lstRec[0].Id;
    	 
    	
    	Test.stopTest();
    }
}