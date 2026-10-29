#pragma once
#include <SFML/Window.hpp>
#include <SFML/Graphics.hpp>
#include <iostream>
#include "../Tools/Random.hpp"
#include "../Sprites/Player.hpp"
#include "../Sprites/Platform.hpp"
#include "../Tools/StringFont.hpp"
#include "../Tools/Snow.hpp"
#include "../Tools/Camera.hpp"

namespace GreenMan {
    class GameScreen {
        private:
            sf::RenderWindow* window;

            
        public:
            GameScreen(int width,int height,std::string title);


            void menu();

            void game();

            ~GameScreen();


    };
}