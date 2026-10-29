#pragma once
#include <iostream>
#include <SFML/Window.hpp>
#include <SFML/Graphics.hpp>
#include "Particles.hpp"
#include <vector>


class ParticleList {
    private:
        std::vector<Particles> parts;

        TextureManager* manager;
        Window* window;
        int time;

        int timeTwo;

    public:

        ParticleList();

        void init(TextureManager* manager,Window* window);

        void add(float x,float y,float r,float velX,float velY,float srcX,sf::Color color,int addTime);

        void update(float dt,int reduceTime,int reduceAmount);

        void draw();
};