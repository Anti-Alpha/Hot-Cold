cmake_minimum_required(VERSION 3.17)
project(Back_end)

set(CMAKE_CXX_STANDARD 14)

include_directories(.)

add_executable(Back_end
        main.cpp
        matrix.h
        matrix.cpp matrix.cpp
        Data_Final_Table.txt)
