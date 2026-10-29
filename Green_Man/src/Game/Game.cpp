#include <iostream>
#include <SFML/Window.hpp>
#include <SFML/Graphics.hpp>
#include "../Sprites/Platform.hpp"
#include "Game.hpp"
#include "../Tools/Random.hpp"
#include "../Sprites/Player.hpp"
#include "../Tools/Camera.hpp"
#include "../Sprites/Fruit.hpp"
#include "../Sprites/Bullet.hpp"
#include "../Sprites/Particles.hpp"
#include "../Sprites/Radius.hpp"
#include "../Sprites/Snow.hpp"
#include "../Tools/StringFont.hpp"
#include <vector>


Game::Game(int width,int height,std::string title) {
    this->width = width;
    this->height = height;

    this->title = title;

    window = new sf::RenderWindow(sf::VideoMode(width,height),title,sf::Style::Close);


    menu();

}


void Game::menu() {

    sf::Clock deltaClock;

    StringFont titleFont("fonts/font_pixel.ttf","Green Man and His Fruits",sf::Color(33, 158, 110),80,20,10);

    Snow snow(65,sf::Color(209, 85, 69));


    StringFont clickFont("fonts/font_pixel.ttf","Click To Play",sf::Color(81, 81, 189),80,192,450);

    sf::Clock changeClock;
    sf::Clock changeClockTwo;


    while(window->isOpen()) {
        sf::Event event;

        sf::Time dt = deltaClock.restart();

        while(window->pollEvent(event)) {
            if(event.type == sf::Event::Closed) {
                window->close();
            }

            if(event.type == sf::Event::KeyPressed) {
                if(event.key.code == sf::Keyboard::Escape) {
                    window->close();
                    
                }

                if(event.key.code == sf::Keyboard::Space) {
                    game();

                }

                
            }

            if(event.type == sf::Event::MouseButtonPressed) {
                if(event.mouseButton.button == sf::Mouse::Left) {
                    game();

                }
            }
        }

        if(changeClock.getElapsedTime().asMilliseconds() >= 800) {
            changeClock.restart();
            clickFont.setString("");
        }

        if(changeClockTwo.getElapsedTime().asMilliseconds() >= 1200) {
            changeClockTwo.restart();
            clickFont.setString("Click To Play");
            
        }

        snow.update(dt);

        window->clear(sf::Color(255,255,255));

        snow.draw(window);
        

        titleFont.draw(window);
        clickFont.draw(window);
        window->display();

        window->setFramerateLimit(60);
    }
}


void Game::game() {

    sf::Clock deltaClock;


    

    Player player(0,250);

    std::vector<Platform> platforms;

    platforms.push_back(Platform(800/2-(288/2),300,9,12,-150,0,sf::Color(66, 135, 245)));
    platforms.push_back(Platform(-224/2,420,7,10,-150,0,sf::Color(237, 78, 66)));
    platforms.push_back(Platform(700,420,7,10,-150,0,sf::Color(198, 52, 235)));

    Camera gameCam;

    Bullet bullet(player.getSpriteAddress());

    Radius radius(20,110,0,0);
    radius.setVisible(false,0,0);

    Snow snow(65,sf::Color(3, 173, 252));

    std::vector<Fruit> fruits;  

    fruits.push_back(Fruit(Random::range(800),0,0,50));
    fruits.push_back(Fruit(Random::range(800),0,0,60));
    fruits.push_back(Fruit(Random::range(800),0,0,70));
    
    int score = 0;

    StringFont scoreFont("fonts/font_basic.ttf","Score " + std::to_string(score),sf::Color(57, 179, 114),50,30,30);

    while(window->isOpen()) {
        sf::Event event;

        sf::Time dt = deltaClock.restart();

        sf::Vector2f mPos = window->mapPixelToCoords(sf::Mouse::getPosition(*window));
        while(window->pollEvent(event)) {
            if(event.type == sf::Event::Closed) {
                window->close();
            }

            if(event.type == sf::Event::KeyPressed) {
                if(event.key.code == sf::Keyboard::Escape) {
                    window->close();
                    
                }              
            }

            
        }

        if(sf::Mouse::isButtonPressed(sf::Mouse::Button::Left)) {
            for(Fruit& fruit : fruits) {
                if(fruit.getSprite().getGlobalBounds().contains(mPos)) {
                    radius.setVisible(true,fruit.getSprite().getPosition().x,fruit.getSprite().getPosition().y);
                    fruit.changePosition();
                    gameCam.shake();
                    fruits.push_back(Fruit(Random::range(800),-100,0,Random::range(50,80)));
                    score++;
                    scoreFont.setString("Score " + std::to_string(score));
                }
            }
        }
        
        for(int i = 0;i<fruits.size();i++) {
            if(fruits[i].getSprite().getGlobalBounds().intersects(bullet.getSprite().getGlobalBounds())) {
                radius.setVisible(true,fruits[i].getSprite().getPosition().x,fruits[i].getSprite().getPosition().y);
                score++;
                scoreFont.setString("Score " + std::to_string(score));
                if(fruits.size() >= 4) {
                    fruits.erase(fruits.begin()+i);
                } else {
                    fruits[i].changePosition();
                    fruits[i].setSpeed(0,fruits[i].getVelY()+10);
                }

                gameCam.shake();
            }

            if(fruits[i].getSprite().getPosition().y > 600) {
                menu();

            }
        }

      
        if(score >= 1000) {
            menu();
        }

        if(player.getHealth() <= 0 || player.getSprite().getPosition().y > 600) {
            menu();

        }

        

        player.update(dt,platforms,fruits,gameCam,score,scoreFont);

        bullet.update(dt,mPos);

        radius.update(dt,8,2);
        snow.update(dt);


        for(Fruit &fruit : fruits) {
            fruit.update(dt);

        }


        window->clear(sf::Color(255,255,255));
        gameCam.update(window);


        for(Platform p : platforms) {
            p.draw(window);
        }

        for(Fruit &fruit : fruits) {
            fruit.draw(window);
        }

        scoreFont.draw(window);

        
        player.draw(window);

        bullet.draw(window);

        radius.draw(window);

        snow.draw(window);

    

        window->display();

        window->setFramerateLimit(60);
    }

}