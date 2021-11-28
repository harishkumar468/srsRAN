cmake_minimum_required(VERSION 2.6)

execute_process(
COMMAND git rev-parse --abbrev-ref HEAD
WORKING_DIRECTORY "/home/grads/h/harishkumar003/Desktop/srsRAN"
OUTPUT_VARIABLE GIT_BRANCH
OUTPUT_STRIP_TRAILING_WHITESPACE
)

execute_process(
COMMAND git log -1 --format=%h
WORKING_DIRECTORY "/home/grads/h/harishkumar003/Desktop/srsRAN"
OUTPUT_VARIABLE GIT_COMMIT_HASH
OUTPUT_STRIP_TRAILING_WHITESPACE
)

message(STATUS "Generating build_info.h")
configure_file(
  /home/grads/h/harishkumar003/Desktop/srsRAN/lib/include/srsran/build_info.h.in
  /home/grads/h/harishkumar003/Desktop/srsRAN/build/lib/include/srsran/build_info.h
)
