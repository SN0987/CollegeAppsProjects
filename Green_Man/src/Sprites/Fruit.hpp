#pragma once
#include <iostream>
#include <SFML/Window.hpp>
#include <SFML/Graphics.hpp>



class Fruit {
    private:
        sf::Texture* texture;
        sf::Sprite sprite;

        float velX;
        float velY;

    
        



    public:
        int colCounter;
        Fruit(float x,float y,float velX,float velY);

        
        void update(sf::Time& dt);

        void draw(sf::RenderWindow* window);


        void setSpeed(float velX,float velY);

        float getVelX();

        float getVelY();

        void changePosition();

        sf::Sprite getSprite();
        


};