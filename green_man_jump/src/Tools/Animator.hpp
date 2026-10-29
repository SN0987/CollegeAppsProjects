#pragma once
#include <iostream>
#include <SFML/Window.hpp>
#include <SFML/Graphics.hpp>



namespace GreenMan {
    class Animator {
        private:

            int frame,time;

            sf::Sprite* sprite;

            int startingFrame;


        public:
            Animator();
            
            void init(sf::Sprite* sprite,int startingFrame);
        

            void animate(sf::RenderWindow* window,int fps,int maxFrame,int srcY);

    };
}