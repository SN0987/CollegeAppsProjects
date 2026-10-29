import pygame,random



class Snow:

    def __init__(self,size):
        self.s = []

        for i in range(size):
            w = random.randrange(2,5)
            self.s.append(pygame.Rect(random.randrange(0,450),random.randrange(0,600),w,w))

        self.sy = 90
    
    def update(self,dt):

        for rect in self.s:
            
            rect.y += self.sy * dt
            if rect.y > 600:
                w = random.randrange(2,5)

                rect.width = w
                rect.height = w 
                rect.center = (random.randrange(0,450),random.randrange(0,600))
        

                

    
    def draw(self,screen,color):

        for rect in self.s:
            pygame.draw.rect(screen,color,rect)