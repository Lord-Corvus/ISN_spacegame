PImage spaceship, cursor, background, lasershot;
final float player[]=new float[4];  // PlayerX, PlayerY, PlayerXSpeed and PlayerYSpeed
final float laser[][]=new float[100][3]; //  100 x LaserX, LaserY et LaserAngle
float distance, angle;
int laserCount=0;
final int nbLaser=100;

void setup() {
  frameRate(100);  // 100 FPS
  noCursor();  // Hidding OS's cursor
  fullScreen();  //  For playing
  //size(600, 600);  //  For debuging ;-)
  background(0);
  imageMode(CENTER);

  spaceship=requestImage("spaceship.png");  //  35x31 px
  cursor=requestImage("cursor.png");  //  10x10 px
  lasershot=requestImage("lasershot.png");  //  10x2 px
  background=requestImage("background.jpg");
  player[0]=random(spaceship.width/2, width-spaceship.width/2);  // Player's X-Posistion
  player[1]=random(spaceship.width/2, height-spaceship.width/2);  // Player's Y-Posistion
  player[2]=random(-0.5, 0.5);  // Player's X-Speed
  player[3]=random(-0.5, 0.5);  // Player's Y-Speed
  for (int i=0; i<nbLaser; i++) {
    laser[i][0]=-1;
    laser[i][1]=-1;
    laser[i][2]=0;
  }
}

void draw() {
  if (background.width!=0) {
    image(background, width/2, height/2);
  } else {
    background(0);
  }

  // Distance between scpaceship and cursor
  distance=sqrt(pow(player[0]-mouseX, 2)+pow(player[1]-mouseY, 2));
  // Angle
  angle=acos((mouseX-player[0])/distance);
  if (mouseY<=player[1]) {
    angle=-angle;
  }
  if (distance<=0) {
    angle=0;
  }

  LaserShot();
  Spaceship();
  Cursor();
}

void keyPressed() {
  switch (key) {
  case ' ':
    LaserShotFire();
    break;
  case ESC:
    exit();
    break;
  }
}

void Cursor() {
  image(cursor, mouseX, mouseY);
}

void Spaceship() {
  // Update the spaceship's position
  if (mousePressed==true) {
    PlayerMove();
  }

  player[0]+=player[2];
  player[1]+=player[3];

  // Correct the spaceship's position (don't go off screen)
  if (player[0]>width-spaceship.width/2) {
    player[0]=width-spaceship.width/2;
    player[2]=0;
  } else if (player[0]<spaceship.width/2) {
    player[0]=spaceship.width/2;
    player[2]=0;
  }
  if (player[1]>height-spaceship.width/2) {
    player[1]=height-spaceship.width/2;
    player[3]=0;
  } else if (player[1]<spaceship.width/2) {
    player[1]=spaceship.width/2;
    player[3]=0;
  }

  // Display rotated spaceship
  pushMatrix();
  translate(player[0], player[1]);
  rotate(angle);
  image(spaceship, 0, 0);
  popMatrix();
}

void PlayerMove() {
  player[2]+=0.05*(mouseX-player[0])/distance;  //  playerXSpeed+=cos(angle)
  player[3]+=0.05*(mouseY-player[1])/distance;  //  playerXSpeed+=sin(angle)
}

void LaserShot() {
  for (int i=0; i<nbLaser; i++) {
    if (((laser[i][0]>0)&&(laser[i][0]<width))&&((laser[i][1]>0)&&(laser[i][1]<height))) {
      laser[i][0]+=10*cos(laser[i][2]);
      laser[i][1]+=10*sin(laser[i][2]);
      // Display the laser shot
      pushMatrix();
      translate(laser[i][0], laser[i][1]);
      rotate(laser[i][2]);
      image(lasershot, 0, 0);
      popMatrix();
    } else {
      laser[i][0]=-1;
      laser[i][1]=-1;
    }
  }
}

void LaserShotFire() {
  laserCount++;
  if (laserCount>=100) {
    laserCount=0;
  }
  laser[laserCount][0]=player[0];
  laser[laserCount][1]=player[1];
  laser[laserCount][2]=angle;
}