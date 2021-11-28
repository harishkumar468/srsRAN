# CMake generated Testfile for 
# Source directory: /home/grads/h/harishkumar003/Desktop/srsRAN/srsenb/test/mac
# Build directory: /home/grads/h/harishkumar003/Desktop/srsRAN/build/srsenb/test/mac
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(sched_grid_test "sched_grid_test")
add_test(sched_test_rand "sched_test_rand")
add_test(sched_ca_test "sched_ca_test")
add_test(sched_lc_ch_test "sched_lc_ch_test")
add_test(sched_tpc_test "sched_tpc_test")
add_test(sched_dci_test "sched_dci_test")
add_test(sched_ue_cell_test "sched_ue_cell_test")
add_test(sched_benchmark_test "sched_benchmark_test")
add_test(sched_cqi_test "sched_cqi_test")
add_test(sched_phy_resource_test "sched_phy_resource_test")
subdirs("nr")
