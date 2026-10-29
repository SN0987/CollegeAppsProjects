package com.snorg.cupiautils;

import com.badlogic.gdx.graphics.Color;
import com.badlogic.gdx.graphics.glutils.ShapeRenderer;
import com.badlogic.gdx.math.Circle;
import com.badlogic.gdx.math.Rectangle;

import java.util.ArrayList;

public class CircleParticles {
    private ArrayList<Circle> parts;

    private int frameTime;

    public CircleParticles() {
        frameTime = 0;
        parts = new ArrayList<>();
    }


    public void render(ShapeRenderer shapeRenderer, Color color)  {
        for(Circle particle : parts) {
            shapeRenderer.setColor(color);
            shapeRenderer.begin(ShapeRenderer.ShapeType.Filled);
            shapeRenderer.circle(particle.x, particle.y,particle.radius);
            shapeRenderer.end();
        }
    }


    public void update(float sx,float sy,int removeTime,float dt) {
        for(Circle part : parts) {
            part.x += sx * dt;
            part.y += sy * dt;
            frameTime++;
            if(frameTime >= removeTime) {
                frameTime = 0;
                part.radius -= 1;
            }

        }

        for(int i = 0;i<parts.size();i++) {
            if(parts.get(i).radius <= 1) {
                parts.remove(i);
            }
        }
    }

    public void addParts(int x,int y,int radius) {
        Circle circle = new Circle(x,y,radius);
        parts.add(circle);
    }
}
