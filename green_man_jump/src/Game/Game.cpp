#include "Game.hpp"



GreenMan::GameScreen::GameScreen(int width,int height,std::string title) 
    :window(nullptr)
{
    window = new sf::RenderWindow(sf::VideoMode(width,height),title,sf::Style::Close);


    menu();
}



void GreenMan::GameScreen::menu() {

    Snow snow(65,sf::Color(26, 82, 201));

    sf::Clock clock;


    StringFont titleFont("fonts/font_pixel.ttf","Green Man",sf::Color(33, 158, 110),130,800/2,20);
    titleFont.setPosition(800/2-(titleFont.getText().getGlobalBounds().width/2),20);

    StringFont clickFont("fonts/font_pixel.ttf","Press Space To Play",sf::Color(247, 71, 52),50,0,0);
    clickFont.setPosition(800/2-(clickFont.getText().getGlobalBounds().width/2),480);


    sf::Clock passTime;

    sf::Clock passTimeTwo;


    sf::View gameView;
    gameView.reset(sf::FloatRect(0,0,800,600));
    gameView.setViewport(sf::FloatRect(0.f,0.f,1.0f,1.0f));


    while(window->isOpen()) {
        sf::Event event;

        sf::Time dt = clock.restart();

        while(window->pollEvent(event)) {
            if(event.type == sf::Event::Closed) {
                window->close();
            } 

            if(event.type == sf::Event::KeyPressed) {
                if(event.key.code == sf::Keyboard::Escape) {
                    window->close();
                }

                if(event.key.code == sf::Keyboard::Space) {
                    game();
                }

                
            }

            if(event.type == sf::Event::MouseButtonPressed) {
                if(event.mouseButton.button = sf::Mouse::Button::Left) {
                    game();
                }
            }
        }

        if(passTime.getElapsedTime().asMilliseconds() >= 550) {
            clickFont.setString("");
            passTime.restart();
        }

        if(passTimeTwo.getElapsedTime().asMilliseconds() >= 850) {
            clickFont.setString("Press Space To Play");
            passTimeTwo.restart();
        }

        

        snow.update(dt);


        window->setView(gameView);

        window->clear(sf::Color(255,255,255));

        snow.draw(window);
        titleFont.draw(window);
        clickFont.draw(window);


        window->display();
        window->setFramerateLimit(60);
        

    }
}

void GreenMan::GameScreen::game() {


    Camera cam;

    GreenMan::Player player(50,350,&cam);

    GreenMan::Platform platform(800+(584),600-224,12,7,sf::Color(Random::getRandom(0,210),Random::getRandom(0,210),Random::getRandom(0,210)),220,0);

    sf::Clock clock;

    unsigned long int score = 0;

    StringFont scoreFont("fonts/font_basic.ttf","Score " + std::to_string(score),sf::Color(40, 143, 222),35,30,20);

    Snow snow(65,sf::Color(29, 204, 146));

    sf::Clock scoreTime;




    while(window->isOpen()) {
        sf::Event event;

        sf::Time dt = clock.restart();

        while(window->pollEvent(event)) {
            if(event.type == sf::Event::Closed) {
                window->close();
            } 

            if(event.type == sf::Event::KeyPressed) {
                if(event.key.code == sf::Keyboard::Escape) {
                    window->close();
                }

                if(event.key.code == sf::Keyboard::BackSpace) {
                    menu();
                }
            }
        }

        if(scoreTime.getElapsedTime().asSeconds() > 1) {
            score++;
            scoreFont.setString("Score " + std::to_string(score));
            scoreTime.restart();
        }

        if(score >= 5000) {
            menu();

        }
        
        cam.update(window);
        
        
        player.update(dt);
        platform.update(dt);
        snow.update(dt);

        //collision

        if(player.getSprite().getGlobalBounds().intersects(platform.getSprite().getGlobalBounds())) {
            menu();
        }
        //end

        window->clear(sf::Color(255,255,255));
        snow.draw(window);

        scoreFont.draw(window);

        player.draw(window);
        platform.draw(window);

        
        window->display();
        window->setFramerateLimit(60);

    }
}

GreenMan::GameScreen::~GameScreen() {
    delete window;

    window = nullptr;


    if(window == nullptr) {
        std::cout << "Freed Window Memory" << std::endl;
    }
}