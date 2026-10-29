#pragma once
#include <SFML/Window.hpp>
#include <SFML/Graphics.hpp>
#include <iostream>



class StringFont {
    private:
        sf::Font* font;
        sf::Text text;

        std::string s;

        sf::Color color;


    public: 
        StringFont(std::string path,std::string s,sf::Color color,int size,float x,float y);

        StringFont();


        void setSize(int size);

        void setColor(sf::Color color);

        void setPosition(float x,float y);
        
        void setString(std::string s);

        void draw(sf::RenderWindow* window);
};