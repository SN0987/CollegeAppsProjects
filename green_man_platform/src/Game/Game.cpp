#include "Game.hpp"




Game::Game(int width,int height,std::string title) {
    window.init(width,height,title);


    
    menu();
}


void Game::menu() {

    sf::Clock clock;


    sf::Sprite playButton;
    sf::Sprite quitButton;



    playButton.setTexture(*manager.textures[3]);
    playButton.setTextureRect(sf::IntRect(0,0,60,25));
    playButton.setColor(sf::Color(9, 59, 222));
    playButton.setScale(sf::Vector2f(4,4));
    playButton.setPosition(window.getWidth()/2-playButton.getGlobalBounds().width/2,window.getHeight()/2-playButton.getGlobalBounds().height/2-40);


    quitButton.setTexture(*manager.textures[3]);
    quitButton.setTextureRect(sf::IntRect(2*60,0,60,25));
    quitButton.setColor(sf::Color(227, 25, 2));
    quitButton.setScale(sf::Vector2f(4,4));
    quitButton.setPosition(window.getWidth()/2-quitButton.getGlobalBounds().width/2,window.getHeight()/2-quitButton.getGlobalBounds().height/2+130);
    

    StringFont playFont;
    playFont.init(font.font_pixel,"PLAY",sf::Color(0,0,0),60,0,0);
    playFont.setPosition(playButton.getPosition().x+(playButton.getGlobalBounds().width/2)-playFont.getText().getGlobalBounds().width/2,playButton.getPosition().y+(playButton.getGlobalBounds().height/2)-42);

    StringFont quitFont;
    quitFont.init(font.font_pixel,"QUIT",sf::Color(0,0,0),60,0,0);
    quitFont.setPosition(quitButton.getPosition().x+(quitButton.getGlobalBounds().width/2)-quitFont.getText().getGlobalBounds().width/2,quitButton.getPosition().y+(quitButton.getGlobalBounds().height/2)-42);


    StringFont titleFont;
    titleFont.init(font.font_pixel,"Green Man Platform",sf::Color(50, 168, 82),100,0,0);
    titleFont.setPosition(window.getWidth()/2-titleFont.getText().getGlobalBounds().width/2,20);

    Snow snow(60,sf::Color(63, 171, 60));
    Snow snowTwo(20,sf::Color(57, 103, 184));
    Snow snowThree(20,sf::Color(217, 63, 46));

    while(window.getWindow()->isOpen()) {
        sf::Event event;


        sf::Time dt = clock.restart();

        sf::Vector2f mousePos = window.getWindow()->mapPixelToCoords(sf::Mouse::getPosition(*window.getWindow()));
        while(window.getWindow()->pollEvent(event)) {
            if(event.type == sf::Event::Closed) {
                window.getWindow()->close();
            }

            if(event.type == sf::Event::KeyPressed) {
                if(event.key.code == sf::Keyboard::Escape) {
                    window.getWindow()->close();
                }                
            }

            if(event.type == sf::Event::MouseButtonPressed) {
                if(event.mouseButton.button == sf::Mouse::Left) {
                    if(playButton.getGlobalBounds().contains(mousePos)) {
                      
                        game();
                    }

                    if(quitButton.getGlobalBounds().contains(mousePos)) {
                        window.getWindow()->close();
                    }

                }
            }


        }



        if(playButton.getGlobalBounds().contains(mousePos)) {
            playButton.setColor(sf::Color(79, 118, 247));
        } else {
            playButton.setColor(sf::Color(9,59,222));
        }

        if(quitButton.getGlobalBounds().contains(mousePos)) {
            quitButton.setColor(sf::Color(245, 91, 73));
        } else {
            quitButton.setColor(sf::Color(227,25,2));
        }

        snow.update(dt);
        snowTwo.update(dt);
        snowThree.update(dt);
        window.getWindow()->clear(sf::Color(255,255,255));


        snow.draw(window.getWindow());
        snowTwo.draw(window.getWindow());
        snowThree.draw(window.getWindow());

        window.getWindow()->draw(playButton);
        window.getWindow()->draw(quitButton);

        playFont.draw(window.getWindow());
        quitFont.draw(window.getWindow());
        titleFont.draw(window.getWindow());


        window.getWindow()->display();

        window.getWindow()->setFramerateLimit(60);
    }
}

