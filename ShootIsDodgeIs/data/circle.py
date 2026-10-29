import pygame,sys,random 
from data.image import *



class Circle:

    def __init__(self,sx,x,y,r,speedX,speedY):

        self.image = image_from_sheet("assets/circles.png",sx*32,0,32,32)
        self.r = r
        
        self.x = x 
        self.y = y
        self.image = pygame.transform.scale(self.image,(r,r))
        self.speedX = speedX
        self.speedY = speedY

        self.seconds = 0
      
    def update(self,reduceTime,dt):

        self.x += self.speedX * dt
        self.y += self.speedY * dt

        self.seconds+=1 

        if self.seconds >= reduceTime:
            self.seconds = 0

            if self.r > 1:
                self.r -= 1
                
            self.image = pygame.transform.scale(self.image,(self.r,self.r))
        


    def draw(self,screen):

        screen.blit(self.image,(self.x,self.y))
    

        
        