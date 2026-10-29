package com.snorg.cupiautils;

import java.util.Random;

public class Rand {

    public static int randomRange(float min,float max) {
       return (int)((Math.random()*(max - min)) + min);
    }
}
