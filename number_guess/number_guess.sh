#!/bin/bash

# =========== database information ============
# create table users(
#   user_id serial primary key, 
#   name varchar(22) unique not null,
#   games_played int not null default 0, 
#   best_game int default NULL
# );
# =============================================

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

# random a secret number
SECRET_NUMBER=$(( RANDOM % 1000 + 1))

# guess counter
GUESS_COUNT=0

START_GAME() {
  # request a username
  echo "Enter your username: "
  read USERNAME

  # query database for this username
  USER_ID=$($PSQL "select user_id from users where name = '$USERNAME'")

  if [[ -n $USER_ID ]]
  then
    # if the user exists, echo "Welcome back, <username>! You have played <games_played> games, and your best game took <best_game> guesses."
    # query user's game info
    GAME_INFO=$($PSQL "select games_played, best_game from users where user_id=$USER_ID")

    IFS="|" read GAMES_PLAYED BEST_GAME <<< "$GAME_INFO"

    echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
  else
    # if this is a new user, echo "Welcome, <username>! It looks like this is your first time here."

    echo "Welcome, $USERNAME! It looks like this is your first time here."
    # add this user to database
    INSERT_RESULT=$($PSQL "insert into users(name) values('$USERNAME')")
    if [[ $INSERT_RESULT != "INSERT 0 1" ]]
    then
      echo "Add user <$USERNAME> failed."
    fi
    GAMES_PLAYED=0
  fi
}

RUN_GAME() {
  READ_NUMBER
  # NOTE: if you want to use [[ ]], use `-eq`, `-gt` and `-lt` do the compare 
  if (( $NUMBER == $SECRET_NUMBER ))
  then
    echo "You guessed it in $GUESS_COUNT tries. The secret number was $SECRET_NUMBER. Nice job!"
    # update user's game information
    UPDATE_INFORMATION
  elif (( $NUMBER > $SECRET_NUMBER ))
  then
    echo "It's lower than that, guess again:"
    RUN_GAME
  else 
    echo "It's higher than that, guess again:"
    RUN_GAME
  fi
}

READ_NUMBER() {
  GUESS_COUNT=$(( GUESS_COUNT + 1 ))
  read NUMBER
  if [[ ! $NUMBER =~ ^[0-9]+$ ]]
  then
    echo "That is not an integer, guess again:"
    READ_NUMBER
  fi
}

UPDATE_INFORMATION() {
  # update user's information
  GAMES_PLAYED=$(( GAMES_PLAYED + 1 ))
  if [[ -z $BEST_GAME ]] || (( $GUESS_COUNT < $BEST_GAME ))
  then
    BEST_GAME=$GUESS_COUNT
  fi
  UPDATE_RESULT=$($PSQL "update users set games_played=$GAMES_PLAYED, best_game=$BEST_GAME WHERE name='$USERNAME'")
}

START_GAME
echo "Guess the secret number between 1 and 1000:"
RUN_GAME
