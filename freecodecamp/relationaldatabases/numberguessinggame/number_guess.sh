#!/bin/bash

RANDOM_NUMBER() {
  # Check 2 arguments are being passed
  if [[ -z $1 ]] || [[ -z $2 ]]
  then
    echo "Require 2 integers as range to generate random number from.\nFirst integer is minimum and second integer is maximum.\nBoth numbers are inclusive."
  else
    shuf -i $1-$2 -n1
  fi
}


NUMBER_GUESSING_GAME() {
  # SQL query template
  PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

  # Prompt for user name
  echo Enter your username:

  read USERNAME

  USER_DATA=$($PSQL "SELECT user_id, name, COUNT(guesses) AS games_played, MIN(guesses) AS best_guess FROM users LEFT JOIN games USING(user_id) WHERE name='$USERNAME' GROUP BY user_id, name;")
  IFS='|' read USER_ID NAME GAMES_PLAYED BEST_GUESS <<< $USER_DATA

  # Check, if existing user
  if [[ -z $USER_DATA ]]
  then
    # If new user, add them to database
    ADD_NEW_USER=$($PSQL "INSERT INTO users (name) VALUES ('$USERNAME');")

    # Pull new user's id for game record insertion later
    USER_ID=$($PSQL "SELECT user_id FROM users WHERE name='$USERNAME';")

    # Print: Welcome, <username>! It looks like this is your first time here.
    echo Welcome, $USERNAME! It looks like this is your first time here.

  else
    # set best guess to 0, if it is empty
    if [[ -z $BEST_GUESS ]]
    then
      BEST_GUESS=0
    fi

    # If existing user, print:
    # "Welcome back, <username>! You have played <games_played> games, and your best game took <best_game> guesses."
    echo Welcome back, $NAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GUESS guesses.

  fi

  # Generate secret number between 1 and 1000
  SECRET_NUMBER=$(RANDOM_NUMBER 1 1000)

  # Print Guess the secret number between 1 and 1000:
  echo Guess the secret number between 1 and 1000:

  # Declare variable with number of guesses
  # Starts at 1, as the game starts with 1 guess
  GUESSES=1

  # Prompt user to input their guess
  read USER_GUESS

  while [ $USER_GUESS != $SECRET_NUMBER ]
  do
    # Check whether input was higher or lower than secret number
    if [[ $USER_GUESS =~ [^0-9] ]] 
    then 
      # If non-integer is input as guess, print "That is not an integer, guess again:"
      echo That is not an integer, guess again:
      read USER_GUESS

    elif [[ $USER_GUESS -gt $SECRET_NUMBER ]]
    then
      # If input was higher than secret number, print "It's lower than that, guess again:" and prompt for input
      echo It\'s lower than that, guess again:
      read USER_GUESS

    elif [[ $USER_GUESS -lt $SECRET_NUMBER ]]
    then
      # If input was lower than secret number, print "It's higher than that, guess again:" and prompt for input
      echo It\'s higher than that, guess again:
      read USER_GUESS
    
    fi

    GUESSES=$((GUESSES + 1))
  done

  # Upon guessing the secret number, insert game record into database
  INSERT_GAME_RECORD=$($PSQL "INSERT INTO games (user_id, guesses) VALUES ($USER_ID, $GUESSES);")

  # When secret number is guessed, print "You guessed it in <number_of_guesses> tries. The secret number was <secret_number>. Nice job!"
  echo You guessed it in $GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!

}


NUMBER_GUESSING_GAME
