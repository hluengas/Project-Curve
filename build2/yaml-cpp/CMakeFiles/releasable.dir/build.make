# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.5

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
CMAKE_COMMAND = /usr/local/Cellar/cmake/3.5.2/bin/cmake

# The command to remove a file.
RM = /usr/local/Cellar/cmake/3.5.2/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /Users/AllenLiu/csc476/project/CSC-476-Project

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /Users/AllenLiu/csc476/project/CSC-476-Project/build2

# Utility rule file for releasable.

# Include the progress variables for this target.
include yaml-cpp/CMakeFiles/releasable.dir/progress.make

yaml-cpp/CMakeFiles/releasable:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/Users/AllenLiu/csc476/project/CSC-476-Project/build2/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Adjusting settings for release compilation"
	cd /Users/AllenLiu/csc476/project/CSC-476-Project/build2/yaml-cpp && $(MAKE) clean
	cd /Users/AllenLiu/csc476/project/CSC-476-Project/build2/yaml-cpp && /usr/local/Cellar/cmake/3.5.2/bin/cmake -DCMAKE_BUILD_TYPE=Release /Users/AllenLiu/csc476/project/CSC-476-Project

releasable: yaml-cpp/CMakeFiles/releasable
releasable: yaml-cpp/CMakeFiles/releasable.dir/build.make

.PHONY : releasable

# Rule to build all files generated by this target.
yaml-cpp/CMakeFiles/releasable.dir/build: releasable

.PHONY : yaml-cpp/CMakeFiles/releasable.dir/build

yaml-cpp/CMakeFiles/releasable.dir/clean:
	cd /Users/AllenLiu/csc476/project/CSC-476-Project/build2/yaml-cpp && $(CMAKE_COMMAND) -P CMakeFiles/releasable.dir/cmake_clean.cmake
.PHONY : yaml-cpp/CMakeFiles/releasable.dir/clean

yaml-cpp/CMakeFiles/releasable.dir/depend:
	cd /Users/AllenLiu/csc476/project/CSC-476-Project/build2 && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/AllenLiu/csc476/project/CSC-476-Project /Users/AllenLiu/csc476/project/CSC-476-Project/yaml-cpp /Users/AllenLiu/csc476/project/CSC-476-Project/build2 /Users/AllenLiu/csc476/project/CSC-476-Project/build2/yaml-cpp /Users/AllenLiu/csc476/project/CSC-476-Project/build2/yaml-cpp/CMakeFiles/releasable.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : yaml-cpp/CMakeFiles/releasable.dir/depend

