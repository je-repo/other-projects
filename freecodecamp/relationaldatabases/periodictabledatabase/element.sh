# Function declaration
ELEMENT_SEARCH() {
  # Declare PSQL variable with database query string
  PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

  # Check if argument is number
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    # Use atomic number to query database tables elements, properties and types for 
    # atomic_number, name, symbol, type, atomic_mass, melting_point_celsius and boiling_point_celsius
    QUERY_RESULT=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements LEFT JOIN properties USING(atomic_number) LEFT JOIN types USING(type_id) WHERE atomic_number=$1;")

  # Check if argument is symbol (max. 2 characters)
  elif [[ $1 =~ ^[A-Z][a-z]?$ ]]
  then
    # Use symbol to query database tables elements, properties and types 
    # for atomic_number, name, symbol, type, atomic_mass, melting_point_celsius and boiling_point_celsius
    QUERY_RESULT=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements LEFT JOIN properties USING(atomic_number) LEFT JOIN types USING(type_id) WHERE symbol='$1';")

  # Check if argument is element name (max. 40 characters)
  elif [[ $1 =~ ^[A-Z][a-z]* ]]
  then 
    # Use name to query database tables elements, properties and types for 
    # atomic_number, name, symbol, type, atomic_mass, melting_point_celsius and boiling_point_celsius
    QUERY_RESULT=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements LEFT JOIN properties USING(atomic_number) LEFT JOIN types USING(type_id) WHERE name='$1';")
  fi

  # If query result is empty
  if [[ -z $QUERY_RESULT ]]
  then
    # Output text "I could not find that element in the database."
    echo "I could not find that element in the database."
  else  

    # Using read, given single-rowed output
    IFS='|' read ATMOIC_NUMBER NAME SYMBOL TYPE ATMOIC_MASS MELTING_POINT_CELSIUS BOILING_POINT_CELSIUS <<< $QUERY_RESULT    
    # Output text "The element with atomic number <atomic_number> is <name> (<symbol>). 
    # It's a <type>, with a mass of <atomic_mass> amu. 
    # <name> has a melting point of <melting_point_celsius> celsius and a 
    # boiling point of <boiling_point_celsius_ celsius."
    echo The element with atomic number $ATMOIC_NUMBER is $NAME \($SYMBOL\). It\'s a $TYPE, with a mass of $ATMOIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius.
    
    # Alternate scalable option using while loop
    # echo "$QUERY_RESULT" | while IFS='|' read ATMOIC_NUMBER NAME SYMBOL TYPE ATMOIC_MASS MELTING_POINT_CELSIUS BOILING_POINT_CELSIUS;
    # do
    #   # Output text "The element with atomic number <atomic_number> is <name> (<symbol>). 
    #   # It's a <type>, with a mass of <atomic_mass> amu. 
    #   # <name> has a melting point of <melting_point_celsius> celsius and a 
    #   # boiling point of <boiling_point_celsius_ celsius."
    #   echo The element with atomic number $ATMOIC_NUMBER is $NAME \($SYMBOL\). It\'s a $TYPE, with a mass of $ATMOIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius.
    # done
  fi
}

# Check, if argument passed
if [[ -z $1 ]]
then
  # Print below text, if no argument
  echo "Please provide an element as an argument."
else
  # Call below function, if argument passed
  ELEMENT_SEARCH $1
fi