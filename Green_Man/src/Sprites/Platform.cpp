#include <iostream>
#include <SFML/Window.hpp>
#include <SFML/Graphics.hpp>
#include "Platform.hpp"
#include "../Tools/Random.hpp"



Platform::Platform(float x,float y,float sx,float sy,float velX,float velY,sf::Color color) {
    texture = new sf::Texture();
    texture->loadFromFile("assets/platform.png");

    sprite.setTexture(*texture);
    sprite.setPosition(x,y);
    sprite.setScale(sx,sy);
    this->velX = velX;
    this->velY = velY;
    this->color = color;


    
}


void Platform::update(sf::Time& dt) {

    this->sprite.move(velX*dt.asSeconds(),velY*dt.asSeconds());

    if(this->sprite.getPosition().x < -this->sprite.getGlobalBounds().width) {
        this->sprite.setPosition(800+this->sprite.getGlobalBounds().width,this->sprite.getPosition().y);
    }

}

void Platform::draw(sf::RenderWindow* window) {

    sprite.setColor(color);

    window->draw(sprite);

}

sf::Sprite Platform::getSprite() {
    return this->sprite;
}

void Platform::setSpeed(float velX,float velY) {
    this->velX = velX;
    this->velY = velY;

}

void Platform::setColor(sf::Color color) {
    this->color = color;

}

float Platform::getXSpeed() {

    return this->velX;
}

float Platform::getYSpeed() {
    return this->velY;

}