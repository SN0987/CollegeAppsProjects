#pragma once
#include <SFML/Window.hpp>
#include <SFML/Graphics.hpp>
#include <iostream>



class Camera {
    private:
        sf::View cam;

        int shakeTime,shakeTimeTwo;
        int changeTime;

        bool isShake;

        int c;
        

    public:
        Camera();



        void shake();


        void update(sf::RenderWindow* window);


        sf::View getCamera();
};