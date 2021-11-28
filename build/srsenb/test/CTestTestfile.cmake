# CMake generated Testfile for 
# Source directory: /home/grads/h/harishkumar003/Desktop/srsRAN/srsenb/test
# Build directory: /home/grads/h/harishkumar003/Desktop/srsRAN/build/srsenb/test
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(enb_metrics_test "enb_metrics_test" "-o" "/home/grads/h/harishkumar003/Desktop/srsRAN/build/srsenb/test/enb_metrics.csv")
subdirs("mac")
subdirs("phy")
subdirs("upper")
subdirs("rrc")
subdirs("s1ap")
subdirs("ngap")
