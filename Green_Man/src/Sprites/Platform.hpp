#pragma once
#include <iostream>
#include <SFML/Window.hpp>
#include <SFML/Graphics.hpp>



class Platform {
    private:
        
        sf::Sprite sprite;

        sf::Texture* texture;


        float velX;
        float velY;
        sf::Color color;

        
    public:
        Platform(float x,float y,float sx,float sy,float velX,float velY,sf::Color color);


        void update(sf::Time& dt);

        void draw(sf::RenderWindow* window);

        void setSpeed(float velX,float velY);

        void setColor(sf::Color color);

        sf::Sprite getSprite();

        float getXSpeed();

        float getYSpeed();
        
};