package com.snorg.cupia;

import com.badlogic.gdx.graphics.g2d.Sprite;
import com.badlogic.gdx.graphics.g2d.SpriteBatch;
import com.badlogic.gdx.math.Rectangle;
import com.snorg.cupiautils.SpriteLoader;
import com.snorg.cupiautils.StringFont;

import java.util.ArrayList;
import java.util.Iterator;

public class PurpleElixer {
    private Rectangle rect;

    private Sprite sprite;


    protected PurpleElixer(int x,int y) {
        rect = new Rectangle(x,y,45,45);
        sprite = SpriteLoader.load("assets/elixers.png",0,0,32,32,60,60,rect.x,rect.y);

    }


    public void render(SpriteBatch batch) {
        batch.begin();
        sprite.draw(batch);
        batch.end();
    }

    public void update(float dt,int sy) {
        rect.y -= sy * dt;

        sprite.setPosition(rect.x,rect.y);
    }

    public void update(float dt,float sx,float sy) {

        rect.y += sy * dt;
        rect.x += sx * dt;
        sprite.setPosition(rect.x,rect.y);
    }
    public void delete() {
        sprite.getTexture().dispose();
    }

    public Rectangle getRect() {
        return this.rect;

    }

    public boolean listCol(ArrayList<CitricElixer> cls) {
        boolean isCol = false;
        for(int i = 0;i<cls.size();i++) {
            if(this.rect.overlaps(cls.get(i).getRect())) {
                cls.get(i).delete();
                cls.remove(i);
                isCol = true;

            }
        }

        return isCol;
    }

}
