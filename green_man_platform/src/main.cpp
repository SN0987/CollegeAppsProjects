#include <iostream>
#include "Game/Game.hpp"
#include <random>
#include <cstdlib>




int main() {   
    srand(time(NULL));
    Game game(1000,600,"Green Man Platform");
    return 0;
}