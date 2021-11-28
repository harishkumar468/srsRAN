# CMake generated Testfile for 
# Source directory: /home/grads/h/harishkumar003/Desktop/srsRAN/srsue/src
# Build directory: /home/grads/h/harishkumar003/Desktop/srsRAN/build/srsue/src
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(srsue_version "srsue" "--version")
add_test(srsue_help "srsue" "--help")
add_test(ue_rf_failure "srsue" "/home/grads/h/harishkumar003/Desktop/srsRAN/srsue/ue.conf.example" "--rf.device_name=zmq")
add_test(ue_rf_failure_max_channels "srsue" "/home/grads/h/harishkumar003/Desktop/srsRAN/srsue/ue.conf.example" "--rf.device_name=zmq" "--rf.nof_antennas=4" "--rat.eutra.nof_carriers=5")
add_test(ue_rf_failure_exceeds_channels "srsue" "/home/grads/h/harishkumar003/Desktop/srsRAN/srsue/ue.conf.example" "--rf.device_name=zmq" "--rf.nof_antennas=5" "--rat.eutra.nof_carriers=5")
subdirs("phy")
subdirs("stack")
subdirs("test")
