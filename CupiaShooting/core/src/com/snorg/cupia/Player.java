package com.snorg.cupia;

import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.Input;
import com.badlogic.gdx.graphics.Color;
import com.badlogic.gdx.graphics.g2d.Sprite;
import com.badlogic.gdx.graphics.g2d.SpriteBatch;
import com.badlogic.gdx.graphics.glutils.ShapeRenderer;
import com.badlogic.gdx.math.Rectangle;
import com.snorg.cupiautils.*;

import java.util.ArrayList;

public class Player {

    private String state;

    private Rectangle rect;

    private ArrayList<Sprite> leftSprites;

    private ArrayList<Sprite> rightSprites;

    private Sprite idle;

    private Animate anims;

    private Particles leftParticles;

    private Particles rightParticles;

    private int sx;
    private CupiaTimer changeSpeed;
    protected Player(int x,int y) {
        rect = new Rectangle(x,y,64,64);
        idle = SpriteLoader.load("assets/cupia_right.png",0,0,32,32,84,84,rect.x,rect.y);
        state = "idle";
        rightSprites = new ArrayList<>();
        leftSprites = new ArrayList<>();
        anims = new Animate();
        sx = 500;
        for(int i = 0;i<6;i++) {
            Sprite sprite = SpriteLoader.load("assets/cupia_right.png",i*32,0,32,32,84,84,rect.x,rect.y);
            rightSprites.add(sprite);
        }

        for(int i = 0;i<6;i++) {
            Sprite sprite = SpriteLoader.load("assets/cupia_left.png",i*32,0,32,32,84,84,rect.x,rect.y);
            leftSprites.add(sprite);

        }

        leftParticles = new Particles();
        rightParticles = new Particles();

        changeSpeed = new CupiaTimer();

    }

    public void render(SpriteBatch batch, ShapeRenderer shapeRenderer) {
        leftParticles.render(shapeRenderer, Color.BLACK);
        rightParticles.render(shapeRenderer,new Color(0.4f,0.2f,0.6f,0));
        if(this.state.equals("idle")) {
            batch.begin();
            idle.draw(batch);
            batch.end();
        }

        if(this.state.equals("right")) {
            anims.animate(batch,rightSprites,6,5);
        }

        if(this.state.equals("left")) {
            anims.animate(batch,leftSprites,6,5);
        }
    }

    public void update(float dt) {
        movement(dt);
        bounds();
        playerTimers(12);
        leftParticles.update(200,0,1,dt);
        rightParticles.update(-200,0,1,dt);
        for(Sprite sp : leftSprites) {
            sp.setPosition(rect.x,rect.y);
        }

        for(Sprite spTwo : rightSprites) {
            spTwo.setPosition(rect.x,rect.y);
        }

        idle.setPosition(rect.x,rect.y);

    }

    private void movement(float dt) {
        if(Gdx.input.isKeyPressed(Input.Keys.A) || Gdx.input.isKeyPressed(Input.Keys.LEFT)) {
            rect.x -= sx * dt;
            leftParticles.addParts((int)rect.x + 70,(int)rect.y + 20,30,15);
            this.state = "left";
        } else if(Gdx.input.isKeyPressed(Input.Keys.D) || Gdx.input.isKeyPressed(Input.Keys.RIGHT)) {
            rect.x += sx * dt;
            rightParticles.addParts((int)rect.x,(int)rect.y + 20,30,15);
            this.state = "right";
        } else {
            this.state = "idle";
        }
    }

    private void playerTimers(int changeSpeedTime) {
         if(changeSpeed.isOnTimer(changeSpeedTime)) {
            sx = Rand.randomRange(500,900);
         }
    }

    private void bounds() {
        if(rect.x >= 800 - 84) {
            rect.x = 800 - 84;
            this.state = "idle";
        }  else if(rect.x <= 0) {
            rect.x = 0;
            this.state = "idle";
        }
    }
    public Rectangle getRect() {
        return this.rect;
    }
    public void delete() {
        for(Sprite sp : leftSprites) {
            sp.getTexture().dispose();
        }

        for(Sprite spTwo : rightSprites) {
            spTwo.getTexture().dispose();
        }

        idle.getTexture().dispose();
    }

    public void reset(int x,int y) {
        rect.setPosition(x,y);
    }
}
