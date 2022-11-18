#!/usr/bin/env bash

#Define the string value
textFile=obi.temp.txt

# Set space as the delimiter
IFS='|$'

#Read the split words into an array based on space delimiter
###readarray -t strarr < $textFile
strarr=($(< $textFile))

#Count the total words
echo "There are ${#strarr[*]} lines in that text."

# Print each value of the array by using the loop
j=0
for i in "${strarr[*]}";do
  printf "$i"|sed 's/Changes: //' > my.obi.${j}
  jq < my.obi.${j}
  ((j=i+1))
done
###echo "${strarr[5]}"|sed 's/Changes: //' > mytemp0
###jq < mytemp0
