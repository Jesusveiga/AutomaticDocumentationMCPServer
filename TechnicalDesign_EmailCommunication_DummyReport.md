# Technical Design & Specifications

## 1. Introduction & Executive Summary
This Technical Design Document (TDD) serves as the definitive architectural blueprint for the Power BI semantic model. It provides a comprehensive overview of the data engineering lifecycle, from structural modeling to analytical logic implementation. The primary objective is to ensure institutional data governance, facilitate scalable maintenance, and provide a single source of truth for business-critical KPIs.

* **Project Scope:** Email Communication Analytics & Organizational Network Intelligence
* **Report Name:** EmailCommunication_DummyReport
* **Technical Authority:** Data Architecture & BI Excellence Team
* **Target Audience:** Strategic Stakeholders, Data Stewards, and Lead Developers

## 2. Data Sources & Architecture
The model is built upon a resilient data integration layer, optimized for high-performance analytical querying.
* **Upstream Systems:** Multi-source integration (SQL Server, Cloud Repositories, Flat Files).
* **Storage Engine:** VertiPaq (In-Memory) via Import Mode to maximize DAX performance.
* **Connectivity:** Enterprise Gateway / Service-to-Service refresh.
* **Refresh Frequency:** Standardized daily processing at 06:00 AM UTC.

## 3. Security & Governance
Strict adherence to enterprise data protection standards is enforced at the model level.
* **Access Control:** Role-Based Access Control (RBAC) via Power BI Workspace permissions.
* **Row-Level Security (RLS):** Dynamic security predicates implemented via DAX filters based on organizational hierarchy.
* **Data Classification:** [Internal] - Access restricted to authorized personnel managing organizational communications and analytics.

## 4. Semantic Model & Report Design

### 4.2 Data Model
#### 4.2.1 Star Schema Architecture
The semantic model utilizes a dimensional star-schema architecture, following Kimball methodology where applicable. This design decouples transactional fact events from descriptive master data (dimensions), ensuring optimal compression and sub-second query response times for complex aggregations.

**Fact Tables (Central & Specialized)**
| Fact Table Name | Purpose | Key Characteristics |
|---|---|---|
| fact_emails | Central repository for all email communication transactions | Contains 22 columns capturing sender/recipient details, temporal markers, sentiment analysis, and behavioral attributes; primary key is Email id; optimized for high-cardinality aggregations across organizational dimensions |

**Dimension & Master Tables**
| Dimension/Master Table Name | Purpose | Key Characteristics |
|---|---|---|
| dim_contacts | Master directory of personnel within the organization | 6 attributes mapping Name to Department, email address, Seniority level, and visual attributes (color/aura) for UI rendering |
| dim_department | Department classification dimension | Single attribute capturing organizational unit identifiers; supports hierarchical filtering and cross-dimensional analysis |
| dim_seniority | Seniority classification dimension | Categorical attribute defining organizational rank levels; enables role-based analysis and sentiment/behavior correlation studies |
| Sentiment | Sentiment classification reference table | 2 columns: Sentiment (categorical) and Sort_Order (ordinal) for consistent visualization sequencing |
| DateTableTemplate_1f35302b-2263-4042-953a-65232bf21c34 | Explicit date dimension for temporal analysis | 7 columns providing Year, Month (numeric/text), Quarter, and Day derivations; supports calendar-driven aggregations |
| LocalDateTable_4cda58ae-cf2f-4637-b717-9f3cd6b206fa | Implicit date dimension for dynamic date filtering | Mirrors DateTableTemplate structure; maintains grain-level consistency across multiple date contexts |
| LocalDateTable_63513472-0511-4adb-a34c-08d15153ca5c | Secondary implicit date dimension for temporal aggregations | Supports multi-axis temporal analysis when required by complex reporting scenarios |
| LocalDateTable_b24bdeaf-cb39-46e8-994c-b1a00e7fec3f | Tertiary implicit date dimension for detail-level time analysis | Enables drill-down analysis at the hour level via HourOfDay derivation |
| Source Nodes | Network topology dimension for sender analysis | Supports graph-based communication network visualization; captures source entity attributes |
| Target Nodes | Network topology dimension for recipient analysis | Supports graph-based communication network visualization; captures target entity attributes |
| TopicGroup | Email topic grouping dimension | Categorical dimension for topic classification and top-N filtering logic |
| FlexaDesign | Custom visual configuration table | Configuration table supporting FlexaDesign custom visual; minimal cardinality |
| Dynamic Titles | Calculated dimension for UI labeling | Zero-row table serving as container for dynamic title measures used in report headers |

