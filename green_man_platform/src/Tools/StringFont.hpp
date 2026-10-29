#pragma once
#include <SFML/Window.hpp>
#include <SFML/Graphics.hpp>
#include <iostream>


//code from greenman ver 1


class StringFont {
    private:
        sf::Text text;

        std::string s;

        sf::Color color;

        



    public: 
        StringFont(sf::Font* font,std::string s,sf::Color color,int size,float x,float y);

        StringFont();

        void init(sf::Font* font,std::string s,sf::Color color,int size,float x,float y);

        void setSize(int size);

        void setColor(sf::Color color);

        void setPosition(float x,float y);
        
        void setString(std::string s);

        void draw(sf::RenderWindow* window);

        sf::Text getText();
        

};