package com.snorg.cupiautils;

import com.badlogic.gdx.graphics.Color;
import com.badlogic.gdx.graphics.glutils.ShapeRenderer;
import com.badlogic.gdx.math.Circle;
import com.badlogic.gdx.math.Rectangle;
import com.snorg.cupia.Constants;

import java.util.ArrayList;

public class SnowMod {

    private int amount;

    private ArrayList<Rectangle> snow;

    private int wid;
    private int hei;


    public SnowMod(int amount,int width,int height) {
        this.wid = width;
        this.hei = height;
        snow = new ArrayList<>();
        this.amount = amount;

        for(int i = 0;i<amount;i++) {
            Rectangle rect = new Rectangle();
            int sizeW = Rand.randomRange(2,6);
            rect.setPosition(Rand.randomRange(0,this.wid),Rand.randomRange(0,this.hei));
            rect.setSize(sizeW,sizeW);
            snow.add(rect);
        }


    }

    public void update(float dt,int speed) {
        for(Rectangle rect : snow) {
            rect.y -= speed * dt;

            if(rect.y < 0) {
                int sizeW = Rand.randomRange(2,6);
                rect.setPosition(Rand.randomRange(0,this.wid),Rand.randomRange(100,this.hei));
                rect.setSize(sizeW);
            }

        }
    }

    public void render(ShapeRenderer shapeRenderer, Color color) {
        for(Rectangle rect : snow) {
            shapeRenderer.setColor(color);
            shapeRenderer.begin(ShapeRenderer.ShapeType.Filled);
            shapeRenderer.rect(rect.x,rect.y,rect.width,rect.height);
            shapeRenderer.end();
        }
    }

    public ArrayList<Rectangle> getSnow() {

        return this.snow;

    }


    public int getAmount() {

        return this.amount;

    }

    public void setAmount(int size) {
        this.amount = size;
    }
}
