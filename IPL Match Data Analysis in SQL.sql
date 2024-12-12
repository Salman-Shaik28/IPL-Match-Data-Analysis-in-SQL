create database ipl;
use ipl;

DESC DELIVERIES;

select * from deliveries;

#1. Write a query to list all deliveries with their match_id, inning, over, and ball.

#SALMAN SHAIK
SELECT match_id, inning, 
deliveries.over, ball 
FROM deliveries;

#2. Write a query to display all columns for deliveries bowled by a specific bowler, J Bumrah.

#SALMAN SHAIK
SELECT * FROM DELIVERIES 
WHERE BOWLER="JJ Bumrah";

#3. Write a query to list deliveries where the batting_team is Mumbai Indians.

#SALMAN SHAIK
SELECT * FROM DELIVERIES WHERE BATTING_TEAM="Mumbai Indians";

#4. Write a query to find all deliveries where the batsman scored more than 4 runs off a single ball.

#SALMAN SHAIK
SELECT * FROM DELIVERIES WHERE BATSMAN_RUNS>4;

#5. Write a query to count the total number of deliveries in the dataset.

 #SALMAN SHAIK
 SELECT COUNT(*) as Count_of_Total_Deliveries 
 FROM DELIVERIES;
 
 #6. Write a query to find the average number of runs scored per over.
 
 #SALMAN SHAIK
 SELECT DELIVERIES.OVER,
 AVG(TOTAL_RUNS) AS AVERAGE_RUNS 
 FROM DELIVERIES 
 GROUP BY DELIVERIES.OVER;
 
 #7. Write a query to list the top 5 batsmen with the highest total runs scored.
 
 #SALMAN SHAIK
 SELECT BATSMAN,
 SUM(BATSMAN_RUNS) AS RUNS 
 FROM DELIVERIES 
 GROUP BY BATSMAN 
 ORDER BY RUNS DESC 
 LIMIT 5;
 
 #8. Write a query to list all pairs of bowlers who bowled in the same match. Include columns for match_id, bowler1, and bowler2.
 
 #SALMAN SHAIK
 SELECT DISTINCT(D1.MATCH_ID),
 D1.BOWLER AS BOWLER_1,
 D2.BOWLER AS BOWLER_2
 FROM DELIVERIES AS D1
 JOIN DELIVERIES AS D2 
 ON D1.MATCH_ID=D2.MATCH_ID 
 AND D1.BOWLER<>D2.BOWLER;
 
 #9. Write a query to find the total number of deliveries bowled by each bowler. Display bowler and the count of deliveries.
 
 #SALMAN SHAIK
 SELECT BOWLER,
 COUNT(BALL) AS Number_of_Deliveries 
 FROM DELIVERIES 
 GROUP BY BOWLER 
 ORDER BY Number_of_Deliveries DESC;
 
 #10. Write a query using a CASE statement to categorize deliveries into three categories based on runs scored: Dot Ball for 0 runs, 
 #Single for 1 run, and Multiple for more than 1 run.
 
 #SALMAN SHAIK
 SELECT BATSMAN, BOWLER, BATSMAN_RUNS,
 CASE 
 WHEN BATSMAN_RUNS=0 THEN "Dot Ball"
 WHEN BATSMAN_RUNS=1 THEN "Single"
 WHEN BATSMAN_RUNS>1 THEN "Multiple"
END AS Categories
FROM DELIVERIES;
 
#11. Write a query to add a new column is_boundary to the deliveries table that indicates if the delivery resulted in a boundary (4 or 6 runs).

#SALMAN SHAIK
ALTER TABLE DELIVERIES ADD COLUMN(Is_Boundary char(3));
UPDATE DELIVERIES SET Is_Boundary="No" where BATSMAN_RUNS<>4 OR BATSMAN_RUNS<>6;
UPDATE DELIVERIES SET Is_Boundary="Yes" where BATSMAN_RUNS=4 OR BATSMAN_RUNS=6;
SELECT * FROM DELIVERIES;

#12. Write a query using an advanced function to find the over with the highest total runs scored.

