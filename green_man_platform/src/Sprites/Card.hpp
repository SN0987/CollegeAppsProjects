#pragma once
#include <iostream>
#include <SFML/Window.hpp>
#include <SFML/Graphics.hpp>
#include "../GameObject/Object.hpp"
#include "../Tools/Random.hpp"
#include "../Tools/StringFont.hpp"



class Card : public Object {
    private:


        int color_name;

        bool isVisible;

        float startposx,startposy;


        void selectColor();
    public:
        Card(TextureManager* manager,Window* window,int color_name,float x,float y);

        void setColorName(int color_name);


        int getColorName();


        void setVisible(bool isVisible);

        bool getIsVisible();

        void update(float dt,float startX,float startY);

        void draw();

        void collideWithObject(Object* object,int& score,StringFont& font,Card& card);

        
};