#pragma once
#include <SFML/Window.hpp>
#include <SFML/Graphics.hpp>
#include <iostream>
#include <vector>
#include "Particle.hpp"



class Particles {
    private:
        std::vector<Particle> particles;

        int time;

    public:

        Particles();


        void add(int add_time,float x,float y,float r,float velX,float velY,sf::Color color);


        void update(sf::Time& dt,int reduceTime);

        void draw(sf::RenderWindow* window);


};