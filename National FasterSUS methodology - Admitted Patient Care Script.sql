SELECT 

[Timestamp] = CURRENT_TIMESTAMP

,[Discharge_Date]

,[Extract_Date_Time] as [CDS_Extract_Date]

,[Submission_Date] as [CDS_Received_Date]

,CASE WHEN Der_Provider_Code = 'RD3' THEN 'R0D'
WHEN Der_Provider_Code = 'RDZ' THEN 'R0D'
WHEN Der_Provider_Code = 'RBZ' THEN 'RH8'
WHEN Der_Provider_Code = 'RA3' THEN 'RA7'
WHEN Der_Provider_Code = 'RBA' THEN 'RH5'
WHEN Der_Provider_Code = 'R1G' THEN 'RA9'
WHEN Der_Provider_Code = 'RVJ13' THEN 'RVJ'
WHEN Der_Provider_Code = 'RA4' THEN 'RH5'
ELSE Der_Provider_Code END AS 'Der_Provider_Code'

,count(cast(apc.[APCE_Ident] as varchar)) as MetricValue

,d.Week_End

,CASE WHEN [Patient_Classification] = 2 then 'Elective day case spells' when [Patient_Classification] = 1 then 'Elective ordinary spells' 
ELSE [Patient_Classification] END AS 'MetricID'

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

,case when Der_Management_Type = 'EM' then 'NE' else Der_Management_Type end as 'Tariff_Admission_Type'


 FROM [NHSE_SUSPlus_Faster_SUS].[dbo].[tbl_Data_SUS_APCE] apc

  
left join [NHSE_Reference].[dbo].[tbl_Ref_ODS_Provider_Hierarchies] as o
on apc.Der_Provider_Code = o.Organisation_Code

left join [NHSE_Reference].[dbo].[tbl_Ref_Other_Dates_Full] as d
on d.[Full_Date] = [Discharge_Date]

left join [NHSE_SUSPlus_Faster_SUS].[dbo].[tbl_Data_SUS_APCE_Plus] as a
on apc.APCE_Ident = a.[APCE_Ident]

left join [NHSE_SUSPlus_Faster_SUS].[dbo].[tbl_Data_SUS_APCS_2425_Der] as c
on apc.APCE_Ident = c.[APCS_Ident]

left join [NHSE_Sandbox_Operations].[Everyone].[UCSM_RefTFCs] as r
on apc.Treatment_Function_Code = r.Treatment_Function_Code

 where [Discharge_Date] >= '2024-04-01'
	and [Patient_Classification] in ('1','2')
	and Der_Provider_Code  in ( -- SW Providers Acute Providers Only
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
	and a.SUS_Dominant_Episode_Flag = '1'
	and r.[Treatment_Function_Code] not in ('360')
	and r.Treatment_Function_Group_Planning_Groups = 'Specific Acute'
    and c.Responsible_Purchaser_Assignment_Method NOT IN ('Reciprocal OSVs', 'Non-reciprocal OSVs', 'Private Patient', 'Devolved Administration')	-- CAM Logic to remove private patients ( more inline with national logic and removes issue with ADMIN completeness)


Group by
        [Discharge_Date]
		,Extract_Date_Time
		,Submission_Date
        ,[Der_Provider_Code]
		,Patient_Classification
	  ,d.Week_End
	   , o.Organisation_Name
	  , o.stp_name
	  ,Der_Management_Type
GO


