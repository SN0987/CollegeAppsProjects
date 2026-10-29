#include <SFML/Window.hpp>
#include <SFML/Graphics.hpp>
#include <iostream>
#include "Camera.hpp"






Camera::Camera() {
    cam.reset(sf::FloatRect(0,0,800,600));
    cam.setViewport(sf::FloatRect(0.f,0.f,1.0f,1.0f));
    
    isShake = false;

    changeTime = 0;
    shakeTime = 0;
    shakeTimeTwo = 0;
    c = 0;



}



void Camera::update(sf::RenderWindow* window) {


    if(isShake) {
        

        shakeTime++;

        if(shakeTime >= 5) {
            shakeTime = 0;
            cam.rotate(1.8f);
            cam.zoom(0.9f);
        }

        shakeTimeTwo++;
        
        if(shakeTimeTwo >= 8) {
            shakeTimeTwo = 0;
            cam.rotate(-2.f);
            cam.zoom(1.3f);

        }
        changeTime++;

        if(changeTime >= 40) {
            changeTime = 0;
            cam.reset(sf::FloatRect(0,0,800,600));
            isShake = false;

        }
    }
    
    c++;

    if(c >= 60) {
        c = 0;
        cam.reset(sf::FloatRect(0,0,800,600));
        cam.setViewport(sf::FloatRect(0.f,0.f,1.f,1.f));
        
    }
    window->setView(cam);

    

}


void Camera::shake() {
    if(!isShake) {
        isShake = true;

    }
}