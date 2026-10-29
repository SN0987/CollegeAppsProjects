#pragma once
#include <iostream>
#include <SFML/Window.hpp>
#include <SFML/Graphics.hpp>



class Radius {
    private:
    
        float r,maxr,minr;

        sf::RectangleShape shape;

        sf::Texture* texture;

        bool isVisible;

        int increaseTime;


    public:
        Radius(float r,float maxr,float x,float y);  

        void update(sf::Time& dt,int howmuch,int time);

        
        void draw(sf::RenderWindow* window);


        void setVisible(bool visibility,float x,float y);

};