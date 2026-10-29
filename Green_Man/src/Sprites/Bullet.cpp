#include <iostream>
#include <SFML/Window.hpp>
#include <SFML/Graphics.hpp>
#include <cmath>
#include "Bullet.hpp"



Bullet::Bullet(sf::Sprite* base) {
    this->base = base;
    
    texture = new sf::Texture();
    texture->loadFromFile("assets/circles.png");

    sprite.setTexture(*texture);
    sprite.setTextureRect(sf::IntRect(0,0,32,32));
    sprite.setPosition(-50,-50);
    sprite.setScale(0.7f,0.7f);
    

    load = "loading";
    velX = 0;
    velY = 0;


}


void Bullet::update(sf::Time& dt,sf::Vector2f& mPos) {

    if(sf::Keyboard::isKeyPressed(sf::Keyboard::E) || sf::Keyboard::isKeyPressed(sf::Keyboard::Q)) {
        if(load == "loading") {
            shoot(mPos);
        }
    }

    if(load == "shooting") {
        

        sprite.move(velX*dt.asSeconds(),velY*dt.asSeconds());

        if(sprite.getPosition().y < 0) {
            load = "loading";
        }

        if(sprite.getPosition().y > 800) {
            load = "loading";
        }

        if(sprite.getPosition().x < 0 || sprite.getPosition().x > 800) {
            load = "loading";
        }
    }
}

        
void Bullet::draw(sf::RenderWindow* window) {

    if(load == "shooting") {
        window->draw(sprite);
    }
}


void Bullet::shoot(sf::Vector2f& mPos) {
    if(load == "loading") {
        float angle = atan2(mPos.y - base->getPosition().y,mPos.x-base->getPosition().x);
        velX = cos(angle)*550;
        velY = sin(angle)*550;
        sprite.setPosition(base->getPosition().x+base->getGlobalBounds().width/2,base->getPosition().y+base->getGlobalBounds().height/2);


        load = "shooting";
    }
}


sf::Sprite Bullet::getSprite() {
    return this->sprite;
}