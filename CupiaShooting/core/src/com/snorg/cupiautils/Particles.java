package com.snorg.cupiautils;


import com.badlogic.gdx.graphics.Color;
import com.badlogic.gdx.graphics.glutils.ShapeRenderer;
import com.badlogic.gdx.math.Rectangle;

import java.util.ArrayList;

public class Particles {
    private ArrayList<Rectangle> parts;

    private int frameTime;

    public Particles() {
       frameTime = 0;
       parts = new ArrayList<>();
    }


    public void render(ShapeRenderer shapeRenderer,Color color)  {
        for(Rectangle particle : parts) {
            shapeRenderer.setColor(color);
            shapeRenderer.begin(ShapeRenderer.ShapeType.Filled);
            shapeRenderer.rect(particle.x,particle.y,particle.width,particle.height);
            shapeRenderer.end();
        }
    }


    public void update(float sx,float sy,int removeTime,float dt) {
        for(Rectangle part : parts) {
            part.x += sx * dt;
            part.y += sy * dt;
            frameTime++;
            if(frameTime >= removeTime) {
                frameTime = 0;
                part.width -= 1;
                part.height -= 1;
            }

        }

        for(int i = 0;i<parts.size();i++) {
            if(parts.get(i).width <= 1 || parts.get(i).height <= 1) {
                parts.remove(i);
            }
        }
    }

    public void addParts(int x,int y,int width,int height) {
        Rectangle rect = new Rectangle(x,y,width,height);
        parts.add(rect);

    }
}
