#!/bin/bash
#create by rd: Rishat Dilmurat

#find corresponding chk,log,com and pbs files  


for f in `ls -d *_ligands`
#for f in 01_01_ligands
do

#create files corresponding to number of molecule
#how many molecule you have

echo ${f}
cd ${f}

for ex in {1..10}
do

cp -r ../TrEsp_py3 ${ex}/${ex}/ 
mv ${ex}/tddft.chk ${ex}/${ex}/TrEsp_py3/
cp ${ex}/${ex}/tddft.log ${ex}/${ex}/TrEsp_py3/tddft.VisuEsp.log
cp ${ex}/${ex}/tddft.gesp ${ex}/${ex}/TrEsp_py3/
cp ../xyz/${f}.xyz ${ex}/${ex}/TrEsp_py3/tddft.xyz
#cp ../xyz/00_DoubleHelix_unoptimized.xyz ${ex}/${ex}/TrEsp_py3/tddft.xyz


#cd ${ex}/${ex}
cd ${ex}/${ex}/TrEsp_py3/
./try_.sh
cd ../../../


done

cd ..

done

