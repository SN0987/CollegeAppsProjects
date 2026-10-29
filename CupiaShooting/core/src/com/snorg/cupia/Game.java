package com.snorg.cupia;

import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.Input;
import com.badlogic.gdx.audio.Sound;
import com.badlogic.gdx.graphics.Color;
import com.badlogic.gdx.graphics.OrthographicCamera;
import com.badlogic.gdx.graphics.g2d.SpriteBatch;
import com.badlogic.gdx.graphics.glutils.ShapeRenderer;
import com.badlogic.gdx.math.Vector2;
import com.badlogic.gdx.math.Vector3;
import com.snorg.cupiautils.CupiaTimer;
import com.snorg.cupiautils.Rand;
import com.snorg.cupiautils.StringFont;

import java.util.ArrayList;

public class Game {

    private Player player;

    private PurpleElixer pIcon;

    private StringFont amElx;
    private Integer collectedElx;
    private ArrayList<PurpleElixer> elxs;

    private int appendTimer;

    private StringFont amCit;


    private ArrayList<Bullet> bullets;

    private ArrayList<CitricElixer> cls;

    private CitricElixer cIcon;

    private int destroyedElx;
    private int appendTimerTwo;
    private boolean rushMode;

    private StringFont rushStatus;

    private CupiaTimer setRushModeTimer;

    private CupiaTimer setEndMode;
    private CupiaTimer timerOne;
    private CupiaTimer timerTwo;
    private CupiaTimer changeTimer;
    private CupiaTimer changeTimerTwo;


    protected Game() {
        player = new Player(800/2,0);
        pIcon = new PurpleElixer(0,523);
        elxs = new ArrayList<>();
        cls = new ArrayList<>();
        cIcon = new CitricElixer(0,470);
        bullets = new ArrayList<>();
        collectedElx = 0;
        destroyedElx = 0;
        appendTimer = 1;
        appendTimerTwo = 2;
        changeTimerTwo = new CupiaTimer();
        changeTimer = new CupiaTimer();
        amElx = Constants.createText(50,Color.WHITE,collectedElx.toString());
        amCit = Constants.createText(50,Color.WHITE,Integer.toString(destroyedElx));
        rushMode = false;
        setRushModeTimer = new CupiaTimer();
        setRushModeTimer.setDecreaseTime(20);
        rushStatus = Constants.createText(40,Color.WHITE,"Rush Mode In " + Integer.toString(setRushModeTimer.getDecreaseTime()));
        setEndMode = new CupiaTimer();
        setEndMode.setDecreaseTime(13);
        timerOne = new CupiaTimer();
        timerTwo = new CupiaTimer();


    }

    public void render(SpriteBatch batch, ShapeRenderer shapeRenderer) {
        player.render(batch,shapeRenderer);
        pIcon.render(batch);
        cIcon.render(batch);
        amElx.draw(batch,70,570);
        amCit.draw(batch,70,517);
        rushStatus.draw(batch,0,30);
        renderLists(batch,shapeRenderer);
    }


    public void update(float dt, OrthographicCamera camera) {
        player.update(dt);
        gameTimers();
        changeStates();
        updateLists(dt);

        if(Gdx.input.isButtonJustPressed(Input.Buttons.LEFT)) shoot(dt);


        if(Gdx.input.isKeyJustPressed(Input.Keys.SPACE) || Gdx.input.isKeyJustPressed(Input.Keys.W) || Gdx.input.isKeyJustPressed(Input.Keys.UP)) shoot(dt);
    }

