PImage spaceship, cursor, background, laser_shot;
int playerX, playerY;
float playerXSpeed, playerYSpeed;

void setup() {
  frameRate(100);
  noCursor();
  //fullScreen();  //  For playing
  size(600, 600);  //  For debuging ;-)

  spaceship=loadImage("spaceship.png");  //  35x31 px
  cursor=loadImage("cursor.png");  //  10x10 px
  laser_shot=loadImage("laser_shot.png");  //  10x2 px
  background=loadImage("background.jpg");
  playerX=int(random(35/2, width-35/2));
  playerY=int(random(35/2, height-35/2));
  playerXSpeed=0;
  playerYSpeed=0;
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
    println("LASER_SHOT");
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

  playerX+=round(playerXSpeed);
  playerY+=round(playerYSpeed);

  // Correct the spaceship's position (don't go off screen)
  if (playerX>width-35/2) {
    playerX=width-35/2;
    playerXSpeed=0;
  } else if (playerX<35/2) {
    playerX=35/2;
    playerXSpeed=0;
  }
  if (playerY>height-35/2) {
    playerY=height-35/2;
    playerYSpeed=0;
  } else if (playerY<35/2) {
    playerY=35/2;
    playerYSpeed=0;
  }

  // Distance between scpaceship and cursor
  float distance=sqrt(pow(playerX-mouseX, 2)+pow(playerY-mouseY, 2));

  // Angle
  float angle=acos((mouseX-playerX)/distance);
  if (mouseY<=playerY) {
    angle=-angle;
  }
  if (distance<=0) {
    angle=0;
  }

  // Display rotated spaceship
  pushMatrix();
  translate(playerX, playerY);
  rotate(angle);
  image(spaceship, 0-31/2, 0-35/2);
  popMatrix();
}

void PlayerMove() {
  float distance=sqrt(pow(playerX-mouseX, 2)+pow(playerY-mouseY, 2));
  playerXSpeed+=0.1*(mouseX-playerX)/distance;  //  playerXSpeed+=cos(angle)
  playerYSpeed+=0.1*(mouseY-playerY)/distance;  //  playerXSpeed+=sin(angle)
}