**Relationship Model**
| Relationship (From -> To) | Cardinality | Active | Cross-Filter | Purpose |
|---|---|---|---|---|
| fact_emails[From Name] → dim_contacts[Name] | Many-to-One | Yes | Single | Identifies sender attributes (department, seniority, contact info) |
| fact_emails[From seniority] → dim_seniority[Seniority] | Many-to-One | Yes | Single | Contextualizes sender seniority level for hierarchical analysis |
| fact_emails[From Department] → dim_department[Department] | Many-to-One | Yes | Single | Enables department-level aggregations for sent email metrics |
| fact_emails[To Name] → dim_contacts[Name] | Many-to-One | No | Single | Secondary relationship identifying recipient attributes; disabled to prevent ambiguity with sender path |
| fact_emails[To seniority] → dim_seniority[Seniority] | Many-to-One | No | Single | Explicit relationship for recipient seniority analysis via USERELATIONSHIP |
| fact_emails[To Department] → dim_department[Department] | Many-to-One | No | Single | Explicit relationship for recipient department analysis via USERELATIONSHIP |
| fact_emails[Sentiment] → Sentiment[Sentiment] | Many-to-One | Yes | Single | Maps email sentiment classification to reference table for consistent ordering |
| fact_emails[Date] → DateTableTemplate_1f35302b-2263-4042-953a-65232bf21c34[Date] | Many-to-One | Yes | Single | Primary temporal dimension supporting month/quarter/year aggregations |
| TopicGroup[Group] → TopicGroup hierarchy | One-to-Many | Yes | Single | Supports hierarchical topic grouping for top-N filtering mechanism |

**Relationship Model**

| Relationship (From -> To) | Cardinality | Active | Cross-Filter | Purpose |
|---|---|---|---|---|
| fact_emails[From Name] -> dim_contacts[Name] | Many-to-One (inferred) | Inferred | Single (inferred) | Link sender to contact master data |
| fact_emails[To Name] -> dim_contacts[Name] | Many-to-One (inferred) | Inferred | Single (inferred) | Link recipient to contact master data |
| fact_emails[From Department] -> dim_department[Department] | Many-to-One (inferred) | Inferred | Single (inferred) | Link sender department for aggregation |
| fact_emails[To Department] -> dim_department[Department] | Many-to-One (inferred) | Inferred | Single (inferred) | Link recipient department for aggregation |
| fact_emails[From seniority] -> dim_seniority[Seniority] | Many-to-One (inferred) | Inferred | Single (inferred) | Link sender seniority for analysis |
| fact_emails[To seniority] -> dim_seniority[Seniority] | Many-to-One (inferred) | Inferred | Single (inferred) | Link recipient seniority for analysis |
| fact_emails[Date] -> DateTableTemplate_1f35302b-2263-4042-953a-65232bf21c34[Date] | Many-to-One (inferred) | Inferred | Single (inferred) | Provide date context for time-based visuals |

#### 4.2.2 Data Dictionary by Core Table

**Table: fact_emails**
 
### 4.3 Report Design
#### 4.3.3 Measures definition and organization
The analytical layer is structured into logical display folders to differentiate between base metrics, time-intelligence overrides, and UI-specific dynamic titles. This modularity ensures the model remains scalable for self-service reporting.

