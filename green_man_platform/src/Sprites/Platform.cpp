#include "Platform.hpp"



Platform::Platform(float x,float y,Window* window,TextureManager* manager)  {

    init(window,manager);
    sprite.setPosition(x,y);
    sprite.setTexture(*manager->textures[1]);
    sprite.setTextureRect(sf::IntRect(0,0,32,32));
    sprite.setScale(7,1.5);
    sprite.setColor(sf::Color(Random::getRange(200),Random::getRange(200),Random::getRange(200)));
    


    collider.setPosition(x,y);
    collider.setFillColor(sf::Color(0,0,0));
    collider.setSize(sf::Vector2f(224,48));



    setType(PLATFORM);
}
        



void Platform::update(float dt,float startX,float startY) {
    

    if(collider.getPosition().y >= window->getHeight()+96) {
        collider.setPosition(startX,startY);
    }

    if(changeSpeed.getElapsedTime().asSeconds() >= 45) {

        if(velY < 200) {
            velY+=20;
        }

        changeSpeed.restart();
    }

    collider.move(velX*dt,velY*dt);

    sprite.setPosition(collider.getPosition());
}  

void Platform::draw() {
    //window->getWindow()->draw(collider);
    window->getWindow()->draw(sprite);

    
}




void Platform::init(Window* window,TextureManager* manager) {
    this->manager = manager;
    this->window = window;
    

}

void Platform::setSpeed(float velX,float velY) {
    this->velX = velX;
    this->velY = velY;

}


float Platform::getVelX() {
    return this->velX;

}

float Platform::getVelY() {
    return this->velY;

}

sf::Sprite Platform::getSprite() {
    return this->sprite;

}

sf::RectangleShape Platform::getCollider() {
    return this->collider;

}



TYPE Platform::getType() {
    return this->type;

}


        
Platform::~Platform() {

}  


void Platform::setType(TYPE type) {
    this->type = type;

}