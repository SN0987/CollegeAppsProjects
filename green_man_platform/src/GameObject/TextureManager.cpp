#include "TextureManager.hpp"




TextureManager::TextureManager() {


    for(int i = 0;i<sizeof(textures)/sizeof(textures[0]);i++) {
        textures[i] = nullptr;
        textures[i] = new sf::Texture();
    }

    textures[0]->loadFromFile("assets/player.png");
    textures[1]->loadFromFile("assets/main_platform.png");
    textures[2]->loadFromFile("assets/cards.png");
    textures[3]->loadFromFile("assets/Buttons.png");
    textures[4]->loadFromFile("assets/Particles.png");
    
}

        

TextureManager::~TextureManager() {
    
    for(int i = 0;i<sizeof(textures)/sizeof(textures[0]);i++) {

        if(textures[i] != nullptr) {
            delete textures[i];
            textures[i] = nullptr;
            
            if(textures[i] == nullptr) {
                std::cout << "Destroyed Textures" << std::endl;

            }
        }
        
    }
}

void TextureManager::destroyed() {
    for(int i = 0;i<sizeof(textures)/sizeof(textures[0]);i++) {

        if(textures[i] != nullptr) {
            delete textures[i];
            textures[i] = nullptr;
            
            if(textures[i] == nullptr) {
                std::cout << "Destroyed Textures" << std::endl;

            }
        }
        
    }
}