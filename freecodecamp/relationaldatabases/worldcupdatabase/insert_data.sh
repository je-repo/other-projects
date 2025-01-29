#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

# Clear tables
echo $($PSQL "TRUNCATE TABLE games, teams;")

# First while loop reading games.csv into variables
cat "games.csv" | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do 

# If statement checking for first (title) row
  if [[ $YEAR != 'year' ]]
  then

# Let WINNER_ID and OPPONENT_ID variables
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER';")
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT';")

# If WINNER_ID is empty
    if [[ -z $WINNER_ID ]]
    then

# Variable inserting WINNER name into teams table
      INSERT_WINNER=$($PSQL "INSERT INTO teams (name) VALUES ('$WINNER');")

# echo WINNER insert message
      if [[ $INSERT_WINNER == 'INSERT 0 1' ]]
      then
        echo Inserted into teams, $WINNER '(winner)'
      fi

# Query new WINNER_ID
      WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER';")
    
    fi

# If OPPONENT_ID is empty
    if [[ -z $OPPONENT_ID ]]
    then

# Variable inserting OPPONENT name into teams table
    INSERT_OPPONENT=$($PSQL "INSERT INTO teams (name) VALUES ('$OPPONENT');")

# echo OPPONENT insert message
    if [[ $INSERT_OPPONENT = 'INSERT 0 1' ]]
    then
      echo Inserted into teams, $OPPONENT '(opponent)'
    fi
# Query new OPPONENT_ID
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT';")

    fi

# Insert row into games table
    INSERT_GAMES_ROW=$($PSQL "INSERT INTO games (year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES ($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS);")

# echo games row insert message (if variable = 'INSERT 0 1' print insert message with column values)
    echo Inserted into games, $YEAR $ROUND $WINNER_ID $OPPONENT_ID $WINNER_GOALS $OPPONENT_GOALS
  fi

done

