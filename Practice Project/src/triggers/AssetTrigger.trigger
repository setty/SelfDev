trigger AssetTrigger on Asset (before insert) 
{
	boolean triggerIsActive = true;
	
	
    if (triggerIsActive) 
    {
        if (trigger.isBefore) {
            if (trigger.isDelete) {
                //STUB
            }
            if (trigger.isInsert) 
            {
                AssetTriggerClass.BeforeInset(trigger.new);
            }
            if (trigger.isUpdate) {
                //STUB
            }
        }
        
        if (trigger.isAfter) {
            if (trigger.isDelete) {
                //STUB
            }
            if (trigger.isInsert) {   
                //STUB
            }
            if (trigger.isUnDelete) {
                //STUB
            }
            if (trigger.isUpdate) {
                //STUB
            }
        }
	}
	
}