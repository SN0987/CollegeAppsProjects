import pygame
import random
import time
import sys
pygame.init()
#main variables
width = 512
height = 300
gravity = 100
vely = 0
speedy = 10
speedx = 15
xrange = random.randrange(0, width)


yrange = 60
u_speed = 6
s_speed = 3
score = 0
run = True
l_movement = False
r_movement = False
is_grounded = True
is_jump = False
collision_tolerance = 10
clock = pygame.time.Clock()
fps = 60
continueE = False



screen = pygame.display.set_mode((width,height))
pygame.display.set_caption(("OUtrun! By Sohaab"))
#images
bg = pygame.image.load("background.png")


platform = pygame.image.load("platform.png")

platform.set_colorkey((255,255,255))


platform_rect = platform.get_rect()
platform_rect.center = (255,150)

mainup = pygame.image.load("character.png")
mainup.set_colorkey((0,0,0))
rectyboy = mainup.get_rect()
rectyboy.center = (200,232)
upspikey = pygame.image.load("upspike.png")
upspikey.set_colorkey((255,255,255))
upspike = upspikey.get_rect()
upspike.center = (xrange, yrange)
upspikey2 = pygame.image.load("upspike.png")
upspike2 = upspikey2.get_rect()
upspike2.center = (xrange, yrange)
upspikey2.set_colorkey((255,255,255))
newFont = pygame.font.Font("square-deal.ttf", 30)
bigFont = pygame.font.Font("square-deal.ttf", 80 )
#functions
def rect_call():
  global vely
  
  
  if rectyboy.colliderect(platform_rect):
    rectyboy.y = 200
    is_grounded = True
  
  if rectyboy.x >= width:
    rectyboy.x = 512
  
  if rectyboy.x >= width-64:
    rectyboy.x = width-75
  if rectyboy.x <= 0:
    rectyboy.x = 0 + 8
  if rectyboy.colliderect(upspike):
    if abs(rectyboy.top - upspike.bottom ) < 10:
      gameover()
      

    #print("collision")
    
  if rectyboy.colliderect(upspike2):
    #print("collision")
    if abs(rectyboy.top - upspike2.bottom ) < 10:
      gameover()
      
      
    
  
 
  

   
def movement():
  global is_grounded
  global vely
  global is_jump
  global gravity
  if l_movement == True:
    rectyboy.x -= speedx
  if r_movement == True:
    rectyboy.x += speedx
 
    
    
def reset():
  upspike.y = yrange
  upspike.x = random.randrange(0,width)
def reset2():
  upspike2.y = yrange
  upspike2.x = random.randrange(0,width)
def upspike_movement():
  upspike.y += u_speed
  upspike2.y += u_speed
  if upspike.y >= height:
    reset()
  if upspike2.y >= height:
    reset2()
def scoreController():
  
  scoreCon = newFont.render("Score: " + str(int(score)), True, (255,255,255))
  screen.blit(scoreCon, [20,50])
def reseted():
  global score
  rectyboy.x = 200
  rectyboy.y = 200
  score = 0 




  
  
def gameover():
  gameovertext = bigFont.render("Gameover " + str(score),True,(255,255,255))
  screen.blit(gameovertext, [100, 125])
  reseted()
  


  
  
while run:
  screen.blit(bg, (0,0))
  
  for event in pygame.event.get():
    if event.type == pygame.QUIT:
      pygame.quit()
      sys.exit();
      run = False
    if event.type == pygame.KEYDOWN:
      if event.key == pygame.K_a:
        l_movement = True
      if event.key == pygame.K_d:
        r_movement = True
      
      
      
       
    if event.type == pygame.KEYUP:
      if event.key == pygame.K_a or pygame.K_d:
        l_movement = False
        r_movement = False
   
      


      
  scoreController()
  
  screen.blit(platform,platform_rect)
  screen.blit(mainup, rectyboy)
   
  screen.blit(upspikey, upspike)
  screen.blit(upspikey2,upspike2)
  rect_call()
  movement()
  
  upspike_movement()
  score += 0.1
  

  
  
  
  
  clock.tick(fps)
  pygame.display.update()