    public void shoot(float dt) {
        if(collectedElx > 0) {
            Vector2 mPos = new Vector2(Gdx.input.getX(),600 - Gdx.input.getY());
            float angle = (float)Math.atan2(mPos.y - player.getRect().y,mPos.x - player.getRect().x);
            float vx = (float)Math.cos(angle)*700;
            float vy = (float)Math.sin(angle)*700;
            Bullet bullet = new Bullet(player.getRect().x,player.getRect().y,vx,vy);
            bullets.add(bullet);
            collectedElx -= 1;
            amElx.setString(collectedElx.toString());
        }
    }
    public void updateLists(float dt) {
        for(PurpleElixer e : elxs) {
            e.update(dt,Rand.randomRange(300,500));

        }


        for(CitricElixer ce : cls) {
            ce.update(dt,Rand.randomRange(100,150));
        }

        for(int i = 0;i<elxs.size();i++) {
            if(player.getRect().overlaps(elxs.get(i).getRect())) {
                elxs.get(i).getRect().setPosition(elxs.get(i).getRect().x,-50);
                collectedElx++;
                amElx.setString(collectedElx.toString());
            }
            if(elxs.get(i).getRect().y < -30) {
                elxs.get(i).delete();
                elxs.remove(i);                                                   
            }
        }

        for(int i = 0;i<cls.size();i++) {
            if(cls.get(i).getRect().y < -30) {
                cls.get(i).delete();
                cls.remove(i);
                reset();
                Constants.state = "gameover";
            }
        }

        


        for(Bullet bullet : bullets) {
            bullet.update(dt);
            if(bullet.getElx().listCol(cls)) {
                destroyedElx++;
                amCit.setString(Integer.toString(destroyedElx));
            }
        }
    }

    public void renderLists(SpriteBatch batch,ShapeRenderer shapeRenderer) {
        for(PurpleElixer e : elxs) {
            e.render(batch);
        }

        for(Bullet bullet : bullets) {
            bullet.render(batch,shapeRenderer);
        }

        for(CitricElixer ce : cls) {
            ce.render(batch);
        }
    }
    public void gameTimers() {


        if(rushMode == false) {

            if(setRushModeTimer.isDecreaseTimer(20)) {
                rushMode = true;
                appendTimer = 1;
                appendTimerTwo = 1;
                rushStatus.setString("Rush Mode Ends In " + Integer.toString(setEndMode.getDecreaseTime()));
                changeTimerTwo.reset();
                changeTimer.reset();
                timerTwo.setSecondsPassed(45);
                timerOne.setSecondsPassed(30);
            }
            rushStatus.setString("Rush Mode In " + Integer.toString(setRushModeTimer.getDecreaseTime()));




            if(changeTimer.isOnTimer(6))  appendTimer = Rand.randomRange(2,4);


            if(changeTimerTwo.isOnTimer(8))  appendTimerTwo = Rand.randomRange(2,5);



        } else if(rushMode) {

            rushStatus.setString("Rush Mode Ends In " + Integer.toString(setEndMode.getDecreaseTime()));

            if(setEndMode.isDecreaseTimer(13)) {
                rushMode = false;
                rushStatus.setString("Rush Mode In " + Integer.toString(setRushModeTimer.getDecreaseTime()));
                timerOne.reset();
                timerTwo.reset();
            }
        }

        if(timerOne.isOnTimer(appendTimer)) {
            PurpleElixer es = new PurpleElixer(Rand.randomRange(0,760),550);
            elxs.add(es);
        }


        if(timerTwo.isOnTimer(appendTimerTwo)) {
            CitricElixer ce = new CitricElixer(Rand.randomRange(0,760),550);
            cls.add(ce);
        }


    }
    public void changeStates() {
        if(Gdx.input.isKeyPressed(Input.Keys.BACKSPACE)) {
            Constants.state = "menu";
            reset();
        }

        if(Gdx.input.isButtonPressed(Input.Buttons.RIGHT)) {
            Constants.state = "menu";
            reset();
        }
    }

    public void end() {
        player.delete();
        pIcon.delete();
        cIcon.delete();
        for(PurpleElixer e : elxs) {
            e.delete();
        }

        for(CitricElixer ce : cls) {
            ce.delete();
        }

        for(Bullet bs : bullets) {
            bs.delete();
        }
    }


    public void reset() {
         rushMode = false;
         player.reset(800/2,0);
         elxs.clear();
         bullets.clear();
         cls.clear();
         collectedElx = 0;
         amElx.setString(collectedElx.toString());
         destroyedElx = 0;
         amCit.setString(Integer.toString(destroyedElx));
         setRushModeTimer.setDecreaseTime(20);
         setRushModeTimer.reset();
         setEndMode.reset();
         setEndMode.setSecondsPassed(60);
         timerOne.reset();
         timerTwo.reset();
         changeTimer.reset();
         changeTimerTwo.reset();
         rushStatus.setString("Rush Mode In " + Integer.toString(setRushModeTimer.getDecreaseTime()));
         appendTimer = Rand.randomRange(2,4);
         appendTimerTwo = Rand.randomRange(2,5);

    }
}
