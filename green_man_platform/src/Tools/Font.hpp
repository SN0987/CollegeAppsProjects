#pragma once
#include <iostream>
#include <SFML/Window.hpp>
#include <SFML/Graphics.hpp>



class Font {
    private:


    public:
        sf::Font* font_pixel;
        sf::Font* font_basic;


        Font();

        ~Font();

        void destroyed();
        

};