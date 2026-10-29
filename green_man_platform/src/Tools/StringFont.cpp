#include "StringFont.hpp"



StringFont::StringFont(sf::Font* font,std::string s,sf::Color color,int size,float x,float y) {
   

    text.setFont(*font);
    text.setFillColor(color);
    text.setCharacterSize(size);
    text.setString(s);
    text.setPosition(x,y);

}

StringFont::StringFont() {
    
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


sf::Text StringFont::getText() {
    return this->text;
    
}

void StringFont::init(sf::Font* font,std::string s,sf::Color color,int size,float x,float y) {
    text.setFont(*font);
    text.setFillColor(color);
    text.setCharacterSize(size);
    text.setString(s);
    text.setPosition(x,y);
}