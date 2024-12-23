#!/bin/bash
# create by rishat


echo "Your POSCAR file:"
read poscar
echo -e "\e[33mName of POSCAR file: ${poscar}\e[0m"

#convert to unix line endings
dos2unix "${poscar}"

echo "How many atoms you are going to frozen:"
read frozenatoms
echo -e "\e[33mWe are going to freeze: ${frozenatoms}\e[0m"


headd=$(head -8 "$poscar")
head -8 "$poscar" > headd
elmts=$(grep -B 2 "Cartesian" "${poscar}" | head -2 )

#read each line
mapfile -t line  <<< "${elmts}"

#split the clm, and find number of the clms
read -r -a columns <<< "${line[0]}"


rows=2; cols=${#columns[@]}
declare -a matrix

#-------------------------------------------------------------------------------------

tot_line=0
for ((i = 0; i < rows; i++));
  do

  read -r -a columns <<< "${line[i]}"
  for ((j = 0; j < cols; j++));
  do
    ind=$((i * cols + j))
    matrix[ind]=${columns[j]}
    if [ "$i" -eq 1 ]
      then
              tot_line=$((tot_line+matrix[ind]))
              echo $tot_line
    fi
  done
done

#-------------------------------------------------------------------------------------

#play with geometries of each elemets

tot_num=${#matrix[@]}
bgn=$((tot_num/rows))

echo -e "\e[33mTotal atoms: $tot_line  |  Matrix starts with: $bgn\e[0m"


geo=$(grep -A ${tot_line} "Cartesian" "${poscar}" | tail -${tot_line})

head -${matrix[bgn]} <<< ${geo} > "${matrix[0]}"

if [ "$cols" -gt 1 ]
   then
     CH=$((tot_line-"${matrix[bgn]}"))
     tail -${CH}  <<< ${geo} > "${matrix[1]}"
fi

#sorted the substrade refering to z direction

sort -k3,3nr ${matrix[0]} > sorted_${matrix[0]}


activeatoms=$(("${matrix[bgn]}"-frozenatoms))


for ((i = 0; i < "${matrix[bgn]}"; i++))
do
    if [ $i -lt $activeatoms ]
       then
           echo T T T
    else
           echo F F F
    fi

done > TF

paste "sorted_${matrix[0]}" TF > "sorted_${matrix[0]}_TF"


#---------------------create new POSCAR-------------------------------

if [ "$cols" -gt 1 ]
   then
      cat headd sorted_${matrix[0]}_TF ${matrix[1]} > POSCAR
   else
      cat headd sorted_${matrix[0]}_TF  > POSCAR
fi


rm headd "sorted_${matrix[0]}_TF" TF



