#include "ParticlesList.hpp"


ParticleList::ParticleList() {

}

void ParticleList::init(TextureManager* manager,Window* window) {
    this->manager = manager;
    this->window = window;
    time = 0;
    
}

void ParticleList::add(float x,float y,float r,float velX,float velY,float srcX,sf::Color color,int addTime) {
    time++;

    if(time >= addTime) {
        Particles part;
        part.init(window,manager,x,y,r,velX,velY,srcX,color);
        parts.push_back(part);
        time = 0;
    }
}

void ParticleList::update(float dt,int reduceTime,int reduceAmount) {
    for(int i = 0;i<parts.size();i++) {
        parts[i].update(dt,reduceTime,reduceAmount);
    }

    for(int i = 0;i<parts.size();i++) {
        if(parts[i].getR() <= 0) {
            parts.erase(parts.begin()+i);
        }
    }
}

void ParticleList::draw() {
    for(int i = 0;i<parts.size();i++) {
        parts[i].draw();
    }
}