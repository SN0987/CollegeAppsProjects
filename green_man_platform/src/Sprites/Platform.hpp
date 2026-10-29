#pragma once
#include <iostream>
#include <SFML/Window.hpp>
#include <SFML/Graphics.hpp>
#include <iostream>
#include <SFML/Window.hpp>
#include <SFML/Graphics.hpp>
#include "../GameObject/TextureManager.hpp"
#include "../Window/Window.hpp"
#include <vector>
#include "../GameObject/Type.hpp"
#include "../Tools/Random.hpp"


class Platform  {
    private:

        sf::Clock changeSpeed;
        

        TextureManager* manager;

        sf::Sprite sprite;

        sf::RectangleShape collider;
        
        Window* window;


        float velX,velY;

        TYPE type;
    
    public:
        Platform(float x,float y,Window* window,TextureManager* manager);




        void update(float dt,float startX,float startY);

       

        void draw();


        void init(Window* window,TextureManager* manager);
        
        void setSpeed(float velX,float velY);


        float getVelX();

        float getVelY();

        sf::Sprite getSprite();

        sf::RectangleShape getCollider();

        
        void setType(TYPE type);

        TYPE getType();


        ~Platform();  
};