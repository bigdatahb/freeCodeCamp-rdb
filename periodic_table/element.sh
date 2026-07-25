#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

ARGS=$1

if [[ -z $ARGS ]]
then
  echo -e "Please provide an element as an argument."
else
  # parse args
  if [[ $ARGS =~ ^[0-9]+$ ]]; then
    # args is atomic number
    ATOMIC_NUMBER=$ARGS
    # get symbol and name from elements
    ELEMENTS=$($PSQL "select symbol, name from elements where atomic_number=$ATOMIC_NUMBER")
    if [[ -z $ELEMENTS ]]
    then
      # if not found
      echo "I could not find that element in the database."
      # program should be over
      END=1
    else
      # read symbol and name
      IFS="|" read SYMBOL NAME <<< "$ELEMENTS"
    fi
  else
    # args is symbol or name
    # get atomic number
    ATOMIC_NUMBER=$($PSQL "select atomic_number from elements where symbol='$ARGS' or name='$ARGS'")
    if [[ -z $ATOMIC_NUMBER ]]
    then
      # not found
      echo "I could not find that element in the database."
      # program should be over
      END=1
    else
      # get symbol and name by atomic number
      ELEMENTS=$($PSQL "select symbol, name from elements where atomic_number=$ATOMIC_NUMBER")
      # the elements always exist
      IFS="|" read SYMBOL NAME <<< "$ELEMENTS"
    fi
  fi

  # if element exists
  if [[ ! $END ]]
  then 
    # query type, atomic mass, melting point and boiling point
    PROPERTIES=$($PSQL "select type, atomic_mass, melting_point_celsius, boiling_point_celsius from types inner join properties using(type_id) where atomic_number=$ATOMIC_NUMBER")

    IFS="|" read TYPE ATOMIC_MASS MELTING_POINT_CELSIUS BOILING_POINT_CELSIUS <<< "$PROPERTIES"

    echo -e "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
  fi
fi
