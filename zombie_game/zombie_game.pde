Shooter shooter; //set shooter as object of Shooter
Zombie[] zombie, zombieReserve;  //set zombie as object of Zombie
Bullet[] bullet, bulletReserve; //set bullet as object of bullet
boolean k_Up, k_Down, k_Left, k_Right, k_SP;
boolean freeze = false;
int zombieCount, canshoot;
  void setup() {
  size(1000, 1000);  //set size
  shooter = new Shooter(); //instance new shooter
  zombie = new Zombie[20];
  zombie[0] = new Zombie(0, 0); //instance new Zombie
  zombieCount = 1;
  zombieReserve = new Zombie[20];
  bulletReserve = new Bullet[1000];
  bullet = new Bullet[1000];  //create empty bullet array
}

void draw() {
  if(!freeze){
  background(255);  //draw white bg
  shooter.draw();   //draw shooter
  if (frameCount%120==0 && zombieCount<20){
    zombie[zombieCount] = new Zombie(random(0,width),0);
    zombieCount += 1;
  }
  for (int i=zombieCount-1; i>=0; i--) {  //for loop in zombie was create
    zombie[i].draw();    //draw zombie
    zombie[i].move(shooter.getX(), shooter.getY()); //move to shooter
    if(zombie[i].player_die(shooter.getX(), shooter.getY())){
      print("die");
      freeze = true;}
    zombie[i].die(i);
  }
  }
  for(int i=zombieCount-1; i>=0 ; i--){  //check all zombie
    for (int j=zombieCount-1; j>=0; j--){       //compair to all zombie
      if (j!=i){       //if not same zombie
        zombie[i].overlap(zombie[j]);     //check overlap
      }
    }
  }

}

public void keyPressed() {
  int k_ey = int(key);
  if(k_ey > 96){k_ey = k_ey-32;}
  setMove(k_ey, true);
  }

  public void keyReleased() {
    int k_ey = int(key);
    if(k_ey > 96){k_ey = k_ey-32;}
    setMove(k_ey, false);
  }

public boolean setMove(int k, boolean b) {
    switch (k) {
    case 87:
      return k_Up = b;

    case 83:
      return k_Down = b;

    case 65:
      return k_Left = b;

    case 68:
      return k_Right = b;

    case 32:
      return k_SP = b;

    default:
      return b;
    }
  }

public class Shooter {
  float positionX, positionY, size, direction, speed; //set attribute
  int bulletCount;

  Shooter() {
    bulletCount=0;  //count for bullet that was create
    positionX = width/2; //default x position
    positionY = height/2; //default y position
    direction = 0;  // set direction as default
    size = 100; //default size
    speed=2; //default speed of shooter
  }


