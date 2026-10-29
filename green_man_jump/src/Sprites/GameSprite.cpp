#include "GameSprite.hpp"




GreenMan::GameSprite::GameSprite() 
    :texture(nullptr)
{

}

float GreenMan::GameSprite::getVelX() {
    return velX;
}

float GreenMan::GameSprite::getVelY() {
    return velY;
}

void GreenMan::GameSprite::setVelX(float velX) {
    this->velX = velX;
}

void GreenMan::GameSprite::setVelY(float velY) {
    this->velY = velY;
}

sf::Sprite GreenMan::GameSprite::getSprite() {
    return this->sprite;
}
            
            

void GreenMan::GameSprite::destroy() {
    delete texture;

    texture = nullptr;

    if(texture == nullptr) {
        std::cout << "Destroyed Texture" << std::endl;
    }
}