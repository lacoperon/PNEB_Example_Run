export CUDA_VISIBLE_DEVICES=0,1,2,3

mpirun -np 32 $AMBERHOME/bin/pmemd.cuda.MPI -ng 32 -groupfile groupfile_second_half.in