  public void draw() {
      if (k_Up) {   //w make it forward
        this.move(1, 0);}
      if (k_Down) {  //s make it backward
        this.move(-1, 0);}
      if (k_Right) {  //d make it turn right
        this.move(0, 1);}
      if (k_Left) {  //a make it turn left
        this.move(0, -1);}
      if (k_SP) {
        if(canshoot == 0){
          bullet[bulletCount] = new Bullet(positionX+cos(direction)*size, positionY+sin(direction)*size, direction); //create new bullet
          bulletCount += 1; //count bullet
          canshoot = 1;
       }
      }
      if(frameCount%50==0){
          canshoot = 0;}



    for (int i=bulletCount-1; i>=0; i--) {  //for loop in bullet was create
      bullet[i].drawBullet(i); //draw each bullet

      /*if (frameCount%300==0) {       //reset bullet after time
        bullet = new Bullet[1000];
        bulletCount = 0;
        break;
      }*/
    }
    strokeWeight(5); //increase stoke size
    fill(255); //fill color with white
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
  public int getBullet(){
    return bulletCount;
  }
  public void setBullet(int newBullet){
    bulletCount = newBullet;
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

  public void drawBullet(int bulletNumber) {
    //draw from attribute
    line(positionX+cos(direction)*(move+10), positionY+sin(direction)*(move+10), positionX+cos(direction)*(move+20), positionY+sin(direction)*(move+20));
    move+=speed;  //update move from speed
    if (positionX+cos(direction)*(move+20) < 0 || positionX+cos(direction)*(move+20) > width){
      if (bulletNumber < shooter.getBullet()){
        arraycopy(bullet, bulletNumber+1, bullet, bulletNumber, shooter.getBullet()-(bulletNumber+1));
        bullet =(Bullet[]) shorten(bullet);
        shooter.setBullet(shooter.getBullet()-1);
      }
      else{
        bullet =(Bullet[]) shorten(bullet);
        shooter.setBullet(shooter.getBullet()-1);
      }
      arraycopy(bullet, bulletReserve);
      bullet = new Bullet[1000];
      arraycopy(bulletReserve, bullet);
    }
    else if (positionY+sin(direction)*(move+20) < 0 || positionY+sin(direction)*(move+20) > height){
      if (bulletNumber < shooter.getBullet()){
        arraycopy(bullet, bulletNumber+1, bullet, bulletNumber, shooter.getBullet()-(bulletNumber+1));
        bullet =(Bullet[]) shorten(bullet);
        shooter.setBullet(shooter.getBullet()-1);
      }
      else{
        bullet =(Bullet[]) shorten(bullet);
        shooter.setBullet(shooter.getBullet()-1);
      }
      arraycopy(bullet, bulletReserve);
      bullet = new Bullet[1000];
      arraycopy(bulletReserve, bullet);
    }
  }

  public float getX() {  //getter method
    return positionX+cos(direction)*(move+10);
  }
  public float getY() {  //getter method
    return positionY+sin(direction)*(move+10);
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
    fill(40,140,40);
    ellipse(positionX, positionY, size, size);
    line(positionX+cos(zeta-PI/3)*size/2, positionY+sin(zeta-PI/3)*size/2, positionX+cos(zeta-PI/7)*size, positionY+sin(zeta-PI/7)*size);
    line(positionX+cos(zeta+PI/3)*size/2, positionY+sin(zeta+PI/3)*size/2, positionX+cos(zeta+PI/7)*size, positionY+sin(zeta+PI/7)*size);
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

  public void overlap(Zombie obj){
    if (dist(positionX,positionY,obj.positionX,obj.positionY) < 100 && obj.positionX > positionX){ //if is overlap and obj is below that this
      positionX -= 1;  //detach each other
      obj.positionX += 1;

    }
    if (dist(positionX,positionY,obj.positionX,obj.positionY) < 100 && obj.positionY > positionY){  //if is overlap and obj is right of this
      positionY -= 1; //detach each other 
      obj.positionY += 1;

    }


  }
  public boolean player_die(float x,float y){
    float targetX = x;
    float targetY = y;
    if(dist(positionX, positionY, targetX, targetY) <= 115){
      return true;
    }
    else{
      return false;
    }
  }


  public void die(int zombieNumber){
    for (int i=0; i<shooter.getBullet(); i++) {  //for loop in bullet was create
      float dis = dist(bullet[i].getX(), bullet[i].getY(), positionX, positionY); //distance between head of bullet and center of each zombie
      if (dis < size/2){ //if distance  not over radius  means bullet hit zombie
        if (i < zombie.length-1){
          arraycopy(zombie, zombieNumber+1, zombie, zombieNumber, zombie.length-(zombieNumber+1));  //move i object to most right array
          zombie =(Zombie[]) shorten(zombie);       //remove most right object
          zombieCount-=1;
          if (i < bullet.length-1){
            arraycopy(bullet, i+1, bullet, i, shooter.getBullet()-(i+1));
            bullet =(Bullet[]) shorten(bullet);
            shooter.setBullet(shooter.getBullet()-1);
          }
          else{
            bullet =(Bullet[]) shorten(bullet);
            shooter.setBullet(shooter.getBullet()-1);
          }
        }
        else{
          zombie =(Zombie[]) shorten(zombie);
          zombieCount-=1;
          if (i < bullet.length-1){
            arraycopy(bullet, i+1, bullet, i, shooter.getBullet()-(i+1));
            bullet =(Bullet[]) shorten(bullet);
            shooter.setBullet(shooter.getBullet()-1);
          }
          else{
            bullet =(Bullet[]) shorten(bullet);
            shooter.setBullet(shooter.getBullet()-1);
          }
        }
        arraycopy(zombie, zombieReserve);
        zombie = new Zombie[20];
        arraycopy(zombieReserve, zombie);
        break;
      }
    }
  }
}
