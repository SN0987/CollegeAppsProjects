#include "Random.hpp"





int Random::getRange(int min,int max) {
    return rand()%(max-min)+min;
}


int Random::getRange(int max) {
    return rand()%max;
}