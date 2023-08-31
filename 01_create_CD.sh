#!/bin/bash
#create by RD: Rishat Dilmurat

#find corresponding chk,log,com and pbs files  


for i in `ls *.chk`
do
  f=${i%.*}
  mkdir $f 
  echo $f 
  if [ ! -f tddft.chk ] 
  then
#      echo "File not found!"
#      echo "let me cp to chk file into tddft.chk(:="
#      chk=$(ls ${i})
#      mv ${i} ${f}/tddft.chk
      cp ${f}.chk ${f}/tddft.chk
      cp ${f}.log ${f}/tddft.log
      cp ${f}.com ${f}/tddft.com
      cp tddft.pbs ${f}/
  else
      echo "tddft.chk File exists!" 
  fi

#create files corresponding to number of molecule
#how many molecules you have

cd $f



for ex in {1..10}
do
mkdir ${ex}

echo "%Nproc=4" > a
echo "%oldChk=tddft.chk" >> a
echo "%Chk=${ex}.chk" >> a
echo "# WB97XD/6-31g(d,p) Geom=AllCheck Guess=(Read,Only) Density=(Check,Transition=${ex})" >> a
echo " " >> a
echo "TDDFT.com" >> a
echo " " >> a
echo "0 1" >> a
echo " " >> a

mv a ${ex}/${ex}.com 
cp tddft.chk ${ex}/tddft.chk
cp tddft.pbs ${ex}/

#cp tddft.log ${ex}/tddft.log

cd ${ex}

sed -i "s/NAME/${ex}/g" tddft.pbs

qsub tddft.pbs

cd ..


done

cd ..

done


fol=${f#*_}


for i in *_${fol}
do
echo "------,$i"
done


