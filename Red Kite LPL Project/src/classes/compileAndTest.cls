public class compileAndTest { 

    public static testmethod void t1() {

        Investment_Option__c i = new Investment_Option__c(Product__c = '01t70000000oBrf', of_Assets_in_Fund_AUM__c = 100, Plan__c='80070000000PiQ3');
        insert i;

         Investment_Option__c reti = [select Investment_Option_Ticker_Symbol__c from Investment_Option__c where id=:i.id][0];

        System.assertEquals(GetTickerSymbol(), reti.Investment_Option_Ticker_Symbol__c);

	Fund_Audit_Trail__c fat = [select Action__c from Fund_Audit_Trail__c where Plan__c='80070000000PiQ3' and Ticker_Symbol__c='fimex'][0];
        System.assertEquals('Added Investment Option', fat.Action__c);

    }

    public static String GetTickerSymbol() {
        return 'FIMEX';
    }

    public static testmethod void t2() {

        Contract c = new Contract(OwnerId = '00570000001K1fG', Plan_Name__c='Drew Test Plan', Date_Established__c=date.today(), Contract_Status__c = 'Active', AccountID = '0017000000NSMXH', RecordTypeId = '012700000005CaU', Status='DO NOT MODIFY');
        insert c;

        Contract retc = [select BD_Payout__c, Tax_ID__c from Contract where id=:c.id][0];

			// Can't tell who the owner will be over time so tests were removed
//        System.assertEquals(95.0, retc.BD_Payout__c);
//        System.assertEquals('024679876', retc.Tax_ID__c);
    }
}