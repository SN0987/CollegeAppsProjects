#pragma once
#include <iostream>
#include <SFML/Window.hpp>
#include <SFML/Graphics.hpp>
#include "../GameObject/TextureManager.hpp"
#include "../Window/Window.hpp"




class Particles {
    private:
        TextureManager* manager;
        Window* window;


        float r;

        float velX,velY;


        sf::RectangleShape shape;
        
        int time;

    public:

        Particles();

        void init(Window* window,TextureManager* manager,float x,float y,float r,float velX,float velY,float srcX,sf::Color color);

        void update(float dt,int reduceTime,int reduceAmount);

        void draw();

        float getR();
};