# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.17

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Disable VCS-based implicit rules.
% : %,v


# Disable VCS-based implicit rules.
% : RCS/%


# Disable VCS-based implicit rules.
% : RCS/%,v


# Disable VCS-based implicit rules.
% : SCCS/s.%


# Disable VCS-based implicit rules.
% : s.%


.SUFFIXES: .hpux_make_needs_suffix_list


# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

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
CMAKE_COMMAND = /Applications/CLion.app/Contents/bin/cmake/mac/bin/cmake

# The command to remove a file.
RM = /Applications/CLion.app/Contents/bin/cmake/mac/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /Users/vlad/CLionProjects/garbage_collector

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /Users/vlad/CLionProjects/garbage_collector/cmake-build-debug

# Include any dependencies generated for this target.
include CMakeFiles/garbage_collector.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/garbage_collector.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/garbage_collector.dir/flags.make

CMakeFiles/garbage_collector.dir/boot.c.o: CMakeFiles/garbage_collector.dir/flags.make
CMakeFiles/garbage_collector.dir/boot.c.o: ../boot.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/vlad/CLionProjects/garbage_collector/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/garbage_collector.dir/boot.c.o"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/garbage_collector.dir/boot.c.o   -c /Users/vlad/CLionProjects/garbage_collector/boot.c

CMakeFiles/garbage_collector.dir/boot.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/garbage_collector.dir/boot.c.i"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /Users/vlad/CLionProjects/garbage_collector/boot.c > CMakeFiles/garbage_collector.dir/boot.c.i

CMakeFiles/garbage_collector.dir/boot.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/garbage_collector.dir/boot.c.s"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /Users/vlad/CLionProjects/garbage_collector/boot.c -o CMakeFiles/garbage_collector.dir/boot.c.s

CMakeFiles/garbage_collector.dir/program.asm.o: CMakeFiles/garbage_collector.dir/flags.make
CMakeFiles/garbage_collector.dir/program.asm.o: ../program.asm
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/vlad/CLionProjects/garbage_collector/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building ASM object CMakeFiles/garbage_collector.dir/program.asm.o"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc $(ASM_DEFINES) $(ASM_INCLUDES) $(ASM_FLAGS) -o CMakeFiles/garbage_collector.dir/program.asm.o -c /Users/vlad/CLionProjects/garbage_collector/program.asm

# Object files for target garbage_collector
garbage_collector_OBJECTS = \
"CMakeFiles/garbage_collector.dir/boot.c.o" \
"CMakeFiles/garbage_collector.dir/program.asm.o"

# External object files for target garbage_collector
garbage_collector_EXTERNAL_OBJECTS =

garbage_collector: CMakeFiles/garbage_collector.dir/boot.c.o
garbage_collector: CMakeFiles/garbage_collector.dir/program.asm.o
garbage_collector: CMakeFiles/garbage_collector.dir/build.make
garbage_collector: CMakeFiles/garbage_collector.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/Users/vlad/CLionProjects/garbage_collector/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Linking C executable garbage_collector"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/garbage_collector.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/garbage_collector.dir/build: garbage_collector

.PHONY : CMakeFiles/garbage_collector.dir/build

CMakeFiles/garbage_collector.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/garbage_collector.dir/cmake_clean.cmake
.PHONY : CMakeFiles/garbage_collector.dir/clean

CMakeFiles/garbage_collector.dir/depend:
	cd /Users/vlad/CLionProjects/garbage_collector/cmake-build-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/vlad/CLionProjects/garbage_collector /Users/vlad/CLionProjects/garbage_collector /Users/vlad/CLionProjects/garbage_collector/cmake-build-debug /Users/vlad/CLionProjects/garbage_collector/cmake-build-debug /Users/vlad/CLionProjects/garbage_collector/cmake-build-debug/CMakeFiles/garbage_collector.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/garbage_collector.dir/depend

