#pragma once
#include <SFML/Window.hpp>
#include <SFML/Graphics.hpp>
#include <iostream>

//from greenman ver 1



class Particle {
    private:
        sf::Texture* texture;
        sf::RectangleShape shape;
        


        typedef struct {
            float x;
            float y;
            float r;
            float velX;
            float velY;


        } CIRCLE;


       

        float time;


    public:
        CIRCLE math;
        Particle(float x,float y,float r,float velX,float velY,sf::Color color);


        void update(sf::Time& dt,float reduceTime);
    
        void draw(sf::RenderWindow* window);

        void destroy();




};