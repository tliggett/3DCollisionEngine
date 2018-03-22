import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;

Ball ball;
PeasyCam cam;

void setup() {
  size(800, 800, P3D);
  ball = new Ball();
  cam = new PeasyCam(this, 1500);
}

void draw() {
  background(0);
  noFill();
  stroke(255);
  box(width);
  ball.tick();
  ball.display();
  cam.beginHUD();
  textSize(20);
  fill(255);
  text("MVC Final Project Phase I - TJ Liggett", 20, 20);
  text("PRESS UP TO RESTART", width*2/3, 20);
  cam.endHUD();
}

void keyPressed() {
  if (keyCode == UP)
    ball = new Ball();
}


class Ball {
  PVector velocity;
  PVector location;
  color fill;
  float radius;
  Ball() {
    radius = 100;
    velocity = new PVector(random(-20, 20), random(-20, 20), random(-20, 20));
    velocity.limit(20);
    fill = color(random(255), random(255), random(255));
    location = new PVector(random(width/2 - radius), random(width/2 - radius), random(width/2 - radius));
  }

  Ball(PVector v, PVector l, float r) {
    radius = r;
    velocity = v;
    fill = color(random(255), random(255), random(255));
    location = l;
  }

  void tick() {
    move();
  }
  
  void move() {
    location.add(velocity);

    if (abs(location.x) + radius > width/2)
      velocity.x *= -1;

    if (abs(location.y)+ radius > width/2)
      velocity.y *= -1;

    if (abs(location.z) + radius > width/2)
      velocity.z *= -1;
  }

  void display() {
    pushMatrix();
    stroke(fill);
    noFill();
    translate(location.x, location.y, location.z);
    sphere(radius);
    popMatrix();
  }
}