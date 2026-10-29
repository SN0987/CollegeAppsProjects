#include "Player.hpp"




GreenMan::Player::Player(float x,float y,Camera* cam) {
    texture = new sf::Texture();
    texture->loadFromFile("assets/player.png");

    this->cam = cam;


    sprite.setTexture(*texture);
    sprite.setTextureRect(sf::IntRect(0,67,32,32));
    sprite.setPosition(x,y);
    sprite.setScale(sf::Vector2f(3,3));

    setVelX(0);
    setVelY(0);

    state = "idle";
    
    isJump = false;
    isGround = false;

    left.init(&sprite,1);
    right.init(&sprite,1);
    
    spacePress = true;

    grav = 300;

    jumpValue = 0;
    jumpCounter = 0;
    jumpVel = 0;


    bar.setFillColor(sf::Color(227, 80, 75));
    bar.setSize(sf::Vector2f(200,30));
    bar.setPosition(sf::Vector2f(30,80));
    
    barTwo.setFillColor(sf::Color(59, 173, 72));
    barTwo.setSize(sf::Vector2f(jumpValue*2,30));
    barTwo.setPosition(30,80);

    showBar = false;



}

void GreenMan::Player::update(sf::Time& dt) {

    if(!isGround) {
        setVelY(grav);
    }
    

    jump();

    movement();
    
  


    sprite.move(sf::Vector2f(velX*dt.asSeconds(),0));


    sprite.move(sf::Vector2f(0,velY*dt.asSeconds()));

    bounds();

  

    if(jumpValue >= 100) jumpValue = 100;

    barTwo.setSize(sf::Vector2f(jumpValue*2,30));

    rightParts.update(dt,2);
    leftParts.update(dt,2);

}


void GreenMan::Player::bounds() {
    if(sprite.getPosition().y >= 600-96) {
        sprite.setPosition(sprite.getPosition().x,600-96);
        isGround = true;
    }

    if(sprite.getPosition().x <= 0) sprite.setPosition(0,sprite.getPosition().y);
    if(sprite.getPosition().x >= 800-96) sprite.setPosition(800-96,sprite.getPosition().y);

    if(sprite.getPosition().y <= 0) sprite.setPosition(sprite.getPosition().x,0);

}

void GreenMan::Player::draw(sf::RenderWindow* window) {
    if(state == "idle") {
        sprite.setTextureRect(sf::IntRect(0,67,32,32));
        window->draw(sprite);

        
    }

    if(state == "right") {
        right.animate(window,5,4,67);
    }

    if(state == "left") {
        left.animate(window,5,4,35);
    }

    if(state == "left-jump") {
        sprite.setTextureRect(sf::IntRect(0,0,32,32));
        window->draw(sprite);
    }

    if(state == "right-jump" || state == "jump") {
        sprite.setTextureRect(sf::IntRect(32,0,32,32));
        window->draw(sprite);
    }

    if(showBar) {
        window->draw(bar);
        window->draw(barTwo);
    }
    
    rightParts.draw(window);
    leftParts.draw(window);

}



GreenMan::Player::~Player() {
    destroy();


}


void GreenMan::Player::jump() {
    if(isJump) {
        setVelY(-jumpVel);
        
        jumpCounter++;

        if(velX < 0) {
            state = "left-jump";
        }

        if(velX > 0) {
            state = "right-jump";
        }

        if(jumpCounter >= 39) {
            grav = jumpVel/2.2;

            setVelY(grav);
            jumpVel = 0;
            jumpValue = 0;
            if(showBar) showBar = false;

            isJump = false;

        }
    }

    if(isGround) {
        jumpCounter = 0;
    }

}

void GreenMan::Player::movement() {
    if(sf::Keyboard::isKeyPressed(sf::Keyboard::Right) || sf::Keyboard::isKeyPressed(sf::Keyboard::D)) {
        velX = 375;
        state = "right";
    } else if(sf::Keyboard::isKeyPressed(sf::Keyboard::Left) || sf::Keyboard::isKeyPressed(sf::Keyboard::A)) {
        velX = -375;
        state = "left";
    } else {
        velX = 0;
        state = "idle";
    }

    if(sf::Keyboard::isKeyPressed(sf::Keyboard::Space) && isGround) {
        if(jumpValue < 100) {
            jumpVel+=11;
            jumpValue+=1.2;


            if(!showBar) {
                showBar = true;
            }

            std::cout << jumpVel << std::endl;
            
        }
    }

    if(sf::Keyboard::isKeyPressed(sf::Keyboard::W) || sf::Keyboard::isKeyPressed(sf::Keyboard::Up)) {
        if(isGround) {
            isJump = true;
            isGround = false;
            cam->shake();
        }
    }

    if(velX < 0 && isGround) {
        rightParts.add(3,sprite.getPosition().x+sprite.getGlobalBounds().width,(sprite.getPosition().y+sprite.getGlobalBounds().height)-15,Random::getRandom(5,25),80,-10,sf::Color(186, 186, 186));
    }

    if(velX > 0 && isGround) {
        leftParts.add(3,sprite.getPosition().x,(sprite.getPosition().y+sprite.getGlobalBounds().height)-15,Random::getRandom(5,25),-80,-10,sf::Color(186, 186, 186));
    }
}