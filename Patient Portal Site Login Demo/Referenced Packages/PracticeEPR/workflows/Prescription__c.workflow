<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Automatic_Prescription_Approval</fullName>
        <description>Non controlled drugs don&apos;t need to be approved, they can be set straight to Prescribed.</description>
        <field>Status__c</field>
        <literalValue>Prescribed</literalValue>
        <name>Automatic Prescription Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Drug_Approval_Required</fullName>
        <field>Status__c</field>
        <literalValue>Awaiting Approval</literalValue>
        <name>Set Drug Approval Required</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Set Prescription Approval Required</fullName>
        <actions>
            <name>Set_Drug_Approval_Required</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Prescription__c.Controlled_Drug_Flag__c</field>
            <operation>equals</operation>
            <value>1</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Set Prescription Status</fullName>
        <actions>
            <name>Automatic_Prescription_Approval</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Prescription__c.Controlled_Drug_Flag__c</field>
            <operation>notEqual</operation>
            <value>1</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
