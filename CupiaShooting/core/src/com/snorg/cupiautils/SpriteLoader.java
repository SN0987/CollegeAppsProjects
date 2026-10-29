package com.snorg.cupiautils;

import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.graphics.Texture;
import com.badlogic.gdx.graphics.g2d.Sprite;
import com.badlogic.gdx.graphics.g2d.TextureRegion;

public class SpriteLoader {

    public static Sprite load(String path, int srcX,int srcY,int srcW,int srcH,float width,float height,float x,float y) {
       Sprite sprite;
       Texture texture = new Texture(Gdx.files.internal(path));
       TextureRegion region = new TextureRegion(texture,srcX,srcY,srcW,srcH);

       sprite = new Sprite(region);
       sprite.setSize(width,height);
       sprite.setPosition(x,y);
       return sprite;
    }

    public static Sprite load(String path,float x,float y,float width,float height) {
        Sprite sprite;
        Texture texture = new Texture(Gdx.files.internal(path));
        sprite = new Sprite(texture);

        sprite.setBounds(x,y,width,height);

        return sprite;
    }
}
