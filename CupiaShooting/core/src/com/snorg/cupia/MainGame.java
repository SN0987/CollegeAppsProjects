package com.snorg.cupia;

import com.badlogic.gdx.ApplicationAdapter;
import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.graphics.Color;
import com.badlogic.gdx.graphics.GL20;
import com.badlogic.gdx.graphics.OrthographicCamera;
import com.badlogic.gdx.graphics.Texture;
import com.badlogic.gdx.graphics.g2d.SpriteBatch;
import com.badlogic.gdx.graphics.glutils.ShapeRenderer;
import com.badlogic.gdx.utils.ScreenUtils;
import com.badlogic.gdx.utils.viewport.ExtendViewport;
import com.snorg.cupiautils.CupiaTimer;
import com.snorg.cupiautils.Rand;
import com.snorg.cupiautils.SnowMod;
import com.snorg.cupiautils.StringFont;
import sun.security.jgss.GSSHeader;

/*
Fixed Player Speed Changing
Fixed Gameover Labels
Made a createText Functions In The Constants Class
Timer Class Added CupiaTimer In CupiaUtils
Need To Add A Highscore Label ASAP!!!!
Ver 1.1:End Mini Code Log
*/

public class MainGame extends ApplicationAdapter {
	private SpriteBatch batch;
	private OrthographicCamera camera;

	private ExtendViewport mainPort;

	private ShapeRenderer shapeRenderer;

	private Background bg;
	private Menu menu;
	private Game game;

	private SnowMod blueSnow;

	private Crosshair cs;


	private String snowState;
	private int changeState;
	private CupiaTimer changeStateTimer;

	private GameoverScreen lostScreen;
	@Override
	public void create () {
		batch = new SpriteBatch();
		camera = new OrthographicCamera();
		camera.setToOrtho(false, Gdx.graphics.getWidth(),Gdx.graphics.getHeight());
		mainPort = new ExtendViewport(camera.viewportWidth,camera.viewportHeight,camera);
		shapeRenderer = new ShapeRenderer();
		bg = new Background("assets/cupiaBg.png", mainPort.getScreenWidth(),mainPort.getScreenHeight());
		menu = new Menu();
		blueSnow = new SnowMod(50,800,600);
		game = new Game();
		cs = new Crosshair();
		snowState = "blue";
		lostScreen = new GameoverScreen();
		changeStateTimer = new CupiaTimer();
	}

	@Override
	public void render () {

		update(Gdx.graphics.getDeltaTime());


		Gdx.gl.glClearColor(0,0,0,0);
		Gdx.gl.glClear(GL20.GL_COLOR_BUFFER_BIT);

		batch.setProjectionMatrix(camera.combined);
		shapeRenderer.setProjectionMatrix(camera.combined);
		bg.render(batch);

		timers();
		
		if(snowState.equals("blue")) {
			blueSnow.render(shapeRenderer,new Color(0.2f,0.4f,1,0));
		} else if(snowState.equals("black")) {
			blueSnow.render(shapeRenderer,new Color(0.2f,0.2f,0.2f,0));
		}  else if(snowState.equals("purple")) {
			blueSnow.render(shapeRenderer,new Color(0.6f,0.1f,0.8f,0));
		}


		if(Constants.state == "menu") menu.render(batch,shapeRenderer);

		if(Constants.state == "game") game.render(batch,shapeRenderer);

		if(Constants.state == "gameover") lostScreen.render(batch,shapeRenderer);


	}


	private void update(float dt) {
		camera.update();
		blueSnow.update(dt,300);
		if(Constants.state == "menu") menu.update(dt);

		if(Constants.state == "game") game.update(dt,camera);

		if(Constants.state == "gameover") lostScreen.update(dt);

	}


	public void timers() {

		if(changeStateTimer.isOnTimer(13)) {
			changeState = Rand.randomRange(0,3);
			if(changeState == 0) {
				snowState = "blue";
			} else if(changeState == 1) {
				snowState = "black";
			} else {
				snowState = "purple";
			}
		}
	}

	@Override
	public void resize(int width, int height) {
		bg.setSize(width,height);
		mainPort.update(width,height);
		
	}

	@Override
	public void dispose () {
		batch.dispose();
		bg.delete();
		shapeRenderer.dispose();
		menu.end();
		game.end();
		lostScreen.end();
		
	}
}
