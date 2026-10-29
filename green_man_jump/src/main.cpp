#include <iostream>
#include <SFML/Graphics.hpp>
#include <SFML/Window.hpp>
#include "Game/Game.hpp"
#include <random>
#include <cstdlib>
#include <ctime>







int main() {
    srand(time(NULL));
    
    GreenMan::GameScreen screen(800,600,"GreenMan Jump By Sn0987");
    
    return 0;
}