| Display Folder | Purpose | Example Measures |
|---|---|---|
| _Measures (Core Analytics) | Base metrics and foundational KPIs | TotalEmailsSent, OpenedEmails, UnopenedEmails, TotalUniqueSenders, InfluenceScore |
| Dynamic Titles (UI Layer) | Context-aware dynamic labeling for visual headers | Selected Department, Selected Employee, Selected Seniority, Chart 1-6 |
| TopicGroup | Advanced topic-based aggregations | Emails by Topic Group |

**Measure Details by Logical Category**

#### TotalEmailsSent
**Business Logic:** Foundational metric providing absolute count of all email transactions within the fact table. Serves as denominator for rate calculations and baseline for comparative analysis. Respects all active slicers and filters within the reporting context.
```dax
COUNTROWS(fact_emails)
```
---

#### OpenedEmails
**Business Logic:** Identifies email transactions marked as "opened" by recipients. Critical for engagement analysis and delivery effectiveness assessment. Supports drill-down analysis by sender, recipient, department, and temporal dimensions.
```dax
CALCULATE(COUNTROWS(fact_emails), fact_emails[Is opened?] = "opened")
```
---

#### UnopenedEmails
**Business Logic:** Inverse metric capturing email transactions marked as "unopened". Complements OpenedEmails to provide complete engagement spectrum. Enables identification of communication barriers and recipient engagement gaps.
```dax
CALCULATE(COUNTROWS(fact_emails), fact_emails[Is opened?] = "unopened")
```
---

#### OpenRate
**Business Logic:** Derived ratio metric quantifying the proportion of opened emails relative to total sent. Expressed as decimal percentage (0.0 to 1.0) for normalized comparison across organizational units with varying email volumes. Denominator defaults to 0 when TotalEmailsSent is zero to prevent division errors.
```dax
DIVIDE([OpenedEmails], [TotalEmailsSent], 0)
```
---

#### UnopenedRate
**Business Logic:** Inverse engagement metric providing percentage of unopened emails. Useful for identifying communication bottlenecks and recipient responsiveness patterns. Complements OpenRate in dashboards focusing on engagement quality.
```dax
DIVIDE([UnopenedEmails], [TotalEmailsSent], 0)
```
---

#### TotalUniqueSenders
**Business Logic:** Count of distinct individuals originating email communications. Identifies active communication participants and organizational network density. Supports network health analysis and collaboration pattern identification.
```dax
DISTINCTCOUNT(fact_emails[From Name])
```
---

#### TotalUniqueReceivers
**Business Logic:** Count of distinct recipients across all email transactions. Captures breadth of communication distribution and organizational reach. Computed using ALLEXCEPT to isolate recipient dimension context while respecting global filters.
```dax
CALCULATE(
    COUNT(fact_emails[Email id]),
    ALLEXCEPT(fact_emails, fact_emails[To Name])
)
```
---

#### TotalEmailsReceivedBySeniority
**Business Logic:** Count of emails received by personnel, grouped by seniority classification. Employs USERELATIONSHIP to activate the inactive "To seniority" relationship, enabling analysis of how organizational hierarchy affects email volume distribution and communication patterns.
```dax
CALCULATE(
    COUNT(fact_emails[Email id]),
    USERELATIONSHIP(fact_emails[To seniority], dim_seniority[Seniority])
)
```
---

#### TotalEmailsReceivedByToName
**Business Logic:** Count of emails received by specific individuals. Activates the secondary recipient-based relationship to enable recipient-centric analysis independent of sender perspective. Supports workload analysis and communication load distribution assessment.
```dax
CALCULATE(
    COUNT(fact_emails[Email id]),
    USERELATIONSHIP(fact_emails[To Name], dim_contacts[Name])
)
```
---

#### TotalEmailsReceivedByToDepartment
**Business Logic:** Aggregate email volume received by departmental units. Utilizes USERELATIONSHIP to measure inbound communication flows to target departments. Essential for identifying interdepartmental communication patterns and departmental workload.
```dax
CALCULATE(
    COUNT(fact_emails[Email id]),
    USERELATIONSHIP(fact_emails[To Department], dim_department[Department])
)
```
---

