# CMake generated Testfile for 
# Source directory: /home/grads/h/harishkumar003/Desktop/srsRAN/lib/src/phy/fec/convolutional/test
# Build directory: /home/grads/h/harishkumar003/Desktop/srsRAN/build/lib/src/phy/fec/convolutional/test
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(viterbi_40_0 "viterbi_test" "-n" "1000" "-s" "1" "-l" "40" "-t" "-e" "0.0")
add_test(viterbi_40_2 "viterbi_test" "-n" "1000" "-s" "1" "-l" "40" "-t" "-e" "2.0")
add_test(viterbi_40_3 "viterbi_test" "-n" "1000" "-s" "1" "-l" "40" "-t" "-e" "3.0")
add_test(viterbi_40_4 "viterbi_test" "-n" "1000" "-s" "1" "-l" "40" "-t" "-e" "4.5")
add_test(viterbi_1000_0 "viterbi_test" "-n" "100" "-s" "1" "-l" "1000" "-t" "-e" "0.0")
add_test(viterbi_1000_2 "viterbi_test" "-n" "100" "-s" "1" "-l" "1000" "-t" "-e" "2.0")
add_test(viterbi_1000_3 "viterbi_test" "-n" "100" "-s" "1" "-l" "1000" "-t" "-e" "3.0")
add_test(viterbi_1000_4 "viterbi_test" "-n" "100" "-s" "1" "-l" "1000" "-t" "-e" "4.5")
add_test(viterbi_56_4 "viterbi_test" "-n" "1000" "-s" "1" "-l" "56" "-t" "-e" "4.5")
