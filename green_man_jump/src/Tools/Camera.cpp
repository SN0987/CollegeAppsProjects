#include "Camera.hpp"

//from reflection




Camera::Camera() {
    cam.reset(sf::FloatRect(0,0,800,600));
    cam.setViewport(sf::FloatRect(0.f,0.f,1.0f,1.0f));
    
    isShake = false;

    changeTime = 0;
    shakeTime = 50;
    shakeTimeTwo = 0;
    c = 0;



}



void Camera::update(sf::RenderWindow* window) {


    if(isShake) {
        shakeTime--;

        if(shakeTime > 0) {
            cam.move(sf::Vector2f(Random::getRandom(0,18)-9,Random::getRandom(0,18)-9));
        }

        if(shakeTime < 0) {
            shakeTime = 30;
            isShake = false;
            cam.reset(sf::FloatRect(0,0,800,600));
            cam.setViewport(sf::FloatRect(0.f,0.f,1.f,1.f));

        }
    }
    
    /*c++;  

    if(c >= 60) {
        c = 0;
        cam.reset(sf::FloatRect(0,0,800,600));
        cam.setViewport(sf::FloatRect(0.f,0.f,1.f,1.f));
        
    }*/

    window->setView(cam);

    

}


void Camera::shake() {
    if(!isShake) {
        isShake = true;

    }
}