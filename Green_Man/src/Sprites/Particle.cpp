#include <iostream>
#include <SFML/Window.hpp>
#include <SFML/Graphics.hpp>
#include "Particle.hpp"




Particle::Particle(float x,float y,float r,float velX,float velY,sf::Color color) {
    texture = new sf::Texture();

    texture->loadFromFile("assets/circles.png");

    math.x = x;
    math.y = y;
    math.r = r;
    math.velX = velX;
    math.velY = velY;

    shape.setPosition(math.x,math.y);
    shape.setSize(sf::Vector2f(math.r,math.r));
    shape.setTexture(texture);
    shape.setTextureRect(sf::IntRect(32,0,32,32));
    shape.setFillColor(color);
    
    time = 0;

}

void Particle::update(sf::Time& dt,float reduceTime) {
    shape.move(math.velX*dt.asSeconds(),math.velY*dt.asSeconds());

    time++;

    if(time >= reduceTime) {
        time = 0;
        math.r--;
        
    }

    shape.setSize(sf::Vector2f(math.r,math.r));

}
    
void Particle::draw(sf::RenderWindow* window) {

    window->draw(shape);
}
