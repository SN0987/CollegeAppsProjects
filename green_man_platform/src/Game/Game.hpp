#pragma once
#include <iostream>
#include <SFML/Window.hpp>
#include <SFML/Graphics.hpp>
#include "../Window/Window.hpp"
#include "../GameObject/TextureManager.hpp"
#include "../Sprites/Player.hpp"
#include "../Sprites/Platform.hpp"
#include <vector>
#include <cmath>
#include "../Tools/Shower.hpp"
#include "../Sprites/Card.hpp"
#include "../Tools/StringFont.hpp"
#include "../Tools/Font.hpp"
#include "../Tools/Snow.hpp"

class Game {
    private:
        Window window;
        TextureManager manager;


      

        Font font;
        
        

    public:
        Game(int width,int height,std::string title);

        

        void menu();

        void game();

        ~Game();
};