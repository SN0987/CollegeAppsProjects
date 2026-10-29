#pragma once
#include <iostream>
#include <SFML/Window.hpp>
#include <SFML/Graphics.hpp>
#include "../Tools/Animator.hpp"
#include "Platform.hpp"
#include <vector>
#include "Fruit.hpp"
#include "Particles.hpp"
#include "../Tools/Camera.hpp"
#include "Radius.hpp"
#include "../Tools/StringFont.hpp"

class Player {
    private:   
        sf::Sprite sprite;
        sf::Texture* texture;

        std::string state;

        float velX,velY,gravity;

        
        bool isCollide,isJump,isGrounded;

        Animator* leftAnim;
        Animator* rightAnim;

        sf::RectangleShape redBar;
        sf::RectangleShape greenBar;

        float health;
        
        int counter;
        
        void collisionX(std::vector<Platform>& platforms);

        void collisionY(std::vector<Platform>& platforms);


        void movement();

        void touchFruit(std::vector<Fruit>& fruits,Camera& camera,int& score,StringFont& scoreFont);

        Particles leftDust;
        Particles rightDust;

        Radius* radius;




    public:
        Player(float x,float y);


        void update(sf::Time& dt,std::vector<Platform>& platforms,std::vector<Fruit>& fruits,Camera& camera,int& score,StringFont& scoreFont);


        void draw(sf::RenderWindow* window);

        


        sf::Sprite getSprite();

        sf::Sprite* getSpriteAddress();

        float getHealth();
    

        
};