#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
  then
    echo "Please provide an element as an argument."
  else
    if [[ "$1" =~ ^-?[0-9]+$ ]]
      then
        ELEMENT=$($PSQL "SELECT * FROM elements FULL JOIN properties USING(atomic_number) FULL JOIN types USING(type_id) WHERE atomic_number=$1;")
        if [[ -z $ELEMENT ]] 
        then
          echo "I could not find that element in the database."
        else
          echo $ELEMENT | while IFS="|" read TYPE_ID ATOMIC_NUMBER SYMBOL NAME ATOMIC_MASS MELT_POINT BOIL_POINT TYPE
            do
              echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELT_POINT celsius and a boiling point of $BOIL_POINT celsius."
            done
        fi
      else
        if [[ ${#1} > 2 ]]
          then
            ELEMENT=$($PSQL "SELECT * FROM elements FULL JOIN properties USING(atomic_number) FULL JOIN types USING(type_id) WHERE name='$1';")
              if [[ -z $ELEMENT ]] 
                then
                  echo "I could not find that element in the database."
                else
                  echo $ELEMENT | while IFS="|" read TYPE_ID ATOMIC_NUMBER SYMBOL NAME ATOMIC_MASS MELT_POINT BOIL_POINT TYPE
                    do
                      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELT_POINT celsius and a boiling point of $BOIL_POINT celsius."
                    done
                fi
          else 
            ELEMENT=$($PSQL "SELECT * FROM elements FULL JOIN properties USING(atomic_number) FULL JOIN types USING(type_id) WHERE symbol='$1';")
                if [[ -z $ELEMENT ]] 
                  then
                    echo "I could not find that element in the database."
                  else
                    echo $ELEMENT | while IFS="|" read TYPE_ID ATOMIC_NUMBER SYMBOL NAME ATOMIC_MASS MELT_POINT BOIL_POINT TYPE
                      do
                        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELT_POINT celsius and a boiling point of $BOIL_POINT celsius."
                      done
                fi
          fi
    fi
fi