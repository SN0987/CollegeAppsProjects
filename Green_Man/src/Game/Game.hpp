#pragma once
#include <SFML/Window.hpp>
#include <SFML/Graphics.hpp>
#include <iostream>




class Game {
    private:

        int width,height;

        std::string title;

        sf::RenderWindow* window;
    public:

        Game(int width,int height,std::string title);



        void menu();

        void game();
};