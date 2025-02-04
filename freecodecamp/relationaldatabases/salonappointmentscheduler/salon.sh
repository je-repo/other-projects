#! /bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --no-align --tuples-only -c"

SERVICES_OVERVIEW=$($PSQL "SELECT * FROM services ORDER BY service_id;")

echo -e "\n~~~~~ My Salon ~~~~~"

SERVICE_MENU() {
  # if argument passed to function
  if [[ $1 ]]
  then
    # print argument
    echo -e "$1\n"
  fi

  echo -e "\nHow can I help you?\n"
  
  # print service options
  echo "$SERVICES_OVERVIEW" | sed 's/|/) /'

  # get user input
  read SERVICE_ID_SELECTED  

  # if user input is not a number
  if [[ ! $SERVICE_ID_SELECTED =~ ^[0-9]+$ ]]
  then
    # return to service options
    SERVICE_MENU "\nPlease enter a valid number."
  else
    # check, if service exists
    SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED;")

    if [[ ! $SERVICE_NAME ]]
    then
      # if service doesn't exist, return to service menu
      SERVICE_MENU "\nThe number entered is not associated with a service."
    else
      # ask for a phone number, and a time for the appointment (CUSTOMER_PHONE, SERVICE_TIME)
      echo -e "\nPlease enter your phone number."
      read CUSTOMER_PHONE

      CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE';")

      if [[ -z $CUSTOMER_ID ]]
      then
        # ask for a name, if they aren't already a customer (CUSTOMER_NAME)
        echo -e "\nWhat is your name?"
        read CUSTOMER_NAME
        # create a new row in customers with the given name and phone number
        INSERT_NEW_CUSTOMER=$($PSQL "INSERT INTO customers (name, phone) VALUES ('$CUSTOMER_NAME', '$CUSTOMER_PHONE');")
        CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE';")
      fi

      echo -e "\nWhat time should we set the appointment?"
      read SERVICE_TIME

      # create a new row in the appointments table with the relevant service_id and customer_id
      INSERT_NEW_APPOINTMENT=$($PSQL "INSERT INTO appointments (customer_id, service_id, time) VALUES ($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME');")

      if [[ $INSERT_NEW_APPOINTMENT ]]
      then
        CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE customer_id=$CUSTOMER_ID;")

        # after an appointment is successfully added output the message "I have put you down for a <service> at <time>, <name>."
        echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
      fi

    fi

  fi

}



SERVICE_MENU 