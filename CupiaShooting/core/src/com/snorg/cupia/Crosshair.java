package com.snorg.cupia;

import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.graphics.Pixmap;
import com.badlogic.gdx.graphics.g2d.Sprite;
import com.badlogic.gdx.graphics.g2d.SpriteBatch;
import com.snorg.cupiautils.SpriteLoader;

import java.util.ArrayList;

public class Crosshair {



    protected Crosshair() {
        Pixmap mp = new Pixmap(Gdx.files.internal("assets/crosshair.png"));
        Gdx.graphics.setCursor(Gdx.graphics.newCursor(mp,0,0));
        mp.dispose();
    }

}
