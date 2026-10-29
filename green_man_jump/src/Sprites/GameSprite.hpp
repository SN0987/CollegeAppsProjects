#pragma once
#include <SFML/Window.hpp>
#include <SFML/Graphics.hpp>
#include <iostream>




namespace GreenMan {

    class GameSprite {
        protected:

            sf::Texture* texture;
            sf::Sprite sprite;

            float velX,velY;


            
        public:
            GameSprite();

            float getVelX();

            float getVelY();

            void setVelX(float velX);

            void setVelY(float velY);

            sf::Sprite getSprite();
            
            virtual void draw(sf::RenderWindow* window) {}

            virtual void update(sf::Time& dt) {}

            void destroy();
    };
}