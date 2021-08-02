cmake_minimum_required(VERSION 3.5)
project(tests)

add_library(runner ./src/lib/lib-vector-add-usm.cpp)
target_compile_options(runner PUBLIC -fsycl 
                                     -fsycl-targets=nvptx64-nvidia-cuda-sycldevice
                                     -fsycl-unnamed-lambda
                                     -Xsycl-target-backend 
                                     --cuda-gpu-arch=sm_60
                                     -O2 
                                     -std=c++17)

add_executable(test-lib ./src/lib/main.cpp)
target_compile_options(test-lib PRIVATE)
target_link_libraries(test-lib PUBLIC runner)
target_link_options(test-lib PRIVATE -fsycl -fsycl-targets=nvptx64-nvidia-cuda-sycldevice)

add_executable(test ./src/vector-add-usm.cpp)
target_compile_options(test PUBLIC -fsycl 
                                   -fsycl-targets=nvptx64-nvidia-cuda-sycldevice
                                   -fsycl-unnamed-lambda 
                                   -O2 
                                   -std=c++17)
target_link_options(test PRIVATE -fsycl 
                                 -fsycl-targets=nvptx64-nvidia-cuda-sycldevice)