#### TotalEmailsOpenedByToName
**Business Logic:** Count of opened emails received by specific individuals, combining recipient filtering with engagement status. Reveals recipient-level engagement quality and responsiveness patterns. Critical for performance management and communication effectiveness assessments.
```dax
CALCULATE(
    COUNT(fact_emails[Email id]), fact_emails[Is opened?] = "opened",
    USERELATIONSHIP(fact_emails[To Name], dim_contacts[Name])
)
```
---

#### TotalEmailsOpenedByToDepartment
**Business Logic:** Department-level aggregation of opened emails received. Measures inbound engagement quality by organizational unit. Supports departmental performance benchmarking and communication effectiveness analysis at the unit level.
```dax
CALCULATE(
    COUNT(fact_emails[Email id]), fact_emails[Is opened?] = "opened",
    USERELATIONSHIP(fact_emails[To Department], dim_department[Department])
)
```
---

#### InfluenceScore
**Business Logic:** Composite metric synthesizing outbound and inbound communication activity. Calculated as sum of emails sent plus emails received by an individual. Serves as proxy for organizational influence, network centrality, and communication prominence. Enables identification of key connectors and influential stakeholders.
```dax
[TotalEmailsSent] + [TotalEmailsReceivedByToName]
```
---

#### TotalPositiveSentimentEmails
**Business Logic:** Count of email transactions classified with positive sentiment. Captures constructive, collaborative, and affirmative communications. Enables sentiment distribution analysis and organizational tone assessment.
```dax
CALCULATE(
    COUNT(fact_emails[Email id]),
    fact_emails[Sentiment] = "Positive"
)
```
---

#### TotalNeutralSentimentEmails
**Business Logic:** Count of email transactions classified with neutral sentiment. Represents factual, transactional, or non-emotional communications. Essential for completing sentiment spectrum analysis and identifying communication tone variance.
```dax
CALCULATE(
    COUNT(fact_emails[Email id]),
    fact_emails[Sentiment] = "Neutral"
)
```
---

#### TotalNegativeSentimentEmails
**Business Logic:** Count of email transactions classified with negative sentiment. Identifies critical communications, conflicts, or dissatisfaction markers. Critical for organizational health monitoring and early warning systems for interpersonal issues.
```dax
CALCULATE(
    COUNT(fact_emails[Email id]),
    fact_emails[Sentiment] = "Negative"
)
```
---

#### PercentagePositiveSentiment
**Business Logic:** Ratio of positive sentiment emails to total email volume. Expressed as decimal percentage (0.0 to 1.0). Provides normalized sentiment quality metric enabling comparison across departments and time periods. Supports organizational culture assessment and communication quality benchmarking.
```dax
DIVIDE(
    [TotalPositiveSentimentEmails],
    [TotalEmailsSent],
    0
)
```
---

#### PercentageNeutralSentiment
**Business Logic:** Ratio of neutral sentiment emails to total email volume. Completes sentiment distribution analysis. Identifies predominantly transactional communication patterns within organizational units.
```dax
DIVIDE(
    [TotalNeutralSentimentEmails],
    [TotalEmailsSent],
    0
)
```
---

#### PercentageNegativeSentiment
**Business Logic:** Ratio of negative sentiment emails to total email volume. Expressed as decimal percentage. Serves as organizational health indicator and communication quality metric. Elevated values may indicate interpersonal conflicts, process breakdowns, or dissatisfaction requiring intervention.
```dax
DIVIDE(
    [TotalNegativeSentimentEmails],
    [TotalEmailsSent],
    0
)
```
---

#### DeptInfluenceScore
**Business Logic:** Department-level influence metric synthesizing outbound emails sent and inbound emails received by departmental units. Proxy for departmental communication prominence and cross-organizational dependency. Supports organizational structure analysis and strategic importance assessment.
```dax
[TotalEmailsSent] + [TotalEmailsReceivedByToDepartment]
```
---

