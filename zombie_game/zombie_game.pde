Shooter shooter; //set shooter as object of Shooter
Zombie[] zombie;  //set zombie as object of Zombie
int zombieCount;
  void setup() {
  size(1000, 1000);  //set size
  shooter = new Shooter(); //instance new shooter
  zombie = new Zombie[20];
  zombie[0] = new Zombie(0, 0); //instance new Zombie
  zombieCount = 1;
}

void draw() {
  background(255);  //draw white bg
  shooter.draw();   //draw shooter
  if (frameCount%120==0){
    zombie[zombieCount] = new Zombie(random(0,width),0);
    zombieCount += 1; 
  }
  for (int i=zombieCount-1; i>=0; i--) {  //for loop in zombie was create
    zombie[i].draw();    //draw zombie
    zombie[i].move(shooter.getX(), shooter.getY()); //move to shooter
  }
}

public class Shooter {
  float positionX, positionY, size, direction, speed; //set attribute
  int bulletCount;
  Bullet[] bullet;

  Shooter() {
    bullet = new Bullet[1000];  //create empty bullet array
    bulletCount=0;  //count for bullet that was create
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
      } else if (key == ' ' ) {
        bullet[bulletCount] = new Bullet(positionX+cos(direction)*size, positionY+sin(direction)*size, direction); //create new bullet
        bulletCount += 1; //count bullet
        delay(30);
      }
    }

    for (int i=bulletCount-1; i>=0; i--) {  //for loop in bullet was create
      bullet[i].drawBullet(); //draw each bullet

      if (frameCount%300==0) {       //reset bullet after time
        bullet = new Bullet[1000];
        bulletCount = 0;
        break;
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

  public float getX() {  //getter method
    return positionX;
  }
  public float getY() {  //getter method
    return positionY;
  }
  public float getDirection() {  //getter method
    return direction;
  }
}

public class Bullet {
  float positionX, positionY, speed, move, direction; //set attribute

  Bullet(float x, float y, float direct) { //set start point and direction
    positionX = x;
    positionY = y;
    direction = direct;
    move=0;
    speed=5;
  }

  public void drawBullet() {
    //draw from attribute
    line(positionX+cos(direction)*(move+10), positionY+sin(direction)*(move+10), positionX+cos(direction)*(move+20), positionY+sin(direction)*(move+20));
    move+=speed;  //update move from speed
  }
}

public class Zombie {
  float positionX, positionY, size, speed, zeta;
  Zombie() { //default constructor
    positionX = width/2;
    positionY = height/2;
    size = 100;
    zeta=0;
    speed = 0.005;
  }
  Zombie(float x, float y) {
    positionX = x;
    positionY = y;
    size=100;
    zeta=0;
    speed=0.001;
  }
  Zombie(float x, float y, float zombieSize, float speedInput) {  //set all attribue
    positionX = x;
    positionY = y;
    size = zombieSize;
    zeta=0;
    speed = speedInput;
  }
  public void draw() {

    fill(0, 255, 0);
    ellipse(positionX, positionY, size, size);
    line(positionX+cos(zeta-PI/3)*size/2, positionY+sin(zeta-PI/3)*size/2, positionX+cos(zeta-PI/6)*size, positionY+sin(zeta-PI/6)*size);
    line(positionX+cos(zeta+PI/3)*size/2, positionY+sin(zeta+PI/3)*size/2, positionX+cos(zeta+PI/6)*size, positionY+sin(zeta+PI/6)*size);
    //draw zombie and arm
  }
  public void move(float x, float y) {
    float targetX = x;
    float targetY = y;
    float distanceX = targetX-positionX; //find distance
    float distanceY = targetY-positionY;
    positionX += distanceX*speed;   //update position form distance and speed
    positionY += distanceY*speed;
    zeta = atan(distanceY/distanceX); //update new angle
    if (targetX<positionX && targetY>positionY){
      zeta += PI;
    }
    else if (targetX<positionX && targetY < positionY){
      zeta -= PI;
    }
  }
}
