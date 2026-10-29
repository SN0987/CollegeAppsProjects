import pygame

pygame.init()



def image_from_sheet(path,sx,sy,sw,sh):
    image = pygame.image.load(path).convert()
   
    surface = pygame.Surface((sw,sh))

    surface.blit(image,[0,0],[sx,sy,sw,sh])

    surface.set_colorkey((0,0,0))
    return surface 



def text(t,size,color,pos,screen):
    font = pygame.font.Font("fonts/font.ttf",size)
    d = font.render(t,False,color)

    screen.blit(d,pos)

        