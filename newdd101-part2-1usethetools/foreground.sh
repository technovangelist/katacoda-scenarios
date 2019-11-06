touch test.txt
env | tee -a test.txt
wall $(env)
