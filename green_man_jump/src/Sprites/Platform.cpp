#include "Platform.hpp"




GreenMan::Platform::Platform(float x,float y,float scaleX,float scaleY,sf::Color color,float velX,float velY) {
    texture = new sf::Texture();
    texture->loadFromFile("assets/platform.png");
    
    sprite.setTexture(*texture);
    sprite.setPosition(x,y);
    sprite.setScale(scaleX,scaleY);
    sprite.setColor(color);

    setVelX(velX);
    setVelY(velY);

}


void GreenMan::Platform::reset() {
    sprite.setScale(Random::getRandom(5,12),Random::getRandom(4,10));

    sprite.setPosition(sprite.getGlobalBounds().width+550,600-sprite.getGlobalBounds().height);
    sprite.setColor(sf::Color(Random::getRandom(0,255),Random::getRandom(0,255),Random::getRandom(0,255)));
    
    setVelX(Random::getRandom(220,380));
    setVelY(0);

}

void GreenMan::Platform::update(sf::Time& dt) {
    sprite.move(sf::Vector2f(-velX*dt.asSeconds(),velY*dt.asSeconds()));

    if(sprite.getPosition().x <= -sprite.getGlobalBounds().width) {
        reset();
    }
}


void GreenMan::Platform::draw(sf::RenderWindow* window) {
    window->draw(sprite);
}


GreenMan::Platform::~Platform() {
    destroy();
}