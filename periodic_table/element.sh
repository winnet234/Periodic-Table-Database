#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
  if [[ $1 =~ [1-5] || $1 =~ [5-10] ]]
  then
    name=$($PSQL "SELECT name FROM elements WHERE atomic_number=$1;")
    symbol=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$1;")
    prop=$($PSQL "SELECT type_prop FROM properties WHERE atomic_number=$1;")
    mass=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$1;")
    melting=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$1;")
    boiling=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$1;")
    echo "The element with atomic number $1 is $(echo $name | sed -E 's/^ *| *$//g') ($(echo $symbol | sed -E 's/^ *| *$//g')). It's a $(echo $prop | sed -E 's/^ *| *$//g'), with a mass of $(echo $mass | sed -E 's/^ *| *$//g') amu. $(echo $name | sed -E 's/^ *| *$//g') has a melting point of $(echo $melting | sed -E 's/^ *| *$//g') celsius and a boiling point of $(echo $boiling | sed -E 's/^ *| *$//g') celsius."
  elif [[ $1 = "H" || $1 = "Be" || $1 = "B" || $1 = "C" || $1 = "N" || $1 = "O" || $1 = "F" || $1 = "Ne" || $1 = "He" || $1 = "Li" ]]
  then
    AN=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1';")
    name=$($PSQL "SELECT name FROM elements WHERE atomic_number=$AN;")
    prop=$($PSQL "SELECT type_prop FROM properties WHERE atomic_number=$AN;")
    mass=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$AN;")
    melting=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$AN;")
    boiling=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$AN;")
    echo "The element with atomic number $(echo $AN | sed -E 's/^ *| *$//g') is $(echo $name | sed -E 's/^ *| *$//g') ($1). It's a $(echo $prop | sed -E 's/^ *| *$//g'), with a mass of $(echo $mass | sed -E 's/^ *| *$//g') amu. $(echo $name | sed -E 's/^ *| *$//g') has a melting point of $(echo $melting | sed -E 's/^ *| *$//g') celsius and a boiling point of $(echo $boiling | sed -E 's/^ *| *$//g') celsius."
  elif [[ $1 = "Hydrogen" || $1 = "Beryllium" || $1 = "Boron" || $1 = "Carbon" || $1 = "Nitrogen" || $1 = "Oxygen" || $1 = "Fluorine" || $1 = "Neon" || $1 = "Helium" || $1 = "Lithium" ]]
  then
    AN=$($PSQL "SELECT atomic_number FROM elements WHERE name='$1';")
    symbol=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$AN;")
    prop=$($PSQL "SELECT type_prop FROM properties WHERE atomic_number=$AN;")
    mass=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$AN;")
    melting=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$AN;")
    boiling=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$AN;")
    echo "The element with atomic number $(echo $AN | sed -E 's/^ *| *$//g') is $(echo $1 | sed -E 's/^ *| *$//g') ($(echo $symbol | sed -E 's/^ *| *$//g')). It's a $(echo $prop | sed -E 's/^ *| *$//g'), with a mass of $(echo $mass | sed -E 's/^ *| *$//g') amu. $(echo $1 | sed -E 's/^ *| *$//g') has a melting point of $(echo $melting | sed -E 's/^ *| *$//g') celsius and a boiling point of $(echo $boiling | sed -E 's/^ *| *$//g') celsius."
  else
    echo "I could not find that element in the database."
  fi
fi
