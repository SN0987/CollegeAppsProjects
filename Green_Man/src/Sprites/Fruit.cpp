#include <iostream>
#include <SFML/Window.hpp>
#include <SFML/Graphics.hpp>
#include "../Tools/Random.hpp"
#include "Fruit.hpp"




Fruit::Fruit(float x,float y,float velX,float velY) {
    texture = new sf::Texture();
    texture->loadFromFile("assets/fruits.png");

    sprite.setTexture(*texture);
    sprite.setTextureRect(sf::IntRect(Random::range(4)*32,0,32,32));
    sprite.setPosition(x,y);
    sprite.setScale(sf::Vector2f(4,4));


    this->velX = velX;
    this->velY = velY;
    colCounter = 0;


}



void Fruit::setSpeed(float velX,float velY) {
    this->velX = velX;
    this->velY = velY;

}

float Fruit::getVelX() {

    return velX;

}

float Fruit::getVelY() {
    return velY;

}


void Fruit::update(sf::Time& dt) {
    sprite.move(sf::Vector2f(velX*dt.asSeconds(),velY*dt.asSeconds()));
    
 
    
    if(sprite.getPosition().x <= 0) {
        sprite.setPosition(0,sprite.getPosition().y);
    }

    if(sprite.getPosition().x >= 800 - sprite.getGlobalBounds().width) {
        sprite.setPosition(800-sprite.getGlobalBounds().width,sprite.getPosition().y);

    }
}   



void Fruit::draw(sf::RenderWindow* window) {
    window->draw(sprite);
}


sf::Sprite Fruit::getSprite() {
    return this->sprite;
}

void Fruit::changePosition() {
    this->sprite.setTextureRect(sf::IntRect(32*Random::range(4),0,32,32));
    this->sprite.setPosition(Random::range(800),-100);
}