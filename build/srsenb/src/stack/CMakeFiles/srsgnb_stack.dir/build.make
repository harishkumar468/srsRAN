# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.10

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/grads/h/harishkumar003/Desktop/srsRAN

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/grads/h/harishkumar003/Desktop/srsRAN/build

# Include any dependencies generated for this target.
include srsenb/src/stack/CMakeFiles/srsgnb_stack.dir/depend.make

# Include the progress variables for this target.
include srsenb/src/stack/CMakeFiles/srsgnb_stack.dir/progress.make

# Include the compile flags for this target's objects.
include srsenb/src/stack/CMakeFiles/srsgnb_stack.dir/flags.make

srsenb/src/stack/CMakeFiles/srsgnb_stack.dir/gnb_stack_nr.cc.o: srsenb/src/stack/CMakeFiles/srsgnb_stack.dir/flags.make
srsenb/src/stack/CMakeFiles/srsgnb_stack.dir/gnb_stack_nr.cc.o: ../srsenb/src/stack/gnb_stack_nr.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/grads/h/harishkumar003/Desktop/srsRAN/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object srsenb/src/stack/CMakeFiles/srsgnb_stack.dir/gnb_stack_nr.cc.o"
	cd /home/grads/h/harishkumar003/Desktop/srsRAN/build/srsenb/src/stack && /usr/bin/ccache /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/srsgnb_stack.dir/gnb_stack_nr.cc.o -c /home/grads/h/harishkumar003/Desktop/srsRAN/srsenb/src/stack/gnb_stack_nr.cc

srsenb/src/stack/CMakeFiles/srsgnb_stack.dir/gnb_stack_nr.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/srsgnb_stack.dir/gnb_stack_nr.cc.i"
	cd /home/grads/h/harishkumar003/Desktop/srsRAN/build/srsenb/src/stack && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/grads/h/harishkumar003/Desktop/srsRAN/srsenb/src/stack/gnb_stack_nr.cc > CMakeFiles/srsgnb_stack.dir/gnb_stack_nr.cc.i

srsenb/src/stack/CMakeFiles/srsgnb_stack.dir/gnb_stack_nr.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/srsgnb_stack.dir/gnb_stack_nr.cc.s"
	cd /home/grads/h/harishkumar003/Desktop/srsRAN/build/srsenb/src/stack && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/grads/h/harishkumar003/Desktop/srsRAN/srsenb/src/stack/gnb_stack_nr.cc -o CMakeFiles/srsgnb_stack.dir/gnb_stack_nr.cc.s

srsenb/src/stack/CMakeFiles/srsgnb_stack.dir/gnb_stack_nr.cc.o.requires:

.PHONY : srsenb/src/stack/CMakeFiles/srsgnb_stack.dir/gnb_stack_nr.cc.o.requires

srsenb/src/stack/CMakeFiles/srsgnb_stack.dir/gnb_stack_nr.cc.o.provides: srsenb/src/stack/CMakeFiles/srsgnb_stack.dir/gnb_stack_nr.cc.o.requires
	$(MAKE) -f srsenb/src/stack/CMakeFiles/srsgnb_stack.dir/build.make srsenb/src/stack/CMakeFiles/srsgnb_stack.dir/gnb_stack_nr.cc.o.provides.build
.PHONY : srsenb/src/stack/CMakeFiles/srsgnb_stack.dir/gnb_stack_nr.cc.o.provides

srsenb/src/stack/CMakeFiles/srsgnb_stack.dir/gnb_stack_nr.cc.o.provides.build: srsenb/src/stack/CMakeFiles/srsgnb_stack.dir/gnb_stack_nr.cc.o


# Object files for target srsgnb_stack
srsgnb_stack_OBJECTS = \
"CMakeFiles/srsgnb_stack.dir/gnb_stack_nr.cc.o"

# External object files for target srsgnb_stack
srsgnb_stack_EXTERNAL_OBJECTS =

srsenb/src/stack/libsrsgnb_stack.a: srsenb/src/stack/CMakeFiles/srsgnb_stack.dir/gnb_stack_nr.cc.o
srsenb/src/stack/libsrsgnb_stack.a: srsenb/src/stack/CMakeFiles/srsgnb_stack.dir/build.make
srsenb/src/stack/libsrsgnb_stack.a: srsenb/src/stack/CMakeFiles/srsgnb_stack.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/grads/h/harishkumar003/Desktop/srsRAN/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX static library libsrsgnb_stack.a"
	cd /home/grads/h/harishkumar003/Desktop/srsRAN/build/srsenb/src/stack && $(CMAKE_COMMAND) -P CMakeFiles/srsgnb_stack.dir/cmake_clean_target.cmake
	cd /home/grads/h/harishkumar003/Desktop/srsRAN/build/srsenb/src/stack && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/srsgnb_stack.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
srsenb/src/stack/CMakeFiles/srsgnb_stack.dir/build: srsenb/src/stack/libsrsgnb_stack.a

.PHONY : srsenb/src/stack/CMakeFiles/srsgnb_stack.dir/build

srsenb/src/stack/CMakeFiles/srsgnb_stack.dir/requires: srsenb/src/stack/CMakeFiles/srsgnb_stack.dir/gnb_stack_nr.cc.o.requires

.PHONY : srsenb/src/stack/CMakeFiles/srsgnb_stack.dir/requires

srsenb/src/stack/CMakeFiles/srsgnb_stack.dir/clean:
	cd /home/grads/h/harishkumar003/Desktop/srsRAN/build/srsenb/src/stack && $(CMAKE_COMMAND) -P CMakeFiles/srsgnb_stack.dir/cmake_clean.cmake
.PHONY : srsenb/src/stack/CMakeFiles/srsgnb_stack.dir/clean

srsenb/src/stack/CMakeFiles/srsgnb_stack.dir/depend:
	cd /home/grads/h/harishkumar003/Desktop/srsRAN/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/grads/h/harishkumar003/Desktop/srsRAN /home/grads/h/harishkumar003/Desktop/srsRAN/srsenb/src/stack /home/grads/h/harishkumar003/Desktop/srsRAN/build /home/grads/h/harishkumar003/Desktop/srsRAN/build/srsenb/src/stack /home/grads/h/harishkumar003/Desktop/srsRAN/build/srsenb/src/stack/CMakeFiles/srsgnb_stack.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : srsenb/src/stack/CMakeFiles/srsgnb_stack.dir/depend

