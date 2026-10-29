import pygame,random,math
from data.enemy import * 




class EnemyList:

    def __init__(self,sx):
        self.es = []

        self.seconds = 0
      
        self.sx = sx

         

    
        


    def add(self,time,x,y,spx,spy):

        self.seconds+=1 

        if self.seconds >= time:
            
            self.es.append(Enemy(self.sx,x,y,spx,spy))
            self.seconds = 0

    
    def update(self,dt,player,app):

        for e in self.es:
            e.update(dt)


        for e in self.es:
            if e.rect.colliderect(player.rect):
                app.menu()
            
            if e.rect.colliderect(player.colZone) and player.sh.isShoot:
                self.es.remove(e)
                

          

    def draw(self,screen):

        for e in self.es:
            e.draw(screen)

    def clear(self):
        self.es.clear()


                
