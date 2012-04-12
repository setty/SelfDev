<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Calculate_Balance</fullName>
        <field>Balance__c</field>
        <formula>/* For credit notes credit the balance, for all other types find the remaining balance */
IF( ISPICKVAL(Transaction_Type__c, &apos;Credit Note&apos;),
   0 - Total_Amount__c , 
   Total_Amount__c -  Payment_Received__c)</formula>
        <name>Calculate Balance</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Invoice_Status_to_Paid</fullName>
        <field>Status__c</field>
        <literalValue>Paid</literalValue>
        <name>Set Invoice Status to Paid</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Set Invoice Balance</fullName>
        <actions>
            <name>Calculate_Balance</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 OR 2</booleanFilter>
        <criteriaItems>
            <field>Invoice__c.Payment_Received__c</field>
            <operation>greaterOrEqual</operation>
            <value>0</value>
        </criteriaItems>
        <criteriaItems>
            <field>Invoice__c.Transaction_Type__c</field>
            <operation>equals</operation>
            <value>Credit Note</value>
        </criteriaItems>
        <description>Set the invoice balance based on the payment received</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Set Invoice Status based on payment received</fullName>
        <actions>
            <name>Set_Invoice_Status_to_Paid</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Invoice__c.Status__c</field>
            <operation>equals</operation>
            <value>Invoiced,Overdue</value>
        </criteriaItems>
        <criteriaItems>
            <field>Invoice__c.Balance__c</field>
            <operation>equals</operation>
            <value>0</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
