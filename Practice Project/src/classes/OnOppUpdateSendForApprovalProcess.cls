public with sharing class OnOppUpdateSendForApprovalProcess {
	public static void SentToApprovalProcess(List<Opportunity> lstOppNew,List<Opportunity> lstOppOld)
	{
		
		/*List<Approval> lstApproval = [Select a.Status, a.ParentId, a.OwnerId, a.Id, a.ApproveComment From Approval a];
		System.debug('lstApproval ===============>'+lstApproval);
		
		
		list<Approval.Processsubmitrequest> lstApprovalSubmission = new list<Approval.Processsubmitrequest>();
		
		for(Integer iCount = 0; iCount < lstOppNew.size() ; iCount ++)
		{
			if(lstOppNew[iCount].Probability > 30 && lstOppOld[iCount].Probability < 30)
			{
				Approval.Processsubmitrequest objApp = new Approval.Processsubmitrequest();
				objApp.setObjectId(lstOppNew[iCount].id);
				objApp.setComments('Sent for Approval By Niket by coding');
				objApp.setNextApproverIds(new Id[]{'00590000000i7T2'});
				lstApprovalSubmission.add(objApp);
			}
		}
		Approval.Processresult[] result = Approval.process(lstApprovalSubmission,true);
		if(result != null)
		{
			for(Approval.Processresult objApproval : result)
			{
				System.debug('objApproval.getActorIds(); 	==>'+objApproval.getActorIds());
				System.debug('objApproval.getErrors(); 		==>'+objApproval.getErrors());
				System.debug('objApproval.getInstanceId(); 	==>'+objApproval.getInstanceId());
				System.debug('objApproval.getNewWorkitemIds(); => '+objApproval.getNewWorkitemIds());
				System.debug('objApproval.isSuccess(); 	   	=>'+objApproval.isSuccess());
				System.debug('objApproval.getInstanceStatus(); 	   	=>'+objApproval.getInstanceStatus());
			}
		}*/
				  
	}
	
	public static void checkProcessInstance(Map<Id,Opportunity> NewMap,Map<Id,Opportunity> oldMap)
	{
		List<ProcessInstance> lstProInstance = [SELECT Status, TargetObject.Name, TargetObjectId, TargetObject.Type, (SELECT Actor.Id, Actor.Name, Actor.Email, CreatedDate FROM WorkItems)
                                    FROM ProcessInstance
                                    WHERE TargetObject.Type = 'Opportunity' and TargetObjectId in : NewMap.KeySet()];
        System.debug('lstProInstance ==>'+lstProInstance);
		
			
	}	
}