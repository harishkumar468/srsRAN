# CMake generated Testfile for 
# Source directory: /home/grads/h/harishkumar003/Desktop/srsRAN/lib/test/rlc
# Build directory: /home/grads/h/harishkumar003/Desktop/srsRAN/build/lib/test/rlc
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(rlc_am_data_test "rlc_am_data_test")
set_tests_properties(rlc_am_data_test PROPERTIES  LABELS "lte;lib;rlc")
add_test(rlc_am_control_test "rlc_am_control_test")
set_tests_properties(rlc_am_control_test PROPERTIES  LABELS "lte;lib;rlc")
add_test(rlc_am_test "rlc_am_test")
set_tests_properties(rlc_am_test PROPERTIES  LABELS "lte;lib;rlc")
add_test(rlc_am_nr_pdu_test "rlc_am_nr_pdu_test")
set_tests_properties(rlc_am_nr_pdu_test PROPERTIES  LABELS "nr;lib;rlc")
add_test(rlc_am_stress_test "rlc_stress_test" "--mode=AM" "--loglevel" "1" "--sdu_gen_delay" "250")
set_tests_properties(rlc_am_stress_test PROPERTIES  LABELS "lte;lib;rlc")
add_test(rlc_um_stress_test "rlc_stress_test" "--mode=UM" "--loglevel" "1")
set_tests_properties(rlc_um_stress_test PROPERTIES  LABELS "lte;lib;rlc")
add_test(rlc_tm_stress_test "rlc_stress_test" "--mode=TM" "--loglevel" "1" "--random_opp=false")
set_tests_properties(rlc_tm_stress_test PROPERTIES  LABELS "lte;lib;rlc")
add_test(rlc_um6_nr_stress_test "rlc_stress_test" "--rat" "NR" "--mode=UM6" "--loglevel" "1")
set_tests_properties(rlc_um6_nr_stress_test PROPERTIES  LABELS "nr;lib;rlc")
add_test(rlc_um12_nr_stress_test "rlc_stress_test" "--rat" "NR" "--mode=UM12" "--loglevel" "1")
set_tests_properties(rlc_um12_nr_stress_test PROPERTIES  LABELS "nr;lib;rlc")
add_test(rlc_um_data_test "rlc_um_data_test")
add_test(rlc_um_test "rlc_um_test")
add_test(rlc_common_test "rlc_common_test")
add_test(rlc_um_nr_pdu_test "rlc_um_nr_pdu_test")
set_tests_properties(rlc_um_nr_pdu_test PROPERTIES  LABELS "nr;lib;rlc")
add_test(rlc_um_nr_test "rlc_um_nr_test")
set_tests_properties(rlc_um_nr_test PROPERTIES  LABELS "nr;lib;rlc")