#SALMAN SHAIK
WITH CT1 AS 
(
SELECT MATCH_ID,DELIVERIES.OVER,
SUM(TOTAL_RUNS) AS RUNS
FROM DELIVERIES 
GROUP BY MATCH_ID,DELIVERIES.OVER 
ORDER BY SUM(TOTAL_RUNS) DESC 
LIMIT 1
)
SELECT * FROM CT1;

#13. Create a view named HighScoringOvers that includes overs where the total runs scored are more than 15.

#SALMAN SHAIK
CREATE VIEW HighScoringOvers AS 
(
SELECT MATCH_ID,DELIVERIES.OVER,
SUM(TOTAL_RUNS) AS RUNS 
FROM DELIVERIES 
GROUP BY MATCH_ID,DELIVERIES.OVER 
HAVING SUM(TOTAL_RUNS)>15
);
SELECT * FROM HIGHSCORINGOVERS;

#14. Write a query using a window function to rank deliveries based on their total_runs within each match_id.

#SALMAN SHAIK
WITH CT1 AS (
SELECT MATCH_ID, DELIVERIES.OVER,
SUM(TOTAL_RUNS) AS Total_Runs
FROM DELIVERIES 
GROUP BY MATCH_ID,DELIVERIES.OVER
)
SELECT dense_rank() 
OVER(PARTITION BY MATCH_ID ORDER BY Total_Runs) AS RANKING ,
MATCH_ID, CT1.OVER, Total_runs AS Total_Runs
FROM CT1;

#15. Write a query to calculate the cumulative count of runs scored in each match sorted by over.

#SALMAN SHAIK
SELECT MATCH_ID, DELIVERIES.OVER, SUM(TOTAL_RUNS) 
OVER(partition by MATCH_ID,inning ORDER BY DELIVERIES.OVER) AS CUMULATIVE_COUNT 
FROM DELIVERIES;

#16. Write a stored procedure to update the runs scored on a delivery given its match_id, inning, over, ball, and new runs.

#SALMAN SHAIK
DELIMITER $$

CREATE PROCEDURE UpdateRunsOnDelivery(
    IN p_match_id INT,
    IN p_inning INT,
    IN p_over INT,
    IN p_ball INT,
    IN p_new_runs INT
)
BEGIN
    -- Update the runs scored on the specified delivery
    UPDATE DELIVERIES
    SET TOTAL_RUNS = p_new_runs
    WHERE MATCH_ID = p_match_id
    AND INNING = p_inning
    AND DELIVERIES.OVER = p_over
    AND BALL = p_ball;
    
    -- Optionally, you can return a message indicating success
    SELECT 'Runs updated successfully' AS Message;
END$$

DELIMITER ;

#17. Write a query to find the bowler with the highest average runs conceded per over. Use subqueries and aggregate functions to achieve this.

#SALMAN SHAIK
SELECT BOWLER,AVG(RUNS) AS AVG_Runs
FROM (
SELECT MATCH_ID, BOWLER, DELIVERIES.OVER,
SUM(TOTAL_RUNS) AS RUNS 
FROM DELIVERIES 
GROUP BY MATCH_ID,BOWLER,DELIVERIES.OVER
) AS TMP GROUP BY BOWLER
ORDER BY Avg_RUNS DESC LIMIT 1;

#18. Write a query to find pairs of deliveries in the same over where one delivery resulted in more runs than the other. 
#Display columns for match_id, inning, over, ball1, runs1, ball2, and runs2.

#SALMAN SHAIK
SELECT B1.MATCH_ID,
B1.INNING,B1.OVER,
B1.BALL AS BALL_1,
B1.TOTAL_RUNS AS RUNS_1,
B2.BALL AS BALL_2,
B2.TOTAL_RUNS AS RUNS_2
FROM DELIVERIES AS B1
JOIN DELIVERIES AS B2 
ON B1.MATCH_ID=B2.MATCH_ID 
AND B1.INNING=B2.INNING 
AND B1.OVER=B2.OVER
AND B1.TOTAL_RUNS > B2.TOTAL_RUNS
AND B1.BALL <>B2.BALL;