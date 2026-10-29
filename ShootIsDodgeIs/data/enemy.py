
import pygame,math
from data.image import *
from data.particles import *


class Enemy:

    def __init__(self,sx,x,y,speedX,speedY):
        self.r = 40
        self.image = image_from_sheet("assets/circles.png",sx*32,0,32,32)
        self.image = pygame.transform.scale(self.image,(self.r,self.r))
        self.rect = self.image.get_rect(center=(x,y))
        self.speedX = speedX 
        self.speedY = speedY
        self.parts = Particles(sx,-self.speedX,-self.speedY,self.rect.x,self.rect.y,5,25) 

        
    
    def update(self,dt):

        self.rect.x += self.speedX * dt
        self.rect.y += self.speedY * dt

        self.parts.x = self.rect.x + 20
        self.parts.y = self.rect.y + 20


        self.parts.add(1)
        self.parts.update(dt,1)

    def draw(self,screen):
        
        screen.blit(self.image,self.rect)
        
        self.parts.draw(screen)


   

        
    

        
