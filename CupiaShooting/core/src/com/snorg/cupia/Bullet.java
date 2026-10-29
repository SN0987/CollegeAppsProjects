package com.snorg.cupia;


import com.badlogic.gdx.graphics.Color;
import com.badlogic.gdx.graphics.g2d.SpriteBatch;
import com.badlogic.gdx.graphics.glutils.ShapeRenderer;
import com.badlogic.gdx.math.Rectangle;
import com.snorg.cupiautils.CircleParticles;
import com.snorg.cupiautils.Rand;

public class Bullet {

    private CircleParticles parts;

    private PurpleElixer bullet;

    private float vx;
    private float vy;
    private int changeTime;
    protected Bullet(float x,float y,float vx,float vy) {
        bullet = new PurpleElixer((int)x,(int)y);
        parts = new CircleParticles();
        int changeTime = 0;
        this.vx = vx;
        this.vy = vy;
    }

    public void update(float dt) {
        changeTime++;
        if(changeTime >= 5) {
            changeTime = 0;
            parts.addParts((int)bullet.getRect().x+30,(int)bullet.getRect().getY()+10, Rand.randomRange(5,10));
        }
        bullet.update(dt,vx,vy);
        parts.update(vx,vy,2,dt);
        delete();
    }

    public void render(SpriteBatch batch, ShapeRenderer shapeRenderer) {
        bullet.render(batch);
        parts.render(shapeRenderer,new Color(0.6f,0.1f,0.7f,0));

    }

    public PurpleElixer getElx() {

        return this.bullet;
    }
    public void delete() {
        if(bullet.getRect().x <= -20) {
            bullet.delete();
        } else if(bullet.getRect().x >= 800) {
            bullet.delete();
        }

        if(bullet.getRect().y <= -20) {
            bullet.delete();
        } else if(bullet.getRect().y >= 600) {
            bullet.delete();
        }
    }
}
