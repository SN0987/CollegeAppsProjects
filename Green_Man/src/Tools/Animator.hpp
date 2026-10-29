#pragma once
#include <iostream>
#include <SFML/Window.hpp>
#include <SFML/Graphics.hpp>



class Animator {
    private:

        sf::Sprite* sprite;

        int frame;
        int time;

        int startingFrame;
        


    public:
        Animator(sf::Sprite* sprite,int startingFrame);



        void draw(sf::RenderWindow* window,int fps,int frameLimit,int srcy);
};