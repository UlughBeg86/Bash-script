# Bash-script
Please feel free to email me at rishat.dilmurat@gmail.com if you have any questions regarding Bash and *.pbs scripts. 
Mail: rishat.dilmurat@gmail.com
Automation of Circular Dichroism (CD) Spectra Calculation
Please refer to the following articles:
1. Loco, D., Jurinovich, S., Di Bari, L. and Mennucci, B., 2016. A fast but accurate excitonic simulation of the electronic circular dichroism of nucleic acids: how can it be achieved?. Physical Chemistry Chemical Physics, 18(2), pp.866-877.
2. Shiraogawa, T., Ehara, M., Jurinovich, S., Cupellini, L. and Mennucci, B., 2018. Frenkel‐exciton decomposition analysis of circular dichroism and circularly polarized luminescence for multichromophoric systems. Journal of Computational Chemistry, 39(16), pp.931-935.


Due to the multi-step calculations, each step involves a relatively large number of computations (20 ligands in our case) that need to be submitted. It is necessary to automate the entire process. Therefore, I wrote simple Bash scripts to automate all the calculations. Please note that the Python and Fortran scripts are not my own; they were developed by the research scientists at the Laboratory for Chemistry of Novel Materials at Université de Mons.

Please make sure that each bash script is executable. If not you may use the following command first. chmod +x "script.sh" or "script.bash". Please see the example folder for CD calculation.
1) ./gaussian.bash (please make sure the hemme.uy file contains all of *.com files for submission)
2) please submit the general_array.pbs file for TD calculations. In our case 10 ES are considered for diagonalization of cells. For instance using "qsub general_array.pbs" to submit the calculations to the cluster. NOTE: it is an array job not a single job. If the cluster does not support array script you may modify the script and you can always modify the script to adapt to your cluster or machine.
3) ./01_create_CD.sh Please be sure that *.log files terminated successfully. For checking, Please use a simple bash script to check them.
4) ./02_create_CD.sh
5) ./03_create_CD.sh
Note: Please always adopt the script to your current situation.
   
   
