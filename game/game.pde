PImage spaceship, cursor, background, lasershot;
final float player[]=new float[4];  // PlayerX, PlayerY, PlayerXSpeed and PlayerYSpeed

void setup() {
  frameRate(100);  // 100 FPS
  noCursor();  // Hidding OS's cursor
  //fullScreen();  //  For playing
  size(600, 600);  //  For debuging ;-)

  spaceship=loadImage("spaceship.png");  //  35x31 px
  cursor=loadImage("cursor.png");  //  10x10 px
  lasershot=loadImage("lasershot.png");  //  10x2 px
  background=loadImage("background.jpg");
  player[0]=random(35/2, width-35/2);  // Player's X-Posistion
  player[1]=random(35/2, height-35/2);  // Player's Y-Posistion
  player[2]=random(-0.5, 0.5);  // Player's X-Speed
  player[3]=random(-0.5, 0.5);  // Player's Y-Speed
}

void draw() {
  image(background, 0, 0);
  Spaceship();
  Cursor();
}

void keyPressed() {
  if (key==ESC) {
    exit();
  }
}

void mousePressed() {
  if (mouseButton==RIGHT) {
    LaserShot();
  }
}

void Cursor() {
  image(cursor, mouseX-5, mouseY-5);
}

void Spaceship() {
  // Update the spaceship's position
  if ((mousePressed==true) && (mouseButton==LEFT)) {
    PlayerMove();
  }

  player[0]+=player[2];
  player[1]+=player[3];

  // Correct the spaceship's position (don't go off screen)
  if (player[0]>width-35/2) {
    player[0]=width-35/2;
    player[2]=0;
  } else if (player[0]<35/2) {
    player[0]=35/2;
    player[2]=0;
  }
  if (player[1]>height-35/2) {
    player[1]=height-35/2;
    player[3]=0;
  } else if (player[1]<35/2) {
    player[1]=35/2;
    player[3]=0;
  }

  // Distance between scpaceship and cursor
  float distance=sqrt(pow(player[0]-mouseX, 2)+pow(player[1]-mouseY, 2));

  // Angle
  float angle=acos((mouseX-player[0])/distance);
  if (mouseY<=player[1]) {
    angle=-angle;
  }
  if (distance<=0) {
    angle=0;
  }

  // Display rotated spaceship
  pushMatrix();
  translate(player[0], player[1]);
  rotate(angle);
  image(spaceship, 0-31/2, 0-35/2);
  popMatrix();
}

void PlayerMove() {
  float distance=sqrt(pow(player[0]-mouseX, 2)+pow(player[1]-mouseY, 2));
  player[2]+=0.05*(mouseX-player[0])/distance;  //  playerXSpeed+=cos(angle)
  player[3]+=0.05*(mouseY-player[1])/distance;  //  playerXSpeed+=sin(angle)
}

void LaserShot() {
  println("LASER_SHOT");
}