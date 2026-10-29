#include "Object.hpp"



Object::Object(Window* window,TextureManager* manager) {
    this->manager = manager;
    this->window = window;

}


Object::Object() {

}

void Object::init(Window* window,TextureManager* manager) {
    this->manager = manager;
    this->window = window;
    

}

void Object::setSpeed(float velX,float velY) {
    this->velX = velX;
    this->velY = velY;

}


float Object::getVelX() {
    return this->velX;

}

float Object::getVelY() {
    return this->velY;

}

sf::Sprite Object::getSprite() {
    return this->sprite;

}

sf::RectangleShape Object::getCollider() {
    return this->collider;

}



TYPE Object::getType() {
    return this->type;

}


        
Object::~Object() {

}  


void Object::setType(TYPE type) {
    this->type = type;

}