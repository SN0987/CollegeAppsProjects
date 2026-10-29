#include "Animator.hpp"


 
GreenMan::Animator::Animator() {
    
}

void GreenMan::Animator::init(sf::Sprite* sprite,int startingFrame) {
    this->sprite = sprite;
    this->startingFrame = startingFrame;

    frame = startingFrame;

    time = 0;
    
}


void GreenMan::Animator::animate(sf::RenderWindow* window,int fps,int maxFrame,int srcY) {
    time++;

    if(time >= fps) {
        time = 0;

        if(frame >= maxFrame) {
            frame = startingFrame;

        } else {
            frame++;
        }
    }

    sprite->setTextureRect(sf::IntRect(frame*32,srcY,32,32));

    window->draw(*sprite);


}