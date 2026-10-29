#include <iostream>
#include <SFML/Window.hpp>
#include <SFML/Graphics.hpp>
#include "Particles.hpp"
#include "Particle.hpp"




Particles::Particles() {
    time = 0;

}



void Particles::add(int add_time,float x,float y,float r,float velX,float velY,sf::Color color) {

    time++;

    if(time >= add_time) {
        time = 0;
        particles.push_back(Particle(x,y,r,velX,velY,color));

    }
}


void Particles::update(sf::Time& dt,int reduceTime) {
    for(unsigned long int i = 0;i<particles.size();i++) {
        particles[i].update(dt,reduceTime);

        if(particles[i].math.r <= 0) {
            particles.erase(particles.begin()+i);
        }
    }
}

void Particles::draw(sf::RenderWindow* window) {
    for(Particle& particle : particles) {
        particle.draw(window);
        
    }
}