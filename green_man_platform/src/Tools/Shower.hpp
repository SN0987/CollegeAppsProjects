#pragma once 
#include <iostream>
#include <SFML/Window.hpp>
#include <SFML/Graphics.hpp>
#include "../Window/Window.hpp"
#include <vector>
#include "Random.hpp"

class Shower {
    private:
        Window* window;

        std::vector<sf::RectangleShape> shapes;

        std::vector<sf::Vector2f> vels;


        sf::Color color;

        int xPos,yPos;
        

        
    public:
        Shower();

        void init(int amount,Window* window,int xPos,int yPos,sf::Color color);


        void update(float dt);


        void draw();
};