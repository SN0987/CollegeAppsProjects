#pragma once
#include <iostream>
#include <SFML/Window.hpp>
#include <SFML/Graphics.hpp>



class TextureManager {
    public:
        sf::Texture *textures[5];

        TextureManager();

        

        ~TextureManager();

        void destroyed();
};