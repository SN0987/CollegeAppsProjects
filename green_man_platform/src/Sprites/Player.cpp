#include "Player.hpp"



Player::Player(float x,float y,Window* window, TextureManager* manager) : Object(window,manager)  {
    sprite.setPosition(x,y);
    sprite.setTexture(*manager->textures[0]);
    sprite.setTextureRect(sf::IntRect(0,70,32,32));
    sprite.setScale(sf::Vector2f(3,3));

    collider.setFillColor(sf::Color(0,0,0));
    collider.setSize(sf::Vector2f(60,84));
    collider.setPosition(x,y);
    
    setSpeed(0,0);

    animateState = "idle";


    frame = 0;
    time = 0;


    
    isJump = false;

    setType(PLAYER);

    isCol = false;

    jumpCount = 0;

    airTime = 0;

    gravity = 240;


    ptLeft.init(manager,window);
    ptRight.init(manager,window);

    

    onGround = false;

    jumpingAround = 0;


}


void Player::update(float dt,std::vector<Platform>& objects) {


    if(changeSpeed.getElapsedTime().asSeconds() >= 45) {

        if(gravity < 600) {
            gravity+=60;
        }
        changeSpeed.restart();
    }

    if(!isJump) {
        velY = gravity;
    }

    if(isJump) {
        jumpCount++;

        if(velX < 0) {
            animateState = "jump-left";
        }

        if(velX > 0) {
            animateState = "jump-right";
        }

        if(jumpCount >= 70) {
            jumpCount = 0;
            velX = 0;
            isJump = false;
            
            
        }
    }


    if(animateState == "left" || animateState == "right") {
        animate(4,6);

    }


    bounds();
    movement();


    collider.move(velX*dt,0);
    colX(objects);
    collider.move(0,velY*dt);
    colY(objects);

    sprite.setPosition(collider.getPosition().x-20,collider.getPosition().y-4);

    ptLeft.update(dt,3,1);
    ptRight.update(dt,3,1);


}

void Player::draw() {

    //window->getWindow()->draw(collider);
    

    if(animateState == "left") {
        sprite.setTextureRect(sf::IntRect(frame*32,35,32,32));
    } 

    if(animateState == "right") {
        sprite.setTextureRect(sf::IntRect(frame*32,70,32,32));
     
    }

    if(animateState == "idle") {
        sprite.setTextureRect(sf::IntRect(0,70,32,32));

    }


    if(animateState == "jump-left") {
        sprite.setTextureRect(sf::IntRect(0,0,32,32));

    }

    if(animateState == "jump-right") {
        sprite.setTextureRect(sf::IntRect(1*32,0,32,32));
    }


    ptRight.draw();
    ptLeft.draw();
    window->getWindow()->draw(sprite);
}


void Player::movement() {

    if(sf::Keyboard::isKeyPressed(sf::Keyboard::A) && !isJump || sf::Keyboard::isKeyPressed(sf::Keyboard::Left) && !isJump) {
        velX = -400;

        ptLeft.add(sprite.getPosition().x+sprite.getGlobalBounds().width,sprite.getPosition().y+sprite.getGlobalBounds().height,Random::getRange(5,15),50,0,0,sf::Color(13, 145, 55),2);
        animateState = "left";
    } else if(sf::Keyboard::isKeyPressed(sf::Keyboard::D) && !isJump || sf::Keyboard::isKeyPressed(sf::Keyboard::Right) && !isJump) {

        
        velX = 400;
        ptRight.add(sprite.getPosition().x,sprite.getPosition().y+sprite.getGlobalBounds().height,Random::getRange(5,15),-50,0,0,sf::Color(13, 145, 55),2);
        animateState = "right";
    } else {
      

        if(!isJump) {
            animateState = "idle";
            velX = 0;
        }
            

    }

    /*if(sf::Keyboard::isKeyPressed(sf::Keyboard::W)) {
        velY = -400;
    } else if(sf::Keyboard::isKeyPressed(sf::Keyboard::S)) {
        velY = 400;
    } else {
        velY = 0;
    }*/
}



void Player::animate(int maxFrame,int fps) {
    time++;

    if(time >= fps) {

        if(frame >= maxFrame) {
            frame = 0;
        } else {
            frame++;
        }
        
        time = 0;
    }
}


void Player::bounds() {
    if(collider.getPosition().x < 0) {
        collider.setPosition(0,collider.getPosition().y);

    }

    if(collider.getPosition().x >= window->getWidth()-collider.getGlobalBounds().width) {
        collider.setPosition(window->getWidth()-collider.getGlobalBounds().width,collider.getPosition().y);
    }




    
}

void Player::colX(std::vector<Platform>& objects) {
    for(auto i = 0;i<objects.size();i++) {
        if(collider.getGlobalBounds().intersects(objects[i].getCollider().getGlobalBounds()) && !isCol) {
            if(velX < 0) {
                collider.setPosition(objects[i].getCollider().getPosition().x+objects[i].getCollider().getGlobalBounds().width,collider.getPosition().y);
                velX = 0;
            }

            if(velX > 0) {
                collider.setPosition(objects[i].getCollider().getPosition().x-collider.getGlobalBounds().width,collider.getPosition().y);
                velX = 0;
            }
        }
    }
}


void Player::setCol(bool isCol) {
    this->isCol = isCol;
}


bool Player::getIsCol() {
    return isCol;
}

void Player::colY(std::vector<Platform>& objects) {
    for(auto i = 0;i<objects.size();i++) {
        if(objects[i].getCollider().getGlobalBounds().intersects(collider.getGlobalBounds())) {
            if(velY < 0) {
                collider.setPosition(collider.getPosition().x,objects[i].getCollider().getPosition().y+objects[i].getCollider().getGlobalBounds().height);
                velX = 0;
                velY*=-1;
                isCol = true;


            } else if(velY > 0) {
                collider.setPosition(collider.getPosition().x,objects[i].getCollider().getPosition().y-collider.getGlobalBounds().height);
                velY = objects[i].getVelY();
                isCol = true;
                jumpingAround = 0;
            } else {
                collider.setPosition(collider.getPosition().x,objects[i].getCollider().getPosition().y+objects[i].getCollider().getGlobalBounds().height);
                velY = objects[i].getVelY();
                isCol = true;
            }
        } else {
            isCol = false;
    

        }
    }
}


void Player::setIsJump(bool isJump) {
    this->isJump = isJump;
}

bool Player::getIsJump() {
    return this->isJump;
}

bool Player::getCol() {
    return this->isCol;
}

int Player::getJumpingAround() {
    return this->jumpingAround;

}


void Player::setJumpingAround(int jumpingAround) {
    this->jumpingAround = jumpingAround;
}