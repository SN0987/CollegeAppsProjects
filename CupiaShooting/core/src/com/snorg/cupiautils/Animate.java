package com.snorg.cupiautils;

import com.badlogic.gdx.graphics.g2d.Sprite;
import com.badlogic.gdx.graphics.g2d.SpriteBatch;

import java.util.ArrayList;

public class Animate {
    
    private int frames;

    private CupiaTimer fpsTimer;

    public Animate() {
        frames = 0;
        fpsTimer = new CupiaTimer();
        fpsTimer.setSecondsPassed(1);
    }
    public void animate(SpriteBatch batch, ArrayList<Sprite> sprites, int fps,int amountOfFrames) {
        if(fpsTimer.isOnTimer(fps)) {
            if(frames >= 4) {
                frames = 0;
            } else {
                frames++;
            }
        }
        batch.begin();
        sprites.get(frames).draw(batch);
        batch.end();

    }
}
