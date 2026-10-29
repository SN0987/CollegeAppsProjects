from turtle import clear
import pygame,sys,random
from pygame.locals import *
from data.image import *
from data.particles import *
from data.circle import *
from data.player import *
from data.enemy import *
from data.snow import *
from data.enemy_list import *
from data.shoot_radius import * 
pygame.init()






class App:
    def __init__(self,width,height,fps):
        self.width = width
        self.height = height
        self.fps = fps 

        self.screen = pygame.display.set_mode((self.width,self.height))
        pygame.display.set_caption("Shoot-Is Dodge-Is By Sn0987")

        self.caption_image = pygame.image.load("assets/giga.jpg").convert()

        self.caption_image = pygame.transform.scale(self.caption_image,(32,32))
        pygame.display.set_icon(self.caption_image)
        self.clock = pygame.time.Clock()

        self.menu()

    
    def menu(self):
        
        

        last_time = 0
        current_time = 0

        deltaTime = 0

        
        clickText = "Click To Play"
        

        snow = Snow(40)

        changeText = pygame.USEREVENT + 0
        changeTextTwo = pygame.USEREVENT + 1

        pygame.time.set_timer(changeText,300)
        pygame.time.set_timer(changeTextTwo,800)

        while True:
            
            current_time = pygame.time.get_ticks()
            deltaTime = (current_time-last_time)/1000
            last_time = current_time

            self.screen.fill((255,255,255))
            for event in pygame.event.get():
                if event.type == pygame.QUIT:
                    pygame.quit()
                    sys.exit()

                if event.type == pygame.KEYDOWN:
                    if event.key == pygame.K_ESCAPE:
                        pygame.quit()   
                        sys.exit()
                    if event.key == pygame.K_SPACE:
                        self.game()

                if event.type == pygame.MOUSEBUTTONDOWN:
                    self.game()
                
                    
                if event.type == changeText:
                    clickText = "Click To Play"
                    
                if event.type == changeTextTwo:
                    clickText = ""

            snow.update(deltaTime)
            snow.draw(self.screen,(21, 62, 209))
            text("Shoot-Is Dodge-Is",60,(50, 168, 82),(55,30),self.screen)

            text(clickText,45,(255,0,0),(133,450),self.screen)
            pygame.display.update()
            self.clock.tick(self.fps)
    def game(self):
        
        score = 0

        
        last_time = 0
        current_time = 0

        deltaTime = 0

        player = Player(450/2,300)
        
        leftList = EnemyList(0)
        leftListTwo = EnemyList(1)

        rightList = EnemyList(2)
        rightListTwo = EnemyList(4)

        downList = EnemyList(4)
        downListTwo = EnemyList(1)

        upList = EnemyList(0)
        upListTwo = EnemyList(1)

        snow = Snow(40)

        appendTime = random.randrange(240,260)

        appendTimeTwo = random.randrange(350,450)


        maxSpeed = 140
        maxSpeedTwo = 80

        clearRadius = ShootRadius(450/2,600/2,40,450)


        clearTime = 0

        changeEnemyDynamics = pygame.USEREVENT+0

        pygame.time.set_timer(changeEnemyDynamics,45000)

        while True:
            current_time = pygame.time.get_ticks()
            deltaTime = (current_time-last_time)/1000
            last_time = current_time

            self.screen.fill((255,255,255))
            for event in pygame.event.get():
                if event.type == pygame.QUIT:
                    pygame.quit()
                    sys.exit()

                if event.type == pygame.KEYDOWN:
                    if event.key == pygame.K_ESCAPE:
                        pygame.quit()   
                        sys.exit()  

                if event.type == changeEnemyDynamics:
                    appendTime = random.randrange(130,210)
                    appendTimeTwo = random.randrange(190,230)
                    maxSpeed+=20
                    maxSpeedTwo+=20
                    player.speedX+=20
                    player.speedY+=20

                    
            
            clearTime+=1

            if clearTime >= 30*(60) and clearRadius.isShoot == False:
                clearTime = 0
                clearRadius.isShoot = True 
                score += 1


            player.update(deltaTime)
            snow.update(deltaTime)

            #add enemy lists
            leftList.add(appendTime,random.randrange(0,30),random.randrange(0,600),random.randrange(60,maxSpeed),random.randrange(60,maxSpeed))
            leftListTwo.add(appendTime,random.randrange(0,30),random.randrange(0,600),random.randrange(60,maxSpeed),random.randrange(60,maxSpeed))

            rightList.add(appendTime,random.randrange(410,450),random.randrange(0,600),random.randrange(60,maxSpeed)*-1,random.randrange(60,maxSpeed))
            rightListTwo.add(appendTime,random.randrange(410,450),random.randrange(0,600),random.randrange(60,maxSpeed)*-1,random.randrange(60,maxSpeed))

            downList.add(appendTimeTwo,random.randrange(0,450),random.randrange(570,600),random.randrange(30,maxSpeedTwo),random.randrange(30,maxSpeedTwo)*-1)
            downListTwo.add(appendTimeTwo,random.randrange(0,450),random.randrange(570,600),random.randrange(30,maxSpeedTwo),random.randrange(30,maxSpeedTwo)*-1)
            #update enemy lists

            leftList.update(deltaTime,player,self)
            leftListTwo.update(deltaTime,player,self)

            rightList.update(deltaTime,player,self)
            rightListTwo.update(deltaTime,player,self)

            downList.update(deltaTime,player,self)
            downListTwo.update(deltaTime,player,self)

            clearRadius.update(1,40,450)

            #draw
            snow.draw(self.screen,(51, 222, 97))
            clearRadius.draw(self.screen,(131, 40, 191))
            player.draw(self.screen)
            leftList.draw(self.screen)
            leftListTwo.draw(self.screen)

            rightList.draw(self.screen)
            rightListTwo.draw(self.screen)

            downList.draw(self.screen)
            downListTwo.draw(self.screen)

            if clearRadius.isShoot:
                text("Clearing!",80,(255,30,30),(102,490),self.screen)

            if clearRadius.sizeIsMax():
                leftList.clear()
                leftListTwo.clear()
                rightList.clear()
                rightListTwo.clear()
                downList.clear()
                downListTwo.clear()

            
            if score >= 50:
                self.won()

            text(str(score),40,(37, 109, 204),[30,30],self.screen)     
            pygame.display.update()
            self.clock.tick(self.fps)
    
    def won(self):


        snow = Snow(40)

        lastTime = 0
        currentTime = 0
        deltaTime = 0

        changeScreens = 0

        while True:
            
            currentTime = pygame.time.get_ticks()
            deltaTime = (currentTime-lastTime)/1000
            lastTime = currentTime

            self.screen.fill((255,255,255))
            for event in pygame.event.get():
                if event.type == pygame.QUIT:

                    pygame.quit()
                    sys.exit()

                if event.type == pygame.KEYDOWN:
                    if event.key == pygame.K_ESCAPE:
                        pygame.quit()
                        sys.exit()


            snow.update(deltaTime)

            snow.draw(self.screen,(255, 47, 15))
            text("You Won!",80,(0,0,0),(110,250),self.screen)
            

            changeScreens+=1

            if changeScreens >= 5*(60):
                self.menu()

            pygame.display.update()

            self.clock.tick(self.fps)