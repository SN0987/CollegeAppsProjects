#pragma once
#include <iostream>
#include <SFML/Window.hpp>
#include <SFML/Graphics.hpp>
#include "../GameObject/Object.hpp"
#include "../Tools/ParticlesList.hpp"
#include "../Tools/Random.hpp"
#include "Platform.hpp"


class Player : public Object {
    private:



        std::string animateState;


        void movement();


        void bounds();


        
        void animate(int maxFrame,int fps);


        int time,frame;

        bool isJump,onGround;
        
        int jumpCount;
        
        int airTime;

        bool isCol;

        float gravity;

        sf::Clock changeSpeed;

        int jumpingAround;

        

        ParticleList ptLeft;
        ParticleList ptRight;




    public:
        Player(float x,float y,Window* window, TextureManager* manager);


        
        void update(float dt,std::vector<Platform>& objects);

        void colX(std::vector<Platform>& objects);

        void colY(std::vector<Platform>& objects);


        bool getCol();

        

        void setIsJump(bool isJump);

        bool getIsJump();


        int getJumpingAround();

        

        void draw();

        void setCol(bool isCol);

        bool getIsCol();

        void setJumpingAround(int jumpingAround);
};