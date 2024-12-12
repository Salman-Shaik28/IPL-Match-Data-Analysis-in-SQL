# IPL Match Data Analysis Using MySQL

**Project Overview**

This project focuses on analyzing IPL match data using MySQL, providing insights into player performances, team strategies, and match dynamics. By utilizing advanced SQL techniques, the project explores key metrics such as top batsmen, high-scoring overs, and bowler efficiency, offering a comprehensive understanding of the data.

**Features**

Detailed delivery-level analysis

Player and team performance metrics

Advanced SQL techniques: subqueries, window functions, CASE statements, and stored procedures

Views and cumulative calculations for dynamic insights

**Dataset**

The dataset contains delivery-level information, including match ID, innings, overs, balls, runs scored, and player details. It serves as a granular foundation for extracting insights into IPL matches.

**Key SQL Queries**

**List All Deliveries**: Retrieve match_id, inning, over, and ball for all deliveries.

**Deliveries by Bowler**: Display all deliveries bowled by J Bumrah.

**Mumbai Indians Deliveries**: List deliveries where the batting team is "Mumbai Indians."

**High-Scoring Deliveries**: Identify deliveries with more than 4 runs scored.

**Total Deliveries Count**: Count the total deliveries in the dataset.

**Average Runs per Over**: Calculate average runs scored per over.

**Top 5 Batsmen**: List batsmen with the highest total runs scored.

**Bowler Pairs**: Identify pairs of bowlers who bowled in the same match.

**Total Deliveries by Bowler**: Count deliveries bowled by each bowler.

**Delivery Categorization**: Categorize deliveries as "Dot Ball," "Single," or "Multiple."

**Boundary Indicator**: Add a column to indicate deliveries resulting in boundaries.

**Over with Highest Runs**: Find the over with the highest total runs scored.

**High-Scoring Overs View**: Create a view for overs with runs exceeding 15.

**Rank Deliveries**: Rank deliveries by total runs within each match using a window function.

**Cumulative Runs**: Calculate cumulative runs scored in each match sorted by over.

**Update Runs Procedure**: Create a stored procedure to update runs scored on a delivery.

**Bowler Efficiency**: Identify the bowler with the highest average runs conceded per over.

**Delivery Pairs in Same Over**: Find pairs of deliveries in the same over with varying runs.

**Tools and Techniques**

**Database Management**: MySQL

**SQL Techniques**: Subqueries, window functions, stored procedures, aggregate functions, CASE statements

**How to Run**

Clone the repository:

git clone https://github.com/Salman-Shaik28/IPL-Match-Data-Analysis-in-SQL

Import the dataset into MySQL.

Run the SQL scripts provided in the /queries folder to explore insights.

**Author**

Shaik Salman
GitHub: Salman-Shaik28

