import pygame,random
from pygame.locals import *
from data.image import *
from data.particles import *
from data.shoot_radius import *

class Player:

    def __init__(self,x,y):
        self.image = image_from_sheet("assets/circles.png",3*32,0,32,32)

        self.image = pygame.transform.scale(self.image,(70,70))
        self.rect = self.image.get_rect(center=(x,y))

        self.speedX = 250
        self.speedY = 250 

        self.leftParticles = Particles(3,-self.speedX,0,self.rect.x,self.rect.y+35,10,30)
        self.rightParticles = Particles(3,self.speedX,0,self.rect.x+70,self.rect.y+32,10,30)
        self.upParticles = Particles(3,0,-self.speedY,self.rect.x+35,self.rect.y,10,30)
        self.downParticles = Particles(3,0,self.speedY,self.rect.x+35,self.rect.y+75,10,30)

        self.sh = ShootRadius(self.rect.x+35,self.rect.y+35,20,120)

        self.isShoot = False 

        self.colZone = pygame.Rect(self.rect.x-50,self.rect.y-50,180,180)
    def update(self,dt):


        keys = pygame.key.get_pressed()

        self.keys(keys,dt)

        self.bounds()
   
        
        self.upParticles.update(dt,1)
        self.downParticles.update(dt,1)
        self.leftParticles.update(dt,1)
        self.rightParticles.update(dt,1)

        self.sh.x = self.rect.x + 35
        self.sh.y = self.rect.y + 35

        self.shoot(keys)
        self.sh.update(1,20,120)

        self.colZone.x = self.rect.x - 50
        self.colZone.y = self.rect.y - 50
    

    def bounds(self):
        if self.rect.x <= 0:
            self.rect.x = 0 
        elif self.rect.x >= 450 - self.rect.width:
            self.rect.x = 450 - self.rect.width

        if self.rect.y <= 0:
            self.rect.y = 0
        elif self.rect.y >= 600 - self.rect.height:
            self.rect.y = 600 - self.rect.height


    def keys(self,keys,dt):
        keys = pygame.key.get_pressed()

        if keys[pygame.K_a] or keys[pygame.K_LEFT]:
            self.rect.x -= self.speedX * dt
            self.rightParticles.x = self.rect.x + 70
            self.rightParticles.y = self.rect.y + 35

            self.rightParticles.add(2)
        
        if keys[pygame.K_d] or keys[pygame.K_RIGHT]:
            self.rect.x += self.speedX * dt
            self.leftParticles.x = self.rect.x
            self.leftParticles.y = self.rect.y + 35
            
            self.leftParticles.add(2)

        if keys[pygame.K_w] or keys[pygame.K_UP]:
            self.rect.y -= self.speedY * dt
            self.downParticles.x = self.rect.x + 35
            self.downParticles.y = self.rect.y + 70
            
            self.downParticles.add(2)

        if keys[pygame.K_s] or keys[pygame.K_DOWN]:
            self.rect.y += self.speedY * dt
            self.upParticles.x = self.rect.x + 35
            self.upParticles.y = self.rect.y
            
            self.upParticles.add(2)


    def shoot(self,keys):

    
        if keys[pygame.K_SPACE]:
            if self.sh.isShoot == False and self.sh.shootTime >= 3*(60):
                self.sh.isShoot = True
                self.sh.shootTime = 0


    def draw(self,screen):
        
        self.sh.draw(screen,(164, 167, 171))
        screen.blit(self.image,self.rect)
        
        self.leftParticles.draw(screen)
        self.rightParticles.draw(screen)
        self.downParticles.draw(screen)
        self.upParticles.draw(screen)

        
      