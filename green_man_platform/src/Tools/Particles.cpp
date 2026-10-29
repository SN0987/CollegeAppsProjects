#include "Particles.hpp"





Particles::Particles() {

}

void Particles::init(Window* window,TextureManager* manager,float x,float y,float r,float velX,float velY,float srcX,sf::Color color) {
    this->window = window;
    this->manager = manager;

    shape.setTexture(manager->textures[4]);
    shape.setTextureRect(sf::IntRect(srcX*32,0,32,32));
    shape.setFillColor(sf::Color(color));
    shape.setSize(sf::Vector2f(r,r));
    shape.setPosition(sf::Vector2f(x,y));

    this->velX = velX;
    this->velY = velY;
    this->r = r;


    time = 0;


}

void Particles::update(float dt,int reduceTime,int reduceAmount) {
    shape.move(sf::Vector2f(velX*dt,velY*dt));

    time++;

    if(time >= reduceTime) {
        this->r-=reduceAmount;
        time = 0;
        
        
    }

    shape.setSize(sf::Vector2f(this->r,this->r));

}

void Particles::draw() {
    window->getWindow()->draw(shape);
}

float Particles::getR() {
    return this->r;
}

