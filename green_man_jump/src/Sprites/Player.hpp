#pragma once
#include <iostream>
#include <SFML/Window.hpp>
#include <SFML/Graphics.hpp>
#include "GameSprite.hpp"
#include "../Tools/Animator.hpp"
#include "../Tools/Particles.hpp"
#include "../Tools/Random.hpp"
#include "../Tools/Camera.hpp"

namespace GreenMan {
    class Player : public GameSprite {
        private:
            std::string state;

            float jumpVel,grav;

            bool isJump,isGround;

            void movement();

            void bounds();

            GreenMan::Animator left,right;

            bool spacePress;

            Particles leftParts,rightParts;

            sf::RectangleShape bar;

            sf::RectangleShape barTwo;

            float jumpValue;

            int jumpCounter;

            bool showBar;
            
            void jump();

            Camera* cam;

        public:
            Player(float x,float y,Camera* cam);

            void update(sf::Time& dt);

            void draw(sf::RenderWindow* window);



            ~Player();

    };
}
