package com.snorg.cupia;

import com.badlogic.gdx.graphics.g2d.Sprite;
import com.badlogic.gdx.graphics.g2d.SpriteBatch;
import com.badlogic.gdx.math.Rectangle;
import com.snorg.cupiautils.SpriteLoader;

public class CitricElixer {

    private Rectangle rect;
    private Sprite sprite;

    protected CitricElixer(int x,int y) {
        rect = new Rectangle(x,y,45,45);
        sprite = SpriteLoader.load("assets/elixers.png",32,0,32,32,60,60,rect.x,rect.y);
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
}
