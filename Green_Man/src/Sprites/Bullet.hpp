#pragma once
#include <iostream>
#include <SFML/Window.hpp>
#include <SFML/Graphics.hpp>



class Bullet {
    private:   
        sf::Sprite sprite;
        sf::Texture* texture;


        sf::Sprite* base;

        std::string load;

        float velX;
        float velY;



    public:
        Bullet(sf::Sprite* base);


        void update(sf::Time& dt,sf::Vector2f& mPos);


        void draw(sf::RenderWindow* window);

        void shoot(sf::Vector2f& mPos);

        sf::Sprite getSprite();
        



};