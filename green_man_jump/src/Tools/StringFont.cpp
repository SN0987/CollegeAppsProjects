#include <SFML/Window.hpp>
#include <SFML/Graphics.hpp>
#include <iostream>
#include "StringFont.hpp"



StringFont::StringFont(std::string path,std::string s,sf::Color color,int size,float x,float y) 
    : font(nullptr)
{
    font = new sf::Font();
    font->loadFromFile(path);

    text.setFont(*font);
    text.setFillColor(color);
    text.setCharacterSize(size);
    text.setString(s);
    text.setPosition(x,y);

}


void StringFont::setSize(int size) {
    text.setCharacterSize(size);

}

void StringFont::setColor(sf::Color color) {
    text.setFillColor(color);

}


void StringFont::setString(std::string s) {
    this->s = s;
    text.setString(s);

}

void StringFont::draw(sf::RenderWindow* window) {
    window->draw(text);

}

void StringFont::setPosition(float x,float y) {
    text.setPosition(x,y);
    
}

StringFont::~StringFont() {
    delete font;
    font = nullptr;

    if(font == nullptr) {
        std::cout << "Font is Destroyed" << std::endl;

    }
}


sf::Text StringFont::getText() {
    return this->text;
    
}