#include <iostream>
#include "Game/Game.hpp"
#include <cstdlib>
#include <random>
#include <ctime>


int main() {
    srand(time(NULL));

    Game game(800,600,"Green Man!");

    return 0;
}