void Game::game() {


    std::vector<Platform> objects;

    Platform platform(Random::getRange(20,250),window.getHeight()/2-48/2,&window,&manager);

    Platform platformTwo(Random::getRange(424,776),-96,&window,&manager);

    platform.setSpeed(0,80);
    platformTwo.setSpeed(0,80);

    
    objects.push_back(platform);
    objects.push_back(platformTwo);

    Player player(objects[0].getCollider().getPosition().x+(objects[0].getCollider().getGlobalBounds().width/2),objects[0].getCollider().getPosition().y-100,&window,&manager);
    




    //line for the player

    sf::VertexArray line(sf::Lines,2);

    line[0].color = sf::Color(0,0,0);
    line[1].color = sf::Color(0,0,0);

    line[0].position = sf::Vector2f(-1,-1);
    line[1].position = sf::Vector2f(-1,-1);

    //end

    //Showers
    Shower shower;
    shower.init(110,&window,800/2,550,sf::Color(63, 171, 60));
    //end

    //Card
    Card card(&manager,&window,1,objects[0].getCollider().getPosition().x+(objects[0].getCollider().getGlobalBounds().width/2)-24,objects[0].getCollider().getPosition().y-30);
    
    card.setSpeed(objects[0].getVelX(),objects[0].getVelY());

    Card cardTwo(&manager,&window,1,objects[1].getCollider().getPosition().x+(objects[1].getCollider().getGlobalBounds().width/2)-24,objects[1].getCollider().getPosition().y-30);
    cardTwo.setSpeed(objects[1].getVelX(),objects[1].getVelY());
    //end


    //fonts

    int cardsCollected = 0;
    Card iconCard(&manager,&window,1,10,10);

    StringFont scoreFont;
    scoreFont.init(font.font_pixel,std::to_string(cardsCollected),sf::Color(0,0,0),40,0,0);
    scoreFont.setPosition(60,iconCard.getCollider().getPosition().y+(iconCard.getCollider().getGlobalBounds().height/2)-20);
    

    //end

    sf::Clock clock;


    bool isClicked = false;


    while(window.getWindow()->isOpen()) {
        sf::Event event;

        sf::Time dt = clock.restart();

        sf::Vector2f mousePos = window.getWindow()->mapPixelToCoords(sf::Mouse::getPosition(*window.getWindow()));


        if(cardsCollected < 0 || player.getCollider().getPosition().y > window.getHeight() || cardsCollected > 9999) {
        
            menu();
        } 

        while(window.getWindow()->pollEvent(event)) {
            if(event.type == sf::Event::Closed) {
                /*for(int i = 0;i<objects.size();i++) {
                    delete objects[i];
                    objects[i] = nullptr;

                    if(objects[i] == nullptr) {
                        std::cout << "Deleted Objects" << std::endl;
                    }
                }*/
                window.getWindow()->close();
            }

            if(event.type == sf::Event::KeyPressed) {
                if(event.key.code == sf::Keyboard::Escape) {
                    /*for(int i = 0;i<objects.size();i++) {
                        delete objects[i];
                        objects[i] = nullptr;

                        if(objects[i] == nullptr) {
                            std::cout << "Deleted Objects" << std::endl;
                        }
                    }*/
                    window.getWindow()->close();
                }

            }

            if(event.type == sf::Event::MouseButtonPressed) {
                if(event.mouseButton.button == sf::Mouse::Left) {

                    if(player.getIsJump() == false && player.getJumpingAround() == 0) {
                        if(!isClicked && line[0].position == sf::Vector2f(-1,-1)) {
                            isClicked = true;
                            line[0].position = mousePos;
                        }
                    }
                 
                }
            }

            if(event.type == sf::Event::MouseButtonReleased) {
                if(event.mouseButton.button == sf::Mouse::Left) {

                    if(player.getIsJump() == false && player.getJumpingAround() == 0) {
                        if(isClicked) {

                            float angle = atan2(line[0].position.y-player.getCollider().getPosition().y,line[0].position.x-player.getCollider().getPosition().x);
                            float slopeX = line[0].position.x-line[1].position.x;
                            float slopeY = line[0].position.y-line[1].position.y;
                            float accel = sqrt((slopeX*slopeX)+(slopeY*slopeY));

                            float speedX = cos(angle)*accel;
                            float speedY = sin(angle)*accel;

                            std::cout << speedX << std::endl;
                            player.setIsJump(true);
                            player.setSpeed(speedX,speedY);
                            isClicked = false;
                            line[0].position = sf::Vector2f(-1,-1);
                            line[1].position = sf::Vector2f(-1,-1);
                            player.setJumpingAround(1);
                        }
                    }
                 
                }
            }

          

        }


     

        //update

        

        //line
        if(isClicked) {
            line[1].position = mousePos;
        }
        //end

        player.update(dt.asSeconds(),objects);
        card.update(dt.asSeconds(),objects[0].getCollider().getPosition().x+(objects[0].getCollider().getGlobalBounds().width/2)-24,objects[0].getCollider().getPosition().y-30);
        cardTwo.update(dt.asSeconds(),objects[1].getCollider().getPosition().x+(objects[1].getCollider().getGlobalBounds().width/2)-24,objects[1].getCollider().getPosition().y-30);

        card.setSpeed(objects[0].getVelX(),objects[0].getVelY());
        cardTwo.setSpeed(objects[1].getVelX(),objects[1].getVelY());

        card.collideWithObject(&player,cardsCollected,scoreFont,iconCard);
        cardTwo.collideWithObject(&player,cardsCollected,scoreFont,iconCard);

        objects[0].update(dt.asSeconds(),Random::getRange(20,250),-96);
        objects[1].update(dt.asSeconds(),Random::getRange(424,776),-96);
        shower.update(dt.asSeconds());
    
      
        window.getWindow()->clear(sf::Color(255,255,255));

        window.getWindow()->draw(line);
        //draw
        shower.draw();

        player.draw();
        card.draw();
        cardTwo.draw();
        iconCard.draw();
        scoreFont.draw(window.getWindow());
        
        
        for(int i = 0;i<objects.size();i++) {
            objects[i].draw();
        }

        window.getWindow()->display();

        window.getWindow()->setFramerateLimit(60);
    }
}

Game::~Game() {
    
    manager.destroyed();
    font.destroyed();
    window.destroy();
  
}