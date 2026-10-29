#include <iostream>
#include <SFML/Window.hpp>
#include <SFML/Graphics.hpp>
#include "Player.hpp"
#include "Platform.hpp"
#include <vector>
#include "Fruit.hpp"
#include "../Tools/Random.hpp"
#include "../Tools/Camera.hpp"
#include "Particles.hpp"
#include "../Tools/StringFont.hpp"

Player::Player(float x,float y) {
    texture = new sf::Texture();

    texture->loadFromFile("assets/player.png");

    
    sprite.setTexture(*texture);
    sprite.setPosition(x,y);
    sprite.setTextureRect(sf::IntRect(0,2*32,32,32));
    sprite.setScale(3,3);

    isCollide = false;
    isJump = false;
    isGrounded = false;

    velX = 0;
    counter = 0;

    velY = 0;

    health = 100;

    gravity = 100;
    radius = new Radius(20,110,0,0);
    radius->setVisible(false,0,0);


    this->state = "idle";

    leftAnim = new Animator(&sprite,1);
    rightAnim = new Animator(&sprite,1);

    redBar.setFillColor(sf::Color(227, 80, 75));
    redBar.setSize(sf::Vector2f(200,40));
    redBar.setPosition(sf::Vector2f(800/2-100,40));
    
    greenBar.setFillColor(sf::Color(59, 173, 72));
    greenBar.setSize(sf::Vector2f(health*2,40));
    greenBar.setPosition(800/2-(health*2/2),40);




    
}




sf::Sprite Player::getSprite() {
    return this->sprite;

}



void Player::update(sf::Time& dt,std::vector<Platform>& platforms,std::vector<Fruit>& fruits,Camera& camera,int& score,StringFont& scoreFont) {


    movement();

    if(sprite.getPosition().x < 0) sprite.setPosition(0,sprite.getPosition().y);
    if(sprite.getPosition().x > 800 - sprite.getGlobalBounds().width) sprite.setPosition(800-sprite.getGlobalBounds().width,sprite.getPosition().y);
    if(sprite.getPosition().y < 0) sprite.setPosition(sprite.getPosition().x,0);
    

    if(isJump) {
        velY = -120;
        if(velX < 0) {
            state = "left-jump";
        } else if(velX > 0) {
            state = "right-jump";
        } else {
            state = "jump";
            
        }
        counter++;
        
        if(counter > 30) {
            counter = 0;
            isJump = false;

        } 
    }

    if(!isCollide) {
        isGrounded = false;

    }
    
    velY+=gravity*dt.asSeconds();
    
    sprite.move(velX*dt.asSeconds(),0);
    collisionX(platforms);

   
    sprite.move(0,velY*dt.asSeconds());
    collisionY(platforms);

    
    touchFruit(fruits,camera,score,scoreFont);

    greenBar.setSize(sf::Vector2f(health*2,40));

    
    rightDust.update(dt,2);
    leftDust.update(dt,2);
    radius->update(dt,8,2);


}


void Player::draw(sf::RenderWindow* window) {

    if(this->state == "right") {
        rightAnim->draw(window,7,4,70);

    }

    if(this->state == "left") {
       
        leftAnim->draw(window,7,4,35);
    }

    if(this->state == "idle") {
        sprite.setTextureRect(sf::IntRect(0,70,32,32));
    
        window->draw(sprite);

    }

    if(this->state == "left-jump") {
        
        sprite.setTextureRect(sf::IntRect(0,0,32,32));
        window->draw(sprite);

    }

    if(this->state == "right-jump" || this->state == "jump") {
        sprite.setTextureRect(sf::IntRect(1*32,0,32,32));
        window->draw(sprite);

    }

    leftDust.draw(window);
    rightDust.draw(window);

    radius->draw(window);

    window->draw(redBar);
    window->draw(greenBar);
    
}




