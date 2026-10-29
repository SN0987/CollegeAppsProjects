#include <iostream>
#include <SFML/Window.hpp>
#include <SFML/Graphics.hpp>
#include <vector>
#include "../Tools/Random.hpp"
#include "Snow.hpp"




Snow::Snow(int amount,sf::Color color) {

    velY = 80;

    for(int i = 0;i<amount;i++) {
        sf::RectangleShape shape;
        shape.setPosition(Random::range(800),Random::range(600));
        shape.setFillColor(color);
        float size = Random::range(2,5);
        shape.setSize(sf::Vector2f(size,size));
        
        snow.push_back(shape);

    }
}



void Snow::update(sf::Time& dt) {

    for(int i = 0;i<snow.size();i++) {
        snow[i].move(0,velY*dt.asSeconds());

        if(snow[i].getPosition().y > 600) {
            float size = Random::range(2,5);
            snow[i].setPosition(Random::range(800),Random::range(600));
            snow[i].setSize(sf::Vector2f(size,size));
            
        }
    }
}


void Snow::draw(sf::RenderWindow* window) {

    for(sf::RectangleShape& s : snow) {
        window->draw(s);

    }
}