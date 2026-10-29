#include "Font.hpp"


Font::Font() 
    : font_basic(nullptr),font_pixel(nullptr)
{
    font_basic = new sf::Font();
    font_pixel = new sf::Font();

    font_basic->loadFromFile("fonts/font_basic.ttf");
    font_pixel->loadFromFile("fonts/font_pixel.ttf");

}

Font::~Font() {

    if(font_basic != nullptr && font_pixel != nullptr) {
        delete font_basic;
        delete font_pixel;

        font_basic = nullptr;
        font_pixel = nullptr;


        if(font_basic == nullptr && font_pixel == nullptr) {
            std::cout << "Destroyed Font" << std::endl;

        }
    }

    
}

void Font::destroyed() {

    if(font_basic != nullptr && font_pixel != nullptr) {
        delete font_basic;
        delete font_pixel;

        font_basic = nullptr;
        font_pixel = nullptr;


        if(font_basic == nullptr && font_pixel == nullptr) {
            std::cout << "Destroyed Font" << std::endl;

        }
    }
}