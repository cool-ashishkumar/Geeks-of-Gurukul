Use bet;


-- Frequency of Play
SELECT src_player_id, AVG(ActivePlayerDays) AS Avg_Active_Days
FROM player_activity_data
GROUP BY src_player_id;

-- Average Bet Amount
SELECT src_player_id, AVG(Bet_Amount) AS Avg_Bet_Amount
FROM player_activity_data
GROUP BY src_player_id;

-- Types of Games Played
SELECT Product, SubProduct, COUNT(DISTINCT src_player_id) AS Player_Count
FROM player_activity_data
GROUP BY Product, SubProduct;


-- Calculate necessary metrics for clustering
SELECT src_player_id, 
       AVG(Bet_Amount) AS Avg_Bet_Amount, 
       AVG(ActivePlayerDays) AS Avg_Active_Days
FROM player_activity_data
GROUP BY src_player_id;

-- Conversion from signup to first bet
SELECT COUNT(DISTINCT p.Src_Player_Id) AS Total_Signups,
       COUNT(DISTINCT f.Src_Player_Id) AS First_Bet_Players
FROM player_details p
LEFT JOIN first_bet_data f ON p.Src_Player_Id = f.Src_Player_Id;

-- Conversion from signup to first deposit
SELECT COUNT(DISTINCT p.Src_Player_Id) AS Total_Signups,
       COUNT(DISTINCT d.Src_Player_Id) AS First_Deposit_Players
FROM player_details p
LEFT JOIN first_deposit_data d ON p.Src_Player_Id = d.Src_Player_Id;

-- Retention analysis
SELECT src_player_id, COUNT(DISTINCT ActivityMonth) AS Active_Months
FROM player_activity_data
GROUP BY src_player_id;

-- Popular games/products
SELECT Product, COUNT(DISTINCT src_player_id) AS Player_Count, SUM(Bet_Amount) AS Total_Bet_Amount
FROM player_activity_data
GROUP BY Product;

-- Suspicious activity
SELECT src_player_id, SUM(Bet_Amount) AS Total_Bet_Amount, SUM(Win_Amount) AS Total_Win_Amount
FROM player_activity_data
GROUP BY src_player_id
HAVING Total_Win_Amount > Total_Bet_Amount * 2;

-- Risk-averse players
SELECT src_player_id, AVG(Bet_Amount) AS Avg_Bet_Amount, COUNT(ActivityMonth) AS Active_Months
FROM player_activity_data
GROUP BY src_player_id
HAVING Avg_Bet_Amount < 100 AND Active_Months > 6;

-- Player preferences
SELECT Product, COUNT(DISTINCT src_player_id) AS Player_Count
FROM player_activity_data
GROUP BY Product;

-- Spending patterns for subscription model
SELECT src_player_id, SUM(Bet_Amount) AS Total_Spend, AVG(Bet_Amount) AS Avg_Spend
FROM player_activity_data
GROUP BY src_player_id;

-- User growth
SELECT COUNT(DISTINCT src_player_id) AS New_Players, ActivityMonth
FROM player_activity_data
GROUP BY ActivityMonth;

-- Revenue trends
SELECT SUM(Bet_Amount) AS Total_Bet_Amount, SUM(Win_Amount) AS Total_Win_Amount, ActivityMonth
FROM player_activity_data
GROUP BY ActivityMonth;
