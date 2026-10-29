#pragma once
#include <iostream>
#include <SFML/Window.hpp>
#include <SFML/Graphics.hpp>




//Window Container
//Contains RenderWindow and the dimensions

class Window {
    private:

        float width,height;

        float originalWidth,originalHeight;


        sf::RenderWindow* window;

        float scaleFactorX,scaleFactorY;


    public:
        Window(float width,float height,std::string title);

        Window();

        void init(float width,float height,std::string title);

        void setDimensions(float width,float height);
        

        float getHeight();

        float getWidth();

        float getOriginalWidth();

        float getOriginalHeight();

        void setScaleFactor();

        float getScaleFactorX();

        float getScaleFactorY();


        sf::RenderWindow* getWindow();

        void destroy();

        ~Window();

        


};