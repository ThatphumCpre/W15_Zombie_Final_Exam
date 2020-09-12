Shooter shooter; //set shooter as object of Shooter

void setup() {
  size(1000, 1000);  //set size
  shooter = new Shooter(); //instance new shooter
}

void draw() {
  background(255);  //draw white bg
  shooter.draw();   //draw shooter
}

public class Shooter {
  float positionX, positionY, size, direction, speed; //set attribute

  Shooter() {
    positionX = width/2; //default x position
    positionY = height/2; //default y position
    direction = 0;  // set direction as default
    size = 100; //default size
    speed=2; //default speed of shooter
  }


  public void draw() {
    if (keyPressed) {  //if key Pressed
      if (key == 'w' || key == 'W') {   //w make it forward
        this.move(1, 0);
      } else if (key == 's' || key == 'S') {  //s make it backward
        this.move(-1, 0);
      } else if (key == 'd' || key == 'D') {  //d make it turn right
        this.move(0, 1);
      } else if (key == 'a' || key == 'A') {  //a make it turn left
        this.move(0, -1);
      }

    }

    strokeWeight(5); //increase stoke size
    ellipse(positionX, positionY, size, size);  //draw shooter
    line(positionX+cos(direction)*size/2, positionY+sin(direction)*size/2, positionX+cos(direction)*size, positionY+sin(direction)*size);
  }

  public void move(int move, int turn) {
    float newRadius = turn*2*PI/360;  //turn degree to radius
    direction = direction+newRadius;  //move from input
    positionX+= cos(direction)*move*speed;
    positionY+= sin(direction)*move*speed;
  }

  public float getX(){  //getter method
    return positionX;
  }
  public float getY(){  //getter method
    return positionY;
  }
  public float getDirection(){  //getter method
    return direction;
  }
}

public class Bullet{
  float positionX,positionY,speed,move,direction; //set attribute

  Bullet(float x, float y, float direct){ //set start point and direction
    positionX = x;
    positionY = y;
    direction = direct;
    move=0;
    speed=5;
  }

  public void drawBullet(){
    //draw from attribute
    line(positionX+cos(direction)*(move+10), positionY+sin(direction)*(move+10), positionX+cos(direction)*(move+20), positionY+sin(direction)*(move+20));
    move+=speed;  //update move from speed
  }
}
