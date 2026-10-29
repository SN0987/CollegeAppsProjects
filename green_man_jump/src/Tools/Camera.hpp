#pragma once
#include <SFML/Window.hpp>
#include <SFML/Graphics.hpp>
#include <iostream>
#include "Camera.hpp"
#include "Random.hpp"




//code from reflection 
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