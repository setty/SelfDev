trigger OnOppUpdateSendForApprovalProcess on Opportunity (after update) 
{
	OnOppUpdateSendForApprovalProcess oSentForApproval = new OnOppUpdateSendForApprovalProcess();
	OnOppUpdateSendForApprovalProcess.SentToApprovalProcess(trigger.new,trigger.old);
}