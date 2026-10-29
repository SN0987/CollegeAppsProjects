#include "Shower.hpp"

Shower::Shower() {

}

void Shower::init(int amount,Window* window,int xPos,int yPos,sf::Color color) {
    this->window = window;

    this->color = color;

    this->xPos = xPos;
    this->yPos = yPos;

    for(int i = 0;i<amount;i++) {

        int w = Random::getRange(2,6);

        sf::RectangleShape shape;
        shape.setSize(sf::Vector2f(w,w));
        shape.setPosition(xPos-Random::getRange(-30,30),yPos-Random::getRange(-30,30));
        shape.setFillColor(color);
        shapes.push_back(shape);

        sf::Vector2f velocity(Random::getRange(-50,50),Random::getRange(-60,-5));
        
        vels.push_back(velocity);
    }

    
}
        

void Shower::update(float dt) {


    for(int i = 0;i<shapes.size();i++) {
        shapes[i].move(vels[i].x*dt,vels[i].y*dt);

       

        if(shapes[i].getPosition().y < 0) {
            int w = Random::getRange(2,6);
            shapes[i].setSize(sf::Vector2f(w,w));
            shapes[i].setPosition(xPos-Random::getRange(-30,30),yPos-Random::getRange(-30,30));

            vels[i].x = Random::getRange(-50,50);
            vels[i].y = Random::getRange(-60,-5);


        } 
    }

}


void Shower::draw() {
    for(int i = 0;i<shapes.size();i++) {
        window->getWindow()->draw(shapes[i]);
    }
}