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
include lib/src/support/CMakeFiles/support.dir/depend.make

# Include the progress variables for this target.
include lib/src/support/CMakeFiles/support.dir/progress.make

# Include the compile flags for this target's objects.
include lib/src/support/CMakeFiles/support.dir/flags.make

lib/src/support/CMakeFiles/support.dir/emergency_handlers.cc.o: lib/src/support/CMakeFiles/support.dir/flags.make
lib/src/support/CMakeFiles/support.dir/emergency_handlers.cc.o: ../lib/src/support/emergency_handlers.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/grads/h/harishkumar003/Desktop/srsRAN/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object lib/src/support/CMakeFiles/support.dir/emergency_handlers.cc.o"
	cd /home/grads/h/harishkumar003/Desktop/srsRAN/build/lib/src/support && /usr/bin/ccache /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/support.dir/emergency_handlers.cc.o -c /home/grads/h/harishkumar003/Desktop/srsRAN/lib/src/support/emergency_handlers.cc

lib/src/support/CMakeFiles/support.dir/emergency_handlers.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/support.dir/emergency_handlers.cc.i"
	cd /home/grads/h/harishkumar003/Desktop/srsRAN/build/lib/src/support && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/grads/h/harishkumar003/Desktop/srsRAN/lib/src/support/emergency_handlers.cc > CMakeFiles/support.dir/emergency_handlers.cc.i

lib/src/support/CMakeFiles/support.dir/emergency_handlers.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/support.dir/emergency_handlers.cc.s"
	cd /home/grads/h/harishkumar003/Desktop/srsRAN/build/lib/src/support && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/grads/h/harishkumar003/Desktop/srsRAN/lib/src/support/emergency_handlers.cc -o CMakeFiles/support.dir/emergency_handlers.cc.s

lib/src/support/CMakeFiles/support.dir/emergency_handlers.cc.o.requires:

.PHONY : lib/src/support/CMakeFiles/support.dir/emergency_handlers.cc.o.requires

lib/src/support/CMakeFiles/support.dir/emergency_handlers.cc.o.provides: lib/src/support/CMakeFiles/support.dir/emergency_handlers.cc.o.requires
	$(MAKE) -f lib/src/support/CMakeFiles/support.dir/build.make lib/src/support/CMakeFiles/support.dir/emergency_handlers.cc.o.provides.build
.PHONY : lib/src/support/CMakeFiles/support.dir/emergency_handlers.cc.o.provides

lib/src/support/CMakeFiles/support.dir/emergency_handlers.cc.o.provides.build: lib/src/support/CMakeFiles/support.dir/emergency_handlers.cc.o


lib/src/support/CMakeFiles/support.dir/signal_handler.cc.o: lib/src/support/CMakeFiles/support.dir/flags.make
lib/src/support/CMakeFiles/support.dir/signal_handler.cc.o: ../lib/src/support/signal_handler.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/grads/h/harishkumar003/Desktop/srsRAN/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object lib/src/support/CMakeFiles/support.dir/signal_handler.cc.o"
	cd /home/grads/h/harishkumar003/Desktop/srsRAN/build/lib/src/support && /usr/bin/ccache /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/support.dir/signal_handler.cc.o -c /home/grads/h/harishkumar003/Desktop/srsRAN/lib/src/support/signal_handler.cc

lib/src/support/CMakeFiles/support.dir/signal_handler.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/support.dir/signal_handler.cc.i"
	cd /home/grads/h/harishkumar003/Desktop/srsRAN/build/lib/src/support && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/grads/h/harishkumar003/Desktop/srsRAN/lib/src/support/signal_handler.cc > CMakeFiles/support.dir/signal_handler.cc.i

lib/src/support/CMakeFiles/support.dir/signal_handler.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/support.dir/signal_handler.cc.s"
	cd /home/grads/h/harishkumar003/Desktop/srsRAN/build/lib/src/support && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/grads/h/harishkumar003/Desktop/srsRAN/lib/src/support/signal_handler.cc -o CMakeFiles/support.dir/signal_handler.cc.s

lib/src/support/CMakeFiles/support.dir/signal_handler.cc.o.requires:

.PHONY : lib/src/support/CMakeFiles/support.dir/signal_handler.cc.o.requires

lib/src/support/CMakeFiles/support.dir/signal_handler.cc.o.provides: lib/src/support/CMakeFiles/support.dir/signal_handler.cc.o.requires
	$(MAKE) -f lib/src/support/CMakeFiles/support.dir/build.make lib/src/support/CMakeFiles/support.dir/signal_handler.cc.o.provides.build
.PHONY : lib/src/support/CMakeFiles/support.dir/signal_handler.cc.o.provides

lib/src/support/CMakeFiles/support.dir/signal_handler.cc.o.provides.build: lib/src/support/CMakeFiles/support.dir/signal_handler.cc.o


# Object files for target support
support_OBJECTS = \
"CMakeFiles/support.dir/emergency_handlers.cc.o" \
"CMakeFiles/support.dir/signal_handler.cc.o"

# External object files for target support
support_EXTERNAL_OBJECTS =

lib/src/support/libsupport.a: lib/src/support/CMakeFiles/support.dir/emergency_handlers.cc.o
lib/src/support/libsupport.a: lib/src/support/CMakeFiles/support.dir/signal_handler.cc.o
lib/src/support/libsupport.a: lib/src/support/CMakeFiles/support.dir/build.make
lib/src/support/libsupport.a: lib/src/support/CMakeFiles/support.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/grads/h/harishkumar003/Desktop/srsRAN/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Linking CXX static library libsupport.a"
	cd /home/grads/h/harishkumar003/Desktop/srsRAN/build/lib/src/support && $(CMAKE_COMMAND) -P CMakeFiles/support.dir/cmake_clean_target.cmake
	cd /home/grads/h/harishkumar003/Desktop/srsRAN/build/lib/src/support && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/support.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
lib/src/support/CMakeFiles/support.dir/build: lib/src/support/libsupport.a

.PHONY : lib/src/support/CMakeFiles/support.dir/build

lib/src/support/CMakeFiles/support.dir/requires: lib/src/support/CMakeFiles/support.dir/emergency_handlers.cc.o.requires
lib/src/support/CMakeFiles/support.dir/requires: lib/src/support/CMakeFiles/support.dir/signal_handler.cc.o.requires

.PHONY : lib/src/support/CMakeFiles/support.dir/requires

lib/src/support/CMakeFiles/support.dir/clean:
	cd /home/grads/h/harishkumar003/Desktop/srsRAN/build/lib/src/support && $(CMAKE_COMMAND) -P CMakeFiles/support.dir/cmake_clean.cmake
.PHONY : lib/src/support/CMakeFiles/support.dir/clean

lib/src/support/CMakeFiles/support.dir/depend:
	cd /home/grads/h/harishkumar003/Desktop/srsRAN/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/grads/h/harishkumar003/Desktop/srsRAN /home/grads/h/harishkumar003/Desktop/srsRAN/lib/src/support /home/grads/h/harishkumar003/Desktop/srsRAN/build /home/grads/h/harishkumar003/Desktop/srsRAN/build/lib/src/support /home/grads/h/harishkumar003/Desktop/srsRAN/build/lib/src/support/CMakeFiles/support.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : lib/src/support/CMakeFiles/support.dir/depend

