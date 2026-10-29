package com.snorg.cupia;

import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.audio.Sound;
import com.badlogic.gdx.graphics.Color;
import com.badlogic.gdx.graphics.g2d.SpriteBatch;
import com.badlogic.gdx.graphics.glutils.ShapeRenderer;
import com.snorg.cupiautils.CupiaTimer;
import com.snorg.cupiautils.StringFont;

public class GameoverScreen {
    private StringFont goText;

    private StringFont causeText;
    private StringFont menuText;
    private int timeOfState;

    private int secondPast;

    private CupiaTimer menuTimer;



    protected GameoverScreen() {
        goText = Constants.createText(130,Color.WHITE,"Gameover");
        causeText = Constants.createText(40,Color.WHITE,"One Of The Citric Elixir Fell Off The Screen");
        menuText = Constants.createText(40,Color.WHITE,"Menu In " + Integer.toString(timeOfState));
        menuTimer = new CupiaTimer();
        menuTimer.setDecreaseTime(5);
    }

    public void render(SpriteBatch batch, ShapeRenderer shapeRenderer) {
        goText.draw(batch,197,400);
        causeText.draw(batch,34,280);
        menuText.draw(batch,0,30);
    }

    public void update(float dt) {
        secondPast++;
        if(menuTimer.isDecreaseTimer(5)) {
            Constants.state = "menu";
            reset();
        }
        menuText.setString("Menu In " + Integer.toString(menuTimer.getDecreaseTime()));

    }

    public void end() {

    }

    private void reset() {
         menuTimer.reset();
         menuTimer.setDecreaseTime(5);
    }
}
