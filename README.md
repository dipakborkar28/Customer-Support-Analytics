# Customer Support & Service Analytics

## Project Overview

Customer Support & Service Analytics is a SQL-based data analytics
project designed to help a company understand its customer support
operations and identify areas where service performance can be improved.

The project analyzes customer tickets, support agents, responses,
and customer feedback to generate meaningful business insights.

The analysis covers ticket volume, resolution performance,
response time, customer satisfaction, agent performance,
and support-category trends.

## Business Problem

Customer support teams generate a large amount of operational data
through customer tickets, support agents, responses, and feedback.

However, raw support data alone does not clearly show where the
service is performing well or where improvements are needed.

This project uses SQL to answer important business questions such as:

- Which support categories receive the most tickets?
- Which agents handle the most tickets?
- What is the overall ticket resolution rate?
- Which categories take the longest to resolve?
- Which agents have the best customer satisfaction?
- Which customers have repeated unresolved issues?
- Which departments have the highest workload?
- Which agents have the best overall performance?

The goal is to turn raw customer-support data into actionable
insights that can help improve service quality and operational
efficiency.

## Database Structure

The project uses a relational database consisting of five tables:

| Table | Description |
|---|---|
| `customers` | Stores customer details such as name, city, and signup date. |
| `agents` | Stores support agent details and their departments. |
| `tickets` | Stores customer support tickets, including category, priority, status, and resolution dates. |
| `responses` | Stores responses made to support tickets, including response type and response time. |
| `feedback` | Stores customer ratings and feedback dates for resolved tickets. |

### Table Relationships

- One customer can submit many tickets.
- One support agent can handle many tickets.
- One ticket can have multiple responses.
- One ticket can have customer feedback.

The database follows these relationships:

Customers → Tickets ← Agents

Tickets → Responses

Tickets → Feedback


## SQL Concepts Used

This project demonstrates practical SQL concepts used in real-world
data analysis, including:

- SELECT, WHERE, ORDER BY, and LIMIT
- Aggregate functions: COUNT, SUM, AVG, MIN, MAX
- GROUP BY and HAVING
- CASE statements
- INNER JOIN and multi-table JOINs
- Subqueries
- Common Table Expressions (CTEs)
- Window functions
- RANK and other ranking techniques
- Conditional aggregation
- Date calculations using DATEDIFF
- NULL handling
- Percentage and performance calculations
- Data filtering and business-rule based analysis 

## Business Questions

The analysis answers 30 business questions related to customer support
operations and service performance.

### Ticket & Category Analysis
1. Which support category receives the highest number of tickets?
2. Which support agents handle the most tickets?
3. Which support agents have the highest number of resolved tickets?
4. What percentage of all tickets are resolved?
5. What is the average number of days it takes to resolve a ticket?
6. Which support category has the longest average resolution time?
7. Which customers have submitted the most tickets?
8. Which customers have the most unresolved tickets?
9. Which support priority has the most tickets?
10. What is the average response time by response type?

### Agent & Department Performance
11. Which agent has the fastest average response time?
12. Which department handles the most tickets?
13. Which department has the highest average response time?
14. Which ticket priority has the highest average response time?
15. Which support agent has the highest average customer rating?
16. Which support category has the highest average customer rating?
17. Which support agent has the highest average resolution time?
18. Which support agent has both a high average rating (≥ 4) and at least 2 resolved tickets?
19. Which customers have submitted more than 1 ticket and have at least 1 unresolved ticket?
20. Which customers have an average ticket rating higher than the overall average rating?

### Advanced Performance Analysis
21. Which support category has both below-average customer satisfaction and above-average resolution time?
22. Which agents have a higher average customer rating than the average rating of their department?
23. Which agents handle more tickets than the average number of tickets handled by agents in their department?
24. Which support agents have the highest resolution rate?
25. Which agents have a higher resolution rate than the average resolution rate of their department?
26. Which support categories have a resolution rate below the overall resolution rate?
27. Which support categories have an average customer rating below the overall average customer rating?
28. Rank all support agents by their resolution rate, highest to lowest.
29. Rank support categories by their average resolution time, from longest to shortest.
30. Which support agent has the best overall performance, considering both resolution rate and customer satisfaction?

## Project Structure

```text
Customer-Support-Analytics/
│
├── README.md
│
├── 01_database_setup.sql
│
├── 02_data_insertion.sql
│
├── 03_business_analysis.sql
│
└── screenshots/

## Key Insights

The analysis of customer support data revealed several important
operational insights:

- **83.33% of tickets were resolved**, while 16.67% remained open.
- **Technical and General support categories received the highest
  number of tickets**, with 8 tickets each.
- **Rani submitted the most tickets** among the customers in the dataset.
- **High-priority tickets** represented the largest share of support
  requests.
- Response-time analysis showed a clear difference between **AI and
  Human responses**.
- Agent performance varied across **ticket workload, resolution rate,
  response time, and customer satisfaction**.
- The analysis identified customers with **repeated tickets and
  unresolved issues**, which can help support teams prioritize
  follow-ups.
- Category-level analysis compared **customer satisfaction with
  resolution time** to identify areas that may require operational
  improvement.

  ## How to Run the Project

### Prerequisites

- MySQL Server
- MySQL Workbench

### Steps

1. Clone or download this repository.

2. Open MySQL Workbench and connect to your MySQL server.

3. Run `01_database_setup.sql` to:
   - Create the `customer_support_analytics` database.
   - Create the five project tables.

4. Run `02_data_insertion.sql` to insert the sample data.

5. Run `03_business_analysis.sql` to execute the 30 business analysis
   queries.

6. Review the query results in MySQL Workbench.

## Tools & Technologies

- **Database:** MySQL
- **SQL Environment:** MySQL Workbench
- **Version Control:** Git & GitHub

## Conclusion

This project demonstrates how SQL can be used to transform customer
support data into meaningful business insights.

By analyzing tickets, agents, responses, and customer feedback, the
project evaluates support workload, resolution performance, response
time, and customer satisfaction.

The analysis can help a customer support team identify performance
gaps, prioritize unresolved issues, and make data-driven decisions to
improve service quality and operational efficiency.

## Author

**Dipak**

this is first ever sql project so this might be not the best 
but it take one step further to my goal.