#include <iostream>
#include <random>
#include <cstdlib>

#include "Random.hpp"






int Random::range(int min,int max) {
    return int(rand()%(max-min)+min);
}


int Random::range(int max) {
    return int(rand()%max);
    
}