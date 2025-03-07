# National FasterSUS (Daily SUS+) - Reconciliation - South West
## NHS England South West Intelligence and Insights

### What is FasterSUS?

The importance of timely data, highlighted during the Covid-19 response, has improved planning and decision-making across all levels. To build on this, the Faster SUS+ programme was introduced, requiring NHS-funded acute healthcare providers to submit CDS data weekly to NHS Digital. The programme aims to ensure timely data submissions, reduce provider burdens through central reporting, and enhance planning and decision-making for service improvements and better patient outcomes.

National Reporting Hosts a Faster SUS+ Programme page on Futures: [National JAR Report](https://future.nhs.uk/OIforC/view?objectID=21697168)

### What is SUS+?

The Secondary Uses Service (SUS+) is the single, comprehensive repository for healthcare data in England which enables a range of reporting and analyses to support the NHS in the delivery of healthcare services since 2008.
SUS+ is a secure trusted data warehouse that stores this patient-level information in line with national standards and applies complex derivations which support national tariff policy and secondary analysis. 
Access to the SUS+ portal is managed using Role-Based Access Control (RBAC) which grants appropriate auditable access levels to identifiable, anonymised or pseudonymised data based on the users job role.
Submission to SUS+ is via Message Exchange for Social Care and Health (MESH) for Commissioning Dataset (CDS) XML interchanges.
SUS+ is monitored by the Cyber Security Operations Centre (CSOC) and complies with all Information Governance directives, especially in terms of processing and disseminating identifiable data.
SUS+ has been in-house at the NHS England Digital Transformation Directorate since 2016 and has a fully automated single queue processing system, allowing the processing of CDS XML interchanges on arrival. Data with additional derived values (including HRGs) are made available to users via the SUS+ portal immediately on acceptance. 

From September 2022, SUS+ has been running on Cloud infrastructure, meeting the demands of daily, weekly, and monthly data processing at twice the speed of “on prem” infrastructure.

NHS Digital SUS Website: [NHSD SUS Website](https://digital.nhs.uk/services/secondary-uses-service-sus)

### FasterSUS Compliance

#### Compliance Criteria

The Faster SUS technical guidance outlines the requirements for data submission, highlighting the importance of compliance. Key points include: data must be submitted weekly; the most recent activity should be within 14 days of the submission date; incomplete coding is expected and will improve over time; and if no separate FasterSUS submission is made, the monthly refresh should include data up to the day before submission, not just the previous full month.  

Compliance is monitored Centrally by the National PAT team, with FasterSUS DQ Monitoring Reports and Forms apart of the wider National Elective Data Quality Priority.  
- FasterSUS DQ Monitoring Reports page on Futures: [National FasterSUS DQ Monitoring](https://future.nhs.uk/OIforC/view?objectID=27871152)  
- South West Monitoring Tool page on Futures: [FasterSUS Compliance Dashboard](https://future.nhs.uk/SouthWestAnalytics/view?objectID=37408880)  
- South West Monitoring Tool on OKTA: [Tableau link: FasterSUS Compliance Dashboard](https://tabanalytics.data.england.nhs.uk/#/views/SouthWestFasterSUSComplianceDashboard_17145757789570/Coverpage?=null,&:iid=2)

### Scripts

#### Provider Focus
📝 National FasterSUS methodology - Admitted patient care script - Provider  
📝 National FasterSUS methodology - Outpatient Attendance script - Provider  

#### Commissioner Focus (not used for complaince reports)
📝 National FasterSUS methodology - Admitted patient care script - Comm  
📝 National FasterSUS methodology - Outpatient Attendance script - Comm  

### About the Scripts
The FasterSUS scripts are ran using National Planning logic, the below applies to both APC and OP scripts:  
- Acute Provider Only  
- Consultant led Specific Acute activity only  
- Treatment Function Code 360 is excluded  
- Dominant_Episode_Flag = 1  
- Excluding Private patients, Reciprocal OSVs, Non-reciprocal OSVs & Devolved Administration

🏥 **Admitted patient care script**  
*This script covers both elective and non-elective hospital activity, sourced from the National FasterSUS Admitted Patient Care SUS table*  

👨‍⚕️ **Outpatient Attendance script**  
*This script covers Outpatient attendances, sourced from the National FasterSUS Outpatient SUS table. Logic applied as above with an additional exclusion for Treatment Function Code 812*  

### Built With SQL in NCDR (National Reporting has not moved over to UDAL yet - ETA May). 

🛢️[SQL SSMS](https://learn.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver16)  
🖲️[NCDR](https://rdsweb101.gemcsu.nhs.uk/RDWeb/Pages/en-US/login.aspx?ReturnUrl=%2fRDWeb%2fPages%2frdp%2fcpub-NHSE_-_Analysts-NHSE_-_Analysts-CmsRdsh.rdp)


#### Datasets in the NHSE_SUSPlus_Faster_SUS Repository on NCDR
  
🛢️ tbl_Data_SUS_APCE  
🛢️ tbl_Data_SUS_APCS *(not used for compliance reports)*  
🛢️ tbl_Data_SUS_OPA

### Contact

To find out more about the South West Intelligence and Insights Team visit our [South West Intelligence and Insights Team Futures Page](https://future.nhs.uk/SouthWestAnalytics)) or get in touch at [england.southwestanalytics@nhs.net](mailto:england.southwestanalytics@nhs.net). Alternatively, Please feel free to reach out to me directly:

📧 Email: [Destiny.Bradley@nhs.net](mailto:Destiny.Bradley@nhs.net)  
💬 Teams: [Join my Teams](https://teams.microsoft.com/l/chat/0/0?users=<destiny.bradley@nhs.net)

### Acknowledgements
Thanks to Bernardo Detanico for his ongoing support in applying National Logic.

