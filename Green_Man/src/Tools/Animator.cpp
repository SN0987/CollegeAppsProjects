#include <iostream>
#include <SFML/Window.hpp>
#include <SFML/Graphics.hpp>
#include "Animator.hpp"



Animator::Animator(sf::Sprite* sprite,int startingFrame) {
   
    this->sprite = sprite;

    frame = startingFrame;
    time = 0;

    this->startingFrame = startingFrame;
}




void Animator::draw(sf::RenderWindow* window,int fps,int frameLimit,int srcy) {

    time++;

    if(time >= fps) {
        time = 0;

        if(frame >= frameLimit) {
            frame = startingFrame;
        } else {
            frame++;
        }
    }

    sprite->setTextureRect(sf::IntRect(frame*32,srcy,32,32));

    window->draw(*sprite);

}