#!/bin/bash

echo -e "\n~~~~~ MY SALON ~~~~~\n"

echo -e "Welcome to My Salon, how can I help you?\n"

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

INIT_SERVICES() {
  SERVICES=$($PSQL "select name from services")
  if [[ -z $SERVICES ]]
  then
    # truncate table
    $PSQL "truncate services,appointments,customers" > /dev/null
    # reset the serial
    $PSQL "select setval('services_service_id_seq', 1, false)" > /dev/null
    # insert services
    $PSQL "insert into services(name) values('cut'), ('color'), ('perm'), ('style'), ('trim')" > /dev/null
  fi
}

MAIN_MENU() {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi

  # show services (query from services table)
  SERVICES=$($PSQL "select service_id, name from services order by service_id")

  if [[ -z $SERVICES ]]
  then
    echo "Sorry, there is no service now."
  else
    echo "$SERVICES" | while read SERVICE_ID BAR SERVICE_NAME
    do
      echo -e "$SERVICE_ID) $SERVICE_NAME"
    done

    echo -e "Please select a service id:"

    read SERVICE_ID_SELECTED
    case $SERVICE_ID_SELECTED in 
      1) DO_SERVICE 1 ;;
      2) DO_SERVICE 2 ;;
      3) DO_SERVICE 3 ;;
      4) DO_SERVICE 4 ;;
      5) DO_SERVICE 5 ;;
      *) MAIN_MENU "I could not find that service. What would you like today?"
    esac
  fi
}

DO_SERVICE() {
  if [[ $1 ]]
  then
    # query service name by service id $1 is the service id
    SERVICE_NAME=$($PSQL "select name from services where service_id=$1")
    if [[ -z $SERVICE_NAME ]]
    then
      MAIN_MENU "Sorry, we don't have this service now.($1)"
    fi
    echo -e "\nWhat's your phone number?"
    read CUSTOMER_PHONE
    # get customer name
    CUSTOMER_INFO=$($PSQL "select customer_id, name from customers where phone='$CUSTOMER_PHONE'")
    read CUSTOMER_ID BAR CUSTOMER_NAME <<< "$CUSTOMER_INFO"
    # if customer don't exist
    if [[ -z $CUSTOMER_NAME ]]
    then
      # ask for name
      echo -e "\nI don't have a record for that phone number, what's your name?"
      read CUSTOMER_NAME
      # insert new customer
      INSERT_CUSTOMER_RESULT=$($PSQL "insert into customers(phone, name) values('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
    fi

    # get customer id
    if [[ -z $CUSTOMER_ID ]]
    then
      # query customer id
      CUSTOMER_ID=$($PSQL "select customer_id from customers where name='$CUSTOMER_NAME'")
    fi

    # trim space starting and ending of SERVICE_NAME
    SERVICE_NAME=$(echo $SERVICE_NAME | sed -E 's/^ *| *$//g')
    echo -e "\nWhat time would you like your $SERVICE_NAME, $CUSTOMER_NAME?"
    read SERVICE_TIME
    # insert an appointment
    $PSQL "insert into appointments (customer_id, service_id, time) values($CUSTOMER_ID, $1, '$SERVICE_TIME')" > /dev/null

    echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
  fi
}

INIT_SERVICES

MAIN_MENU
