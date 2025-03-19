WITH FSUS_OP AS (

SELECT

[Timestamp] = CURRENT_TIMESTAMP

,[Submission_Date]

,[Appointment_Date]

,CASE WHEN Der_Provider_Code = 'RD3' THEN 'R0D'
	 WHEN Der_Provider_Code = 'RDZ' THEN 'R0D'
	 WHEN Der_Provider_Code = 'RBZ' THEN 'RH8'
	 WHEN Der_Provider_Code = 'RA3' THEN 'RA7'
	 WHEN Der_Provider_Code = 'RBA' THEN 'RH5'
	 WHEN Der_Provider_Code = 'R1G' THEN 'RA9'
	 WHEN Der_Provider_Code = 'RVJ13' THEN 'RVJ'
	 WHEN Der_Provider_Code = 'RA4' THEN 'RH5'
	 ELSE Der_Provider_Code END AS 'Provider_Code'

,d.Week_End

,count(cast([Local_Patient_ID] as varchar)) as MetricValue

,concat(Der_Contact_Type,Der_Appointment_Type) as MetricID

     ,CASE WHEN o.organisation_name = 'ROYAL DEVON AND EXETER NHS FOUNDATION TRUST' THEN 'ROYAL DEVON UNIVERSITY HEALTHCARE NHS FOUNDATION TRUST'
	 WHEN o.organisation_name  = 'TAUNTON AND SOMERSET NHS FOUNDATION TRUST' THEN 'SOMERSET NHS FOUNDATION TRUST'
	 WHEN o.organisation_name  = 'NORTHERN DEVON HEALTHCARE NHS TRUST' THEN 'ROYAL DEVON UNIVERSITY HEALTHCARE NHS FOUNDATION TRUST'
	 WHEN o.organisation_name  = 'THE ROYAL BOURNEMOUTH AND CHRISTCHURCH HOSPITALS NHS FOUNDATION TRUST' THEN 'UNIVERSITY HOSPITAL DORSET NHS FOUNDATION TRUST'
	 WHEN o.organisation_name  = 'POOLE HOSPITAL NHS FOUNDATION TRUST' THEN 'UNIVERSITY HOSPITAL DORSET NHS FOUNDATION TRUST'
	 WHEN o.organisation_name  = 'TORBAY AND SOUTHERN DEVON HEALTH AND CARE NHS TRUST' THEN 'TORBAY AND SOUTH DEVON NHS FOUNDATION TRUST'
	 When o.organisation_name = 'EMERSONS GREEN NHS TREATMENT CENTRE' THEN 'NORTH BRISTOL NHS TRUST'
	 When o.organisation_name = 'YEOVIL DISTRICT HOSPITAL NHS FOUNDATION TRUST' THEN 'SOMERSET NHS FOUNDATION TRUST'	 
	 When o.Organisation_Name = 'UNIVERSITY HOSPITALS BRISTOL NHS FOUNDATION TRUST' then 'UNIVERSITY HOSPITALS BRISTOL AND WESTON NHS FOUNDATION TRUST'
	 ELSE o.organisation_name  END AS 'organisation_name'

,o.STP_Name
  
FROM [NHSE_SUSPlus_Faster_SUS].[dbo].[tbl_Data_SUS_OPA] op

left join [NHSE_Reference].[dbo].[tbl_Ref_ODS_Provider_Hierarchies] as o
on op.Der_Provider_Code = o.Organisation_Code
 
left join [NHSE_Reference].[dbo].[tbl_Ref_Other_Dates_Full] as d
on d.[Full_Date] = Appointment_Date

left join [NHSE_SUSPlus_Faster_SUS].[dbo].[tbl_Data_SUS_OPA_2425_Der] as c
on op.OPA_Ident = c.[OPA_Ident]


left join [NHSE_Sandbox_Operations].[Everyone].[UCSM_RefTFCs] as r
on op.Treatment_Function_Code = r.Treatment_Function_Code


  WHERE  O.region_name = 'South West'
  and Der_Attendance_Type = 'Attend'
  AND Appointment_Date >= '2024-04-01'
  and op.[Treatment_Function_Code] not in ('360', '812')
  and r.Treatment_Function_Group_Planning_Groups = 'Specific Acute'
  and [Der_Staff_Type] = 'Cons'
  and [Der_Provider_Code] in ( -- SW Providers Acute Providers Only
		'RD1',
		'RN3',
		'RNZ',
		'RA7',
		'RVJ',
		'REF',
		'RA9',
		'RH8',
		'RK9',
		'RBD',
		'R0D',
		'RTE',
		'RH5')
  and Responsible_Purchaser_Assignment_Method NOT IN ('Reciprocal OSVs', 'Non-reciprocal OSVs', 'Private Patient', 'Devolved Administration')	-- CAM Logic to remove private patients ( more inline with national logic and removes issue with ADMIN completeness)

 
 Group by

       [Update_Type]
	  ,[Bulk_Replacement_CDS_Group]
      ,[Extract_Date_Time]
      ,[Report_Period_Start_Date]
      ,[Report_Period_End_Date]
      ,[Submission_Date]
      ,[Appointment_Date]
      ,Der_Provider_Code
      ,[CDS_Activity_Date]
   	,d.Week_End
	,concat(Der_Contact_Type,Der_Appointment_Type)
	,o.Organisation_Name
		,o.STP_Name)
 
 Select
	[Timestamp] = CURRENT_TIMESTAMP
	,[Submission_Date]
	,[Appointment_Date]
	,Provider_Code
	,Week_End
	,MetricValue
	,CASE WHEN MetricID = 'F2FFUp' THEN 'Outpatient attendances (consultant led) - Follow-up attendance face to face'
	WHEN MetricID = 'F2FNew' THEN 'Outpatient attendances (consultant led) - First attendance face to face'
	WHEN MetricID = 'NF2FFUp' THEN  'Outpatient attendances (consultant led) - Follow-up telephone or Video consultation'
	WHEN MetricID = 'NF2FNew' THEN  'Outpatient attendances (consultant led) - First telephone or Video consultation'
	ELSE null end as MetricID
	,Organisation_Name
	,STP_Name

from FSUS_OP