#### SentRate
**Business Logic:** Ratio metric normalizing departmental email volume against total organizational email traffic. Expressed as decimal percentage. Identifies departments with disproportionate communication activity and enables workload distribution analysis. Useful for resource allocation and communication efficiency assessments.
```dax
DIVIDE([TotalEmailsSentByFromDepartment], [TotalEmailsSent], 0)
```
---

#### TotalEmailsSentByFromDepartment
**Business Logic:** Department-level count of outbound email transactions. Simple aggregation respecting departmental context established via From Department relationship. Baseline metric supporting departmental communication volume analysis.
```dax
CALCULATE(
    COUNT(fact_emails[Email id])
)
```
---

#### Avg Emails per Day
**Business Logic:** Average email volume per distinct calendar day. Computed as total emails divided by unique email dates within context. Supports trend analysis and capacity planning. Smooths day-to-day variance to identify underlying communication patterns and normal operating cadence.
```dax
DIVIDE([TotalEmailsSent], DISTINCTCOUNT(fact_emails[Date]))
```
---

#### TotalEmailsSentFromSeniority
**Business Logic:** Seniority-level aggregation of outbound emails. Utilizes USERELATIONSHIP to activate the sender seniority relationship. Reveals how organizational hierarchy influences communication patterns, identifying seniority-level communication norms and delegation patterns.
```dax
CALCULATE(
    COUNT(fact_emails[Email id]),
    USERELATIONSHIP(fact_emails[From seniority], dim_seniority[Seniority])
)
```
---

#### Selected Department
**Business Logic:** Dynamic title measure capturing the currently selected department value from slicer context. Returns "Departments" as default when no specific selection is active. Enables dynamic labeling of visual headers to reflect user-driven filtering state.
```dax
SELECTEDVALUE(dim_department[Department], "Departments")
```
---

#### Selected Employee
**Business Logic:** Dynamic title measure capturing the currently selected employee (sender) value. Returns "Employees" when no specific employee is selected. Supports context-aware visual labeling and drill-down hierarchy display.
```dax
SELECTEDVALUE(fact_emails[From Name], "Employees")
```
---

#### Selected Seniority
**Business Logic:** Dynamic title measure reflecting currently filtered seniority level. Returns "Seniority" as default placeholder. Enables real-time header updates responding to user interactions within seniority-based filters.
```dax
SELECTEDVALUE(dim_seniority[Seniority], "Seniority")
```
---

#### Selected Workday
**Business Logic:** Dynamic title measure capturing whether current filter context is restricted to workdays. Returns "All Workdays" when no specific filter is applied. Enables visual indication of temporal scope in report headers.
```dax
SELECTEDVALUE(fact_emails[Workday?], "All Workdays")
```
---

#### Selected Workhours
**Business Logic:** Dynamic title measure indicating whether analysis is scoped to working hours. Returns "All Workhours" as default. Provides visual feedback on temporal filtering state applied to fact data.
```dax
SELECTEDVALUE(fact_emails[WorkHours?], "All Workhours")
```
---

#### Selected Topic
**Business Logic:** Dynamic title measure reflecting currently selected email topic. Returns "Topics" as placeholder. Enables hierarchical drill-down visualization with context-aware header updates.
```dax
SELECTEDVALUE(fact_emails[Email topic], "Topics")
```
---

#### Selected Device
**Business Logic:** Dynamic title measure capturing currently filtered device type. Returns "Devices" when no specific device filter is active. Supports device-centric analysis visualization and context labeling.
```dax
SELECTEDVALUE(fact_emails[Device], "Devices")
```
---

#### Chart 1
**Business Logic:** Dynamic title for drill-down visualization showing temporal analysis path. Concatenates workday and work-hours selections. Displays hierarchical navigation trail: "Drill Down: [Workday] > [WorkHours]". Updates reactively as user navigates report hierarchy.
```dax
"Drill Down: " & [Selected Workday] & " > " & [Selected Workhours]
```
---

