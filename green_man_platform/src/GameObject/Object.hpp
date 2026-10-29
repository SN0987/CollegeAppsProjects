#pragma once
#include <iostream>
#include <SFML/Window.hpp>
#include <SFML/Graphics.hpp>
#include "TextureManager.hpp"
#include "../Window/Window.hpp"
#include <vector>
#include "Type.hpp"
#include "../Sprites/Platform.hpp"

class Object {
    protected:

        TextureManager* manager;

        sf::Sprite sprite;

        sf::RectangleShape collider;
        
        Window* window;


        float velX,velY;

        TYPE type;

        
    public:
        Object(Window* window,TextureManager* manager);

        Object();

        void init(Window* window,TextureManager* manager);
        
        void setSpeed(float velX,float velY);


        float getVelX();

        float getVelY();

        sf::Sprite getSprite();

        sf::RectangleShape getCollider();



        virtual void update(float dt) {}

        virtual void update(float dt,std::vector<Platform>& objects) {}

        virtual void update(float dt,float startX,float startY) {}
        

        

        virtual void draw() {}
        

        void setType(TYPE type);

        TYPE getType();

        
        ~Object();  
};