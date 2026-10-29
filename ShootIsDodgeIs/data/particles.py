import pygame,random
from data.circle import *




class Particles:

    def __init__(self,sx,speedX,speedY,x,y,bw,bh):
        self.sx = sx

        self.speedX = speedX
        self.speedY = speedY 
        self.particles = []

        self.seconds = 0

        self.x = x
        self.y = y
        self.bw = bw 
        self.bh = bh  

    def add(self,appendTime):
        self.seconds+=1

        if self.seconds >= appendTime:
            self.particles.append(Circle(self.sx,self.x,self.y,random.randrange(self.bw,self.bh),self.speedX,self.speedY))
            self.seconds = 0
            
    def update(self,dt,reduceTime):
        
        for part in self.particles:
            part.update(reduceTime,dt)

        for part in self.particles:
            if part.r <= 1:
                self.particles.remove(part)

        
    def draw(self,screen):

        for part in self.particles:
            part.draw(screen)
