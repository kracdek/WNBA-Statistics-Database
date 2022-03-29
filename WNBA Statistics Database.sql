-- Using the top level system database--
Use master;


-- Code to create the database 
CREATE DATABASE WNBAStats;
USE WNBAStats;


-- Creation of tables within the database
CREATE TABLE Teams
	(TeamID INT NOT NULL PRIMARY KEY, 
    TeamName VARCHAR(50) NOT NULL);

CREATE TABLE Season
	(SeasonID INT NOT NULL PRIMARY KEY, 
    SeasonYear INT NULL);

CREATE TABLE Coaches
	(CoachID INT NOT NULL PRIMARY KEY, 
    TeamID INT NOT NULL REFERENCES Teams(TeamID), 
    SeasonID INT NOT NULL REFERENCES Season(SeasonID), 
    C_Firstname VARCHAR(50) NULL, 
    C_Lastname VARCHAR(50) NULL);
    
CREATE TABLE Players
	(PlayerID INT NOT NULL PRIMARY KEY,
    TeamID INT NOT NULL REFERENCES Teams(TeamID),
    SeasonID INT NOT NULL REFERENCES Season(SeasonID),
    P_Firstname VARCHAR(50) NULL,
    P_Lastname VARCHAR(50) NULL,
    Age INT NULL);

CREATE TABLE Gmaes
	(GameID INT NOT NULL PRIMARY KEY,
    DatePlayed INT NOT NULL,
    G_Points NUMERIC(4,1) NULL,
    G_Rebounds NUMERIC (4,1) NULL,
    G_Assists NUMERIC (4,1) NULL,
    G_Turnovers NUMERIC (4,1) NULL,
    G_Blocks NUMERIC (4,1) NULL,
    G_Steals NUMERIC (4,1) NULL,
    G_Minutes NUMERIC (4,1) NULL,
    G_FGPct NUMERIC (4,1) NULL,
    G_3PTct NUMERIC (4,1) NULL,
    G_FTct NUMERIC (4,1) NULL);
    
CREATE TABLE Player_Averages
	(PlayerAverageID INT NOT NULL PRIMARY KEY,
    PlayerID INT NOT NULL REFERENCES Players(PlayerID),
    P_Points NUMERIC(4,1) NULL,
    P_Rebounds NUMERIC (4,1) NULL,
    P_Assists NUMERIC (4,1) NULL,
    P_Turnovers NUMERIC (4,1) NULL,
    P_Blocks NUMERIC (4,1) NULL,
    P_Steals NUMERIC (4,1) NULL,
    P_Minutes NUMERIC (4,1) NULL,
    P_FGPct NUMERIC (4,1) NULL,
    P_3PTct NUMERIC (4,1) NULL,
    P_FTct NUMERIC (4,1) NULL);
    
CREATE TABLE Teams_In_Games
	(TeamGameID INT NOT NULL PRIMARY KEY,
    TeamsID INT NOT NULL REFERENCES Teams(TeamID),
    GameID INT NOT NULL REFERENCES Games(GameID));
    
    
-- Creation of indexes to retrieve the data from the abovementioned tables quickly.
CREATE INDEX IX_Teams_TeamID
	ON Teams(TeamID);
CREATE INDEX IX_Teams_TeamName
	ON Teams(TeamName);
CREATE INDEX IX_Season_SeasonID
	ON Season(SeasonID);
CREATE INDEX IX_Coaches_CoachID
	ON Coaches(CoachID);
CREATE INDEX IX_Coaches_C_LastName
	ON Coaches(C_LastName);
CREATE INDEX IX_Players_PlayerID
	ON Players(PlayerID);
CREATE INDEX IX_Players_P_LastName
	ON Players(P_LastName);
CREATE INDEX IX_Games_GameID
	ON Games(GameID);
CREATE INDEX IX_Player_Averages_PlayerAverageID
	ON Player_Averages(PlayerAverageID);


-- Inserting data into the Teams table
USE WNBAStats;
INSERT INTO Teams(TeamID, TeamName)
	VALUES (1,'Washington Mystics');
INSERT INTO Teams(TeamID, TeamName)
	VALUES (2,'Seattle Storm');
INSERT INTO Teams(TeamID, TeamName)
	VALUES (3,'Phoenix Mercury');
INSERT INTO Teams(TeamID, TeamName)
	VALUES (4,'New York Liberty');
INSERT INTO Teams(TeamID, TeamName)
	VALUES (5,'Minnesota Lynx');
INSERT INTO Teams(TeamID, TeamName)
	VALUES (6,'Los Angeles Sparks');
INSERT INTO Teams(TeamID, TeamName)
	VALUES (7,'Las Vegas Aces');
INSERT INTO Teams(TeamID, TeamName)
	VALUES (8,'Indiana Fever');
INSERT INTO Teams(TeamID, TeamName)
	VALUES (9,'Dallas Wings');
INSERT INTO Teams(TeamID, TeamName)
	VALUES (10,'Connecticut Sun');
INSERT INTO Teams(TeamID, TeamName)
	VALUES (11,'Chicago Sky');
INSERT INTO Teams(TeamID, TeamName)
	VALUES (12,'Atlanta Dream');


-- Insert data into the Season table
USE WNBAStats;
INSERT INTO Season(SeasonID, SeasonYear)
VALUES(1, '2021');


-- Insert data into Coaches table.
USE WNBAStats;
INSERT INTO Coaches(CoachID, TeamID, SeasonID, C_FirstName, C_LastName)
	VALUES (10, 1, 1,'Mike', 'Thibault');
INSERT INTO Coaches(CoachID, TeamID, SeasonID, C_FirstName, C_LastName)
	VALUES (20, 2, 1, 'Noelle', 'Quinn');
