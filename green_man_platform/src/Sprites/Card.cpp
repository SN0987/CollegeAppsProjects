#include "Card.hpp"



Card::Card(TextureManager* manager,Window* window,int color_name,float x,float y) : Object(window,manager) {

    this->color_name = color_name;


    sprite.setTexture(*manager->textures[2]);
    sprite.setScale(1.5,1.5);
    sprite.setPosition(x,y);


    collider.setPosition(x,y);
    collider.setFillColor(sf::Color(0,0,0));
    collider.setSize(sf::Vector2f(36,30));



    selectColor();


    setType(CARD);

    this->startposx = x;
    this->startposy = y;
    isVisible = true;


    
}


void Card::selectColor() {
    switch(color_name) {
        case 1:
            sprite.setColor(sf::Color(22, 166, 41));
            break;
        case 2:
            sprite.setColor(sf::Color(231, 245, 32));
            break;
        case 3:
            sprite.setColor(sf::Color(219, 33, 33));
            break;
        default:
            break;
    }
}

void Card::setColorName(int color_name) {
    this->color_name = color_name;
}


int Card::getColorName() {
    return this->color_name;
}


void Card::update(float dt,float startX,float startY) {

    collider.move(velX*dt,velY*dt);


    if(collider.getPosition().y >= window->getHeight()+96) {

        setColorName(Random::getRange(1,4));

        if(!this->isVisible) {
            this->isVisible = true;

        }
        collider.setPosition(startX,startY);
    }

    

    selectColor();


    sprite.setPosition(collider.getPosition().x-5,collider.getPosition().y-7);

    
}

void Card::draw() {


    if(isVisible) {
        //window->getWindow()->draw(collider);
        window->getWindow()->draw(sprite);
    }


}


void Card::setVisible(bool isVisible) {
    this->isVisible = isVisible;

}

bool Card::getIsVisible() {
    return this->isVisible;
}


void Card::collideWithObject(Object* object,int& score,StringFont& font,Card& card) {
    if(collider.getGlobalBounds().intersects(object->getCollider().getGlobalBounds()) && isVisible) {
        isVisible = false;

        if(color_name == 1) {
            score++;
        } else if(color_name == 2){
            score--;
        } else if(color_name == 3) {
            score-=5;
        }

        font.setPosition(60,card.getCollider().getPosition().y+(card.getCollider().getGlobalBounds().height/2)-20);
        font.setString(std::to_string(score));
    }
}