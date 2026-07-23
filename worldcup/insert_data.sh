#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

# drop table
DROP_TABLE() {
  if [[ $1 ]]
  then
    $PSQL "drop table if exists $1 cascade"
  fi
}

# create table 
CREATE_TABLE_GAMES() {
  CREATE_TABLE_RESULT=$($PSQL "create table games(game_id serial primary key, \
                                  year int not null, \
                                  round varchar(30) not null, \
                                  winner_id int not null references teams(team_id), \
                                  opponent_id int not null references teams(team_id), \
                                  winner_goals int not null, \
                                  opponent_goals int not null)")
  if [[ CREATE_TABLE_RESULT == "CREATE TABLE" ]]
  then
    echo "create table games success."
  else
    echo "create table games failed."
    return 1
  fi
}

CREATE_TABLE_TEAMS() {
  CREATE_TABLE_RESULT=$($PSQL "create table teams(team_id serial primary key, name varchar(50) not null unique)")
  if [[ CREATE_TABLE_RESULT == "CREATE TABLE" ]]
  then
    echo "create table teams success."
  else 
    echo "create table temas failed"
    return 1
  fi
}

# insert data to teams and games
INSERT_DATA() {

  cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
  do
    if [[ $YEAR != year ]]
    then
      # get winner id
      WINNER_ID=$($PSQL "select team_id from teams where name='$WINNER'")
      # if not found
      if [[ -z $WINNER_ID ]]
      then
        # insert winner to teams
        INSERT_RESULT=$($PSQL "insert into teams (name) values ('$WINNER')")
        if [[ $INSERT_RESULT == "INSERT 0 1" ]]
        then
          echo "Inserted to teams: $WINNER"
        else
          echo "Insert $WINNER to teams failed."
        fi
        # get new winner id
        WINNER_ID=$($PSQL "select team_id from teams where name='$WINNER'")
      fi

      # get opponent id
      OPPONENT_ID=$($PSQL "select team_id from teams where name='$OPPONENT'")
      # if not found
      if [[ -z $OPPONENT_ID ]]
      then
        # insert opponent to teams
        INSERT_RESULT=$($PSQL "insert into teams (name) values ('$OPPONENT')")
        if [[ $INSERT_RESULT == "INSERT 0 1" ]]
        then
          echo "Inserted to teams: $OPPONENT"
        else
          echo "Insert $OPPONENT to teams failed."
        fi
        # get new opponent id
        OPPONENT_ID=$($PSQL "select team_id from teams where name='$OPPONENT'")
      fi

      # insert data to games
      INSERT_RESULT=$($PSQL "insert into games (year, round, winner_id, opponent_id, winner_goals, opponent_goals) values($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)")
      if [[ $INSERT_RESULT != "INSERT 0 1" ]]
      then
        echo "Insert ($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS) to games failed."
      fi
    fi
  done

}

DROP_TABLE teams
CREATE_TABLE_TEAMS
DROP_TABLE games
CREATE_TABLE_GAMES

sleep 1

INSERT_DATA
