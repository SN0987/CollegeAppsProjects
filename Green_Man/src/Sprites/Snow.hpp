#pragma once
#include <iostream>
#include <SFML/Window.hpp>
#include <SFML/Graphics.hpp>
#include <vector>




class Snow {
    private:
        std::vector<sf::RectangleShape> snow;
        float velY;
        
    public:
        Snow(int amount,sf::Color color);


        void update(sf::Time& dt);


        void draw(sf::RenderWindow* window);
};