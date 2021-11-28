# CMake generated Testfile for 
# Source directory: /home/grads/h/harishkumar003/Desktop/srsRAN/srsue/src/phy/test
# Build directory: /home/grads/h/harishkumar003/Desktop/srsRAN/build/srsue/src/phy/test
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(scell_search_test "scell_search_test" "--duration=5" "--cell.nof_prb=6" "--active_cell_list=2,3,4,5,6" "--simulation_cell_list=1,2,3,4,5,6" "--channel_period_s=30" "--channel.hst.fd=750" "--channel.delay_max=10000" "--intra_freq_meas_period_ms=199")
set_tests_properties(scell_search_test PROPERTIES  LABELS "lte;srsue;phy")
add_test(nr_cell_search_test "nr_cell_search_test" "--duration=1" "--ssb_period=20" "--meas_period_ms=20" "--meas_len_ms=1" "--simulation_cell_list=500")
set_tests_properties(nr_cell_search_test PROPERTIES  LABELS "nr;srsue;phy")
add_test(nr_cell_search_test_delay "nr_cell_search_test" "--duration=1" "--ssb_period=20" "--meas_period_ms=100" "--meas_len_ms=30" "--channel.delay_min=0" "--channel.delay_max=1000" "--simulation_cell_list=500")
set_tests_properties(nr_cell_search_test_delay PROPERTIES  LABELS "nr;srsue;phy")
