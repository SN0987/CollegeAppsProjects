package com.snorg.cupiautils;

import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.graphics.Color;
import com.badlogic.gdx.graphics.g2d.BitmapFont;
import com.badlogic.gdx.graphics.g2d.SpriteBatch;
import com.badlogic.gdx.graphics.g2d.freetype.FreeTypeFontGenerator;

public class StringFont {
    private FreeTypeFontGenerator generator;
    private FreeTypeFontGenerator.FreeTypeFontParameter parameters;
    private BitmapFont font;

    private String mainString;
    public StringFont(String path) {
        generator = new FreeTypeFontGenerator(Gdx.files.internal(path));
        parameters = new FreeTypeFontGenerator.FreeTypeFontParameter();
        

    }


    public void setSize(int size) {
        parameters.size = size;

    }

    public void setColor(Color color) {
        parameters.color = color;
        parameters.borderColor = Color.BLACK;
        parameters.borderWidth = 1;

    }

    public void generate() {
        font = generator.generateFont(parameters);
        generator.dispose();
    }

    public void setString(String text) {
        this.mainString = text;
    }

    public void draw(SpriteBatch batch,int x,int y) {
        batch.begin();
        font.draw(batch,mainString,x,y);
        batch.end();
    }
}
