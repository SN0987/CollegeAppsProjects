package com.snorg.cupiautils;

public class CupiaTimer {

    private int secondsPassed;

    private int changeSeconds;

    private int decreaseTime;

    private int coolSeconds;

    public CupiaTimer() {
        secondsPassed = 0;
        changeSeconds = 0;
        coolSeconds = 60;
    }

    public void setDecreaseTime(int seconds) {
        this.decreaseTime = seconds;
    }
    public boolean isOnTimer(int seconds) {
        boolean timerPassed = false;
        secondsPassed++;
        if(secondsPassed >= coolSeconds) {
            secondsPassed = 0;
            changeSeconds++;
            if(changeSeconds >= seconds) {
                timerPassed = true;
                changeSeconds = 0;
            }
        } else {
            timerPassed = false;
        }

        return timerPassed;
    }

    public boolean isDecreaseTimer(int goBackTime) {
        boolean timerPassed = false;
        secondsPassed++;
        if(secondsPassed >= 60) {
            secondsPassed = 0;
            decreaseTime--;
            if(decreaseTime <= 0) {
                timerPassed = true;
                this.decreaseTime = goBackTime;
            }

        } else {
            timerPassed = false;
        }

        return timerPassed;
    }

    public int getChangeSeconds() {
        return changeSeconds;
    }

    public int getSecondsPassed() {
        return secondsPassed;
    }

    public void setChangeSeconds() {
        changeSeconds = 0;
    }

    public void reset() {
        changeSeconds = 0;
        secondsPassed = 0;
        coolSeconds = 60;
    }

    public void setSecondsPassed(int seconds) {
        this.coolSeconds = seconds;
    }


    public int getDecreaseTime() {
        return decreaseTime;
    }
}