void Player::collisionX(std::vector<Platform>& platforms) {
    for(int i = 0;i<platforms.size();i++) {
        
        if(sprite.getGlobalBounds().intersects(platforms[i].getSprite().getGlobalBounds())) {
            isCollide = true;
            
        } else {
            isCollide = false;

        }
        if(isCollide) {
            if(velX > 0) {
                sprite.setPosition(platforms[i].getSprite().getPosition().x - sprite.getGlobalBounds().width,sprite.getPosition().y);
            }

            if(velX < 0) {
                sprite.setPosition(platforms[i].getSprite().getPosition().x+platforms[i].getSprite().getGlobalBounds().width,sprite.getPosition().y);
            }
        }
      
    }
}

void Player::collisionY(std::vector<Platform>& platforms) {

    for(int i = 0;i<platforms.size();i++) {
        if(sprite.getGlobalBounds().intersects(platforms[i].getSprite().getGlobalBounds())) {
            isCollide = true;
        } else {
            isCollide = false;
        }

        if(isCollide) {
            if(velY > 0) {   
                sprite.setPosition(sprite.getPosition().x,platforms[i].getSprite().getPosition().y-sprite.getGlobalBounds().height);
                isGrounded = true;
            
            } 

            if(velY < 0) {
                sprite.setPosition(sprite.getPosition().x,platforms[i].getSprite().getPosition().y + platforms[i].getSprite().getGlobalBounds().height);
            }
        }
    }
}

void Player::movement() {

    if(sf::Keyboard::isKeyPressed(sf::Keyboard::A) || sf::Keyboard::isKeyPressed(sf::Keyboard::Right)) {
        velX = -350;
        this->state = "left";
    } else if(sf::Keyboard::isKeyPressed(sf::Keyboard::D) || sf::Keyboard::isKeyPressed(sf::Keyboard::Left)) {
        velX = 350;
        this->state = "right";

    } else {
        velX = 0;
        this->state = "idle";
    }

    if(sf::Keyboard::isKeyPressed(sf::Keyboard::Space) || sf::Keyboard::isKeyPressed(sf::Keyboard::W) || sf::Keyboard::isKeyPressed(sf::Keyboard::Up)) {
        if(isGrounded) {

            isJump = true;
            isGrounded = false;
        

        }
    }

    if(velX < 0 && isGrounded) {
        rightDust.add(3,sprite.getPosition().x+sprite.getGlobalBounds().width,(sprite.getPosition().y+sprite.getGlobalBounds().height)-15,Random::range(5,25),80,-10,sf::Color(186, 186, 186));
    }

    if(velX > 0 && isGrounded) {
        leftDust.add(3,sprite.getPosition().x,(sprite.getPosition().y+sprite.getGlobalBounds().height)-15,Random::range(5,25),-80,-10,sf::Color(186, 186, 186));
    }
}


void Player::touchFruit(std::vector<Fruit>& fruits,Camera& camera,int& score,StringFont& scoreFont) {

    for(unsigned long int i = 0;i<fruits.size();i++) {
        if(sprite.getGlobalBounds().intersects(fruits[i].getSprite().getGlobalBounds()) && isJump) {
            radius->setVisible(true,fruits[i].getSprite().getPosition().x,fruits[i].getSprite().getPosition().y);
            fruits[i].changePosition();

            health-=8;

            if(fruits.size() >= 4) {
                fruits.erase(fruits.begin() + i);
            }
            camera.shake();
            score++;
            scoreFont.setString("Score " + std::to_string(score));


            
        } else if(sprite.getGlobalBounds().intersects(fruits[i].getSprite().getGlobalBounds()) && !isJump) {
            fruits[i].colCounter++;

            if(fruits[i].colCounter >= 60) {
                fruits[i].colCounter = 0;

                health-=5;
            }
        }
    }

}


sf::Sprite* Player::getSpriteAddress() {
    return &this->sprite;

}


float Player::getHealth() {
    return this->health;
    
}