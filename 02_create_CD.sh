#!/bin/bash
#create by RD: Rishat Dilmurat

#find corresponding chk,log,com and pbs files  


for f in `ls -d *_ligands`
do

#create files corresponding to number of molecule
#how many molecule you have
echo $f
cd $f

for ex in {1..10}
do
cd ${ex}

mv ${ex}.chk tddft.chk

mkdir ${ex}


echo "%Nproc=4" > a
echo "%oldChk=tddft.chk" >> a
echo "%nosave" >> a
echo "#p geom=allcheck chkbas guess=(read,only) nosymm pop=(minimal,mk) integral=ultrafine IOp(6/17=2) IOp(6/22=-14) IOp(6/29=${ex}) Iop(6/50=1,6/41=10,6/42=10,6/33=1)" >> a
echo " " >> a
echo "tddft.gesp" >> a
echo " " >> a

mv a ${ex}/tddft.com 
cp ../../gesp.pbs ${ex}/

cd ${ex}

qsub gesp.pbs

cd ../..


done

cd ..

done