#### Chart 2
**Business Logic:** Dynamic title for drill-down visualization showing topic-employee analysis path. Concatenates topic and employee selections. Displays navigation trail: "Drill Down: [Topic] > [Employee]". Provides hierarchical context for topic and individual contributor analysis.
```dax
"Drill Down: " & [Selected Topic] & " > " & [Selected Employee]
```
---

#### Chart 3
**Business Logic:** Dynamic title for drill-down visualization showing department-seniority analysis path. Concatenates department and seniority selections. Displays: "Drill Down: [Department] > [Seniority]". Enables hierarchical organizational structure analysis.
```dax
"Drill Down: " & [Selected Department] & " > " & [Selected Seniority]
```
---

#### Chart 4
**Business Logic:** Dynamic title for complex drill-down visualization combining device, workday, and work-hours dimensions. Creates three-level navigation trail: "Drill Down: [Device] > [Workday] > [WorkHours]". Supports multi-dimensional temporal and device-based analysis.
```dax
"Drill Down: " & [Selected Device] & " > " & [Selected Workday] & " > " & [Selected Workhours]
```
---

#### Chart 5
**Business Logic:** Dynamic title for drill-down visualization showing department-employee analysis path. Concatenates department and employee selections. Displays: "Drill Down: [Department] > [Employee]". Enables organizational unit and individual contributor correlation analysis.
```dax
"Drill Down: " & [Selected Department] & " > " & [Selected Employee]
```
---

#### Chart 6
**Business Logic:** Dynamic title for drill-down visualization combining topic and seniority dimensions. Creates navigation trail: "Drill Down: [Topic] > [Seniority]". Supports topic-based organizational hierarchy analysis and seniority-level communication pattern studies.
```dax
"Drill Down: " & [Selected Topic] & " > " & [Selected Seniority]
```
---

#### Emails by Topic Group
**Business Logic:** Advanced measure implementing top-N filtering logic for email topics. Creates dynamic ranking of topics by email count, segregating top 3 topics and aggregating remaining as "Others". Returns email count for selected topic group category. Supports topic hierarchy visualization with variable granularity based on user selection. Respects active filters while establishing topic-specific context via ALLSELECTED.
```dax
VAR CurrentGroup = SELECTEDVALUE(TopicGroup[Group])

// Tạo bảng topic + count trong context hiện tại (respect slicers)
VAR TopicCounts =
    ADDCOLUMNS(
        SUMMARIZE(
            ALLSELECTED(fact_emails),
            fact_emails[Email topic - Short]
        ),
        "Cnt", CALCULATE(COUNTROWS(fact_emails))
    )

// Thêm cột Rank (dense rank theo Cnt)
VAR TopicWithRank =
    ADDCOLUMNS(
        TopicCounts,
        "Rank", RANKX(TopicCounts, [Cnt], , DESC, DENSE)
    )

VAR Top1 = SUMX( FILTER(TopicWithRank, [Rank] = 1), [Cnt] )
VAR Top2 = SUMX( FILTER(TopicWithRank, [Rank] = 2), [Cnt] )
VAR Top3 = SUMX( FILTER(TopicWithRank, [Rank] = 3), [Cnt] )
VAR Others = SUMX( FILTER(TopicWithRank, [Rank] > 3), [Cnt] )

RETURN
SWITCH(
    TRUE(),
    CurrentGroup = "Top 1", Top1,
    CurrentGroup = "Top 2", Top2,
    CurrentGroup = "Top 3", Top3,
    CurrentGroup = "Others", Others,
    BLANK()
)
```
---
DIVIDE([TotalEmailsSent], DISTINCTCOUNT(fact_emails[Date]))
```
---
#### TotalEmailsSentFromSeniority
**Business Logic:** Counts emails using sender seniority via an inactive seniority relationship.
```dax
CALCULATE(
                COUNT(fact_emails[Email id]),
                USERELATIONSHIP(fact_emails[From seniority], dim_seniority[Seniority])
            )
```
---
