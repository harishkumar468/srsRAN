# CMake generated Testfile for 
# Source directory: /home/grads/h/harishkumar003/Desktop/srsRAN/lib/test/pdcp
# Build directory: /home/grads/h/harishkumar003/Desktop/srsRAN/build/lib/test/pdcp
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(pdcp_nr_test_tx "pdcp_nr_test_tx")
set_tests_properties(pdcp_nr_test_tx PROPERTIES  LABELS "nr;lib;pdcp")
add_test(pdcp_nr_test_rx "pdcp_nr_test_rx")
set_tests_properties(pdcp_nr_test_rx PROPERTIES  LABELS "nr;lib;pdcp")
add_test(pdcp_nr_test_discard_sdu "pdcp_nr_test_discard_sdu")
set_tests_properties(pdcp_nr_test_discard_sdu PROPERTIES  LABELS "nr;lib;pdcp")
add_test(pdcp_lte_test_rx "pdcp_lte_test_rx")
add_test(pdcp_lte_test_discard_sdu "pdcp_lte_test_discard_sdu")
add_test(pdcp_lte_test_status_report "pdcp_lte_test_status_report")
