package com.snorg.cupia;

import com.badlogic.gdx.graphics.Color;
import com.snorg.cupiautils.StringFont;

import java.util.Random;

public class Constants {
    public static String state = "menu";
    public static Random random = new Random();
    public static Integer score = 0;

    public static StringFont createText(int size, Color color,String text) {
        StringFont font = new StringFont("assets/font.ttf");
        font.setSize(size);
        font.setString(text);
        font.setColor(color);
        font.generate();
        return font;
    }
}
