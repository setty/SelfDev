<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Populate_Appt_Email</fullName>
        <description>Populate the Patient&apos;s email address for appointment reminders</description>
        <field>Patient_Email__c</field>
        <formula>Patient__r.Patient_Email_Address__c</formula>
        <name>Populate Appt Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Set Patient Email</fullName>
        <actions>
            <name>Populate_Appt_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Appointment__c.Patient_Email__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Populate the patient&apos;s email field so that reminder&apos;s can be sent</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
