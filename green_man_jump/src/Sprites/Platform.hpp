#pragma once
#include <iostream>
#include <SFML/Window.hpp>
#include <SFML/Graphics.hpp>
#include "GameSprite.hpp"
#include "../Tools/Random.hpp"


namespace GreenMan {
    class Platform : public GameSprite {
        private:

            void reset();
            

        public:
            Platform(float x,float y,float scaleX,float scaleY,sf::Color color,float velX,float velY);


            void update(sf::Time& dt);


            void draw(sf::RenderWindow* window);

            

            ~Platform();
    };
}