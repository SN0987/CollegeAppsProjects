package com.snorg.cupia;

import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.graphics.Texture;
import com.badlogic.gdx.graphics.g2d.Sprite;
import com.badlogic.gdx.graphics.g2d.SpriteBatch;
import com.badlogic.gdx.graphics.g2d.TextureRegion;
import com.snorg.cupiautils.Animate;
import com.snorg.cupiautils.SpriteLoader;

import java.util.ArrayList;

public class Background {


    private Animate anims;

    private ArrayList<Sprite> sprites;


    protected Background(String path,int width,int height) {
        sprites = new ArrayList<>();
        anims = new Animate();
        for(int i = 0;i<5;i++) {
            Sprite sprite = SpriteLoader.load(path,i*32,0,32,32,width,height,0,0);
            sprites.add(sprite);

        }


    }

    public void render(SpriteBatch batch) {
        anims.animate(batch,sprites,6,4);

    }


    public void delete() {
        for(Sprite sprite : sprites) {
            sprite.getTexture().dispose();
        }
    }

    public void setSize(float width,float height) {
        for(Sprite sprite : sprites) {
            sprite.setSize(width,height);
        }
    }

}
