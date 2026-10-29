#include <iostream>
#include <SFML/Window.hpp>
#include <SFML/Graphics.hpp>
#include "Radius.hpp"





Radius::Radius(float r,float maxr,float x,float y) {
    texture = new sf::Texture();

    texture->loadFromFile("assets/radius.png");

    this->r = r;
    this->maxr = maxr;
    this->minr = r;


    isVisible = true;

    increaseTime = 0;

    shape.setTexture(texture);
    shape.setPosition(x,y);
    shape.setSize(sf::Vector2f(this->r,this->r));
    

}  



void Radius::update(sf::Time& dt,int howmuch,int time) {
    if(isVisible) {
        increaseTime++;

    
        if(increaseTime >= time) {
            increaseTime = 0;
            if(this->r >= maxr) {
                this->r = maxr;
                isVisible = false;

            } else {
                this->r+=howmuch;
            }

        }

        shape.setSize(sf::Vector2f(this->r,this->r));

    }
   
    
}

        
void Radius::draw(sf::RenderWindow* window) {

    if(this->isVisible) {
        window->draw(shape);

    }
}

void Radius::setVisible(bool visibility,float x,float y) {
    this->isVisible = visibility;
    this->shape.setPosition(x,y);
    this->r = minr;
    
}