INSERT INTO Coaches(CoachID, TeamID, SeasonID, C_FirstName, C_LastName)
	VALUES (30, 3, 1, 'Sandy', 'Bordello');
INSERT INTO Coaches (CoachID, TeamID, SeasonID, C_FirstName, C_LastName)
	VALUES (40, 4, 1, 'Walt', 'Hopkins');
INSERT INTO Coaches(CoachID, TeamID, SeasonID, C_FirstName, C_LastName)
	VALUES (50, 5, 1, 'Cheryl', 'Reeve');
INSERT INTO Coaches(CoachID, TeamID, SeasonID, C_FirstName, C_LastName)
	VALUES (60, 6, 1, 'Derek', 'Fisher');
INSERT INTO Coaches(CoachID, TeamID, SeasonID, C_FirstName, C_LastName)
	VALUES (70, 7, 1, 'Bill', 'Laimbeer');
INSERT INTO Coaches(CoachID, TeamID, SeasonID, C_FirstName, C_LastName)
	VALUES (80, 8, 1, 'Marianne', 'Stanley');
INSERT INTO Coaches(CoachID, TeamID, SeasonID, C_FirstName, C_LastName)
	VALUES (90, 9, 1, 'Vickie', 'Johnson');
INSERT INTO Coaches(CoachID, TeamID, SeasonID, C_FirstName, C_LastName)
	VALUES (100, 10, 1, 'Curt', 'Miller');
INSERT INTO Coaches(CoachID, TeamID, SeasonID, C_FirstName, C_LastName)
	VALUES (110, 11, 1, 'James', 'Wade');
INSERT INTO Coaches(CoachID, TeamID, SeasonID, C_FirstName, C_LastName)
	VALUES (120, 12, 1, 'Mike', 'Petersen');


-- Creating a view to present the tables Player_Averages & Players
CREATE VIEW PlayerAvgs
AS
SELECT p.PlayerID, P_FirstName, P_LastName P_Points, P_Rebounds, P_Assists, P_Turnovers, P_Blocks, P_Steals
FROM Player_Averages pa 
JOIN Players p 
ON pa.PlayerID = p.PlayerID
WHERE P_Points > 10;


-- Creating a view to present the table Coaches
CREATE VIEW CoachInfo
AS
SELECT CoachID, C_FirstName, C_LastName, SeasonID
FROM Coaches;


-- Creating a view to present the table Games
CREATE VIEW GameInfo
AS
SELECT GameID, 
	DatePlayed, 
    G_Points, 
    G_Rebounds, 
    G_Assists, 
    G_Turnovers, 
    G_Blocks, 
    G_Steals
FROM Games;


-- Creating a view to present the table Players
CREATE VIEW PlayerInfo
AS
SELECT PlayerID, 
	TeamID, 
	P_FirstName, 
	P_LastName, 
	Age
FROM Players;


-- Creating a view to present
CREATE VIEW SeasonInfo
AS
SELECT SeasonID, SeasonYear
FROM Season;


-- Creating a view to present
CREATE VIEW TeamInfo
AS
SELECT TeamID, TeamName
FROM Teams;


-- Creating a view to present
CREATE VIEW TeamsInGamesInfo
AS
SELECT DatePlayed, 
	TeamGameID, 
    t.TeamID, 
    g.GameID, 
    TeamName
FROM Teams_In_Games tig 
JOIN Teams t 
ON tig.TeamID = t.TeamID
JOIN Games g 
ON g.GameID = tig.GameID;


-- Ratio is used to evaluate the teams ball control and handling skills while measuring the team's effectiveness in keeping possession of the ball.
USE WNBAStats;
SELECT TeamName, 
	DatePlayed, 
    g.GameID, 
    (g.G_Steals/ G_Turnovers) AS StealsToTurnovers
FROM Teams t 
JOIN Teams_In_Games tim 
ON t.TeamID = tim.TeamID
JOIN Games g 
ON tim.GameID = G.GameID
WHERE G_Turnovers IS NOT NULL
GROUP BY TeamName, DatePlayed, g.GameID, (g.G_Steals/ G_Turnovers)
HAVING (g.G_Steals/ G_Turnovers) > 0
ORDER BY StealsToTurnovers DESC;


-- Stat to measure the ball possession efficiency of ball handlers.
USE WNBAStats;
SELECT CONCAT(P_FirstName, ' ', P_LastName) AS PlayerName, 
	TeamName, (P_Assists + P_Steals) - P_Turnovers AS PlayerEconomy
FROM Players p 
JOIN Teams t 
ON p.TeamID = t.TeamID
JOIN Player_Averages pa 
ON p.PlayerID = pa.PlayerID
WHERE (P_Assists + P_Steals) - P_Turnovers > 0
ORDER BY PlayerEconomy DESC;


-- Creating a stored procedure to quickly reference the Teams, Players and Player_Averages and execute based on the condition of the player being greater than age 30.
USE WNBAStats;
CREATE PROC spPlayersReport
AS
SELECT TeamName,
	CONCAT(P_FirstName, ' ' , P_LastName) AS PlayerName,
	Age, 
	P_Points, 
	P_Rebounds, 
	P_Assists, 
	P_Turnovers, 
	P_Blocks, 
	P_Steals, 
	P_Minutes, 
	P_FGPct, 
	P_3PTPct, 
	P_FTPct
FROM Teams t 
JOIN Players p 
ON t.TeamID = p.TeamID
JOIN Player_Averages pa 
ON pa.PlayerID = p.PlayerID
WHERE Age > 30
ORDER BY Age DESC;
