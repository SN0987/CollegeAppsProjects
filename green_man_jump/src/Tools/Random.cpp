#include "Random.hpp"


//random

int Random::getRandom(int max) {
    return (int)(rand()%max);
}

int Random::getRandom(int min, int max) {
    return (int)(rand()%(max-min)+min);
}