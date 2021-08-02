#include <iostream>

int run();

int main() {
    std::cout << "calling main.cpp" << std::endl;
    run();
    std::cout << "leaving main.cpp" << std::endl;
    return 0;
}