from cgitb import reset
import pygame,random 



class ShootRadius:

    def __init__(self,x,y,r,maxr):
        self.r = r 
        self.x = x 
        self.y = y
        self.maxr = maxr
        self.isShoot = False
        self.seconds = 0
     

        self.rect = pygame.Rect(self.x,self.y,self.r,self.r)
        self.shootTime = 4*(60)



    
    def update(self,time,r,maxr):

        self.shootTime+=1

                
        self.rect.x = self.x 
        self.rect.y = self.y 
        

        if self.isShoot:
            self.seconds+=1

            if self.seconds >= time:
                self.seconds = 0
                if self.r < self.maxr:
                    self.r += 1
                    self.rect.width = self.r 
                    self.rect.height = self.r

            
            if self.r >= self.maxr:
                self.reset(r,maxr)
        
        
         

        


        
    def reset(self,r,maxr):
        self.r = r 
        self.maxr = maxr 

        self.rect.width = self.r 
        self.rect.height = self.r 
        self.isShoot = False

    def sizeIsMax(self):

        col = False 

        if self.r >= self.maxr - 20:
            col = True 
        else:
            col = False 

        return col 
    
    def draw(self,screen,color):
        
        if self.isShoot:
            pygame.draw.circle(screen,color,(self.x,self.y),self.r,width=3)

        
        
        
        