#include "Window.hpp"



Window::Window(float width,float height,std::string title) 
: window(nullptr)
{
    this->width = width;
    this->height = height;
    
    this->originalHeight = height;
    this->originalWidth = width;

    window = new sf::RenderWindow(sf::VideoMode(this->width,this->height),title,sf::Style::Close);

    this->scaleFactorX = 1;
    this->scaleFactorY = 1;
    
}


Window::Window() 
: window(nullptr)
{
    this->scaleFactorX = 1;
    this->scaleFactorY = 1;

}


void Window::init(float width,float height,std::string title) {
    this->width = width;
    this->height = height;

    this->originalHeight = height;
    this->originalWidth = width;

    window = new sf::RenderWindow(sf::VideoMode(this->width,this->height),title,sf::Style::Close);

    this->scaleFactorX = 1;
    this->scaleFactorY = 1;
}

void Window::setDimensions(float width,float height) {
    this->width = width;
    this->height = height;
}

float Window::getHeight() {
    return this->height;
}

float Window::getWidth() {
    return this->width;
}

float Window::getOriginalWidth() {
    return this->originalWidth;
}

float Window::getOriginalHeight() {
    return this->originalHeight;
}


sf::RenderWindow* Window::getWindow() {
    return this->window;
}


float Window::getScaleFactorX() {
    return this->scaleFactorX;
}

float Window::getScaleFactorY() {
    return this->scaleFactorY;
}

void Window::setScaleFactor() {
    this->scaleFactorX = (width/this->originalWidth);
    this->scaleFactorY = (height/this->originalHeight);
}

Window::~Window() {

    if(window != nullptr) {
        delete window;
        window = nullptr;

        if(window == nullptr) {
            std::cout << "Window Is Destroyed!" << std::endl;
        }
    }
   
}


void Window::destroy() {

    if(window != nullptr) {
        delete window;
        window = nullptr;

        if(window == nullptr) {
            std::cout << "Window Is Destroyed!" << std::endl;
        }
    }
   
}