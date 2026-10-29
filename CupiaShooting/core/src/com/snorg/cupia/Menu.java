package com.snorg.cupia;

import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.Input;
import com.badlogic.gdx.graphics.Color;
import com.badlogic.gdx.graphics.g2d.SpriteBatch;
import com.badlogic.gdx.graphics.glutils.ShapeRenderer;
import com.snorg.cupiautils.CupiaTimer;
import com.snorg.cupiautils.StringFont;
import com.sun.org.apache.bcel.internal.Const;

public class Menu {

    private StringFont title;
    private StringFont clText;
    private CupiaTimer clTimer;
    private CupiaTimer clTimerTwo;


    protected Menu() {
        title = Constants.createText(140,Color.PURPLE,"Cupia Shoot");
        //
        clText = Constants.createText(70,Color.WHITE,"Click To Play");

        clTimer = new CupiaTimer();
        clTimerTwo = new CupiaTimer();

    }

    public void render(SpriteBatch batch, ShapeRenderer shapeRenderer) {
       title.draw(batch,90, Gdx.graphics.getHeight() - 30);
       clText.draw(batch,215,150);

    }


    public void update(float dt) {

        if(clTimer.isOnTimer(5)) clText.setString("");


        if(clTimerTwo.isOnTimer(2)) clText.setString("Click To Play");


        if(Gdx.input.isButtonPressed(Input.Buttons.LEFT)) reset();

        if(Gdx.input.isKeyPressed(Input.Keys.ANY_KEY)) reset();



    }


    public void end() {

    }

    public void reset() {
        clTimer.reset();
        clTimerTwo.reset();
        Constants.state = "game";
    }
}
