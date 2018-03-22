import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;

Ball ballOne, ballTwo;
PeasyCam cam;
boolean collided;
float collisions;

void setup(){
  size(800,800, P3D);
  ballOne = new Ball();
  ballTwo = new Ball(new PVector(0,0,0), new PVector(0,0,0), 100);
  cam = new PeasyCam(this, 1500);
  collided = false;
  collisions = 0;

}

void draw(){
  background(0);
  noFill();
  stroke(255);
  box(width);
  ballOne.tick();
  ballTwo.tick();
  ballOne.display();
  ballTwo.display();
  cam.beginHUD();
  textSize(20);
  fill(255);
  text("MVC Final Project Phase 2 - TJ Liggett", 20, 20);
  text("PRESS UP TO RESTART", width*2/3, 20);
  cam.endHUD();
  
  if((ballOne.location.dist(ballTwo.location) < ballOne.radius + ballTwo.radius) && !collided){
  collisions++;
  
  println();
  println("collision detected : " + (int)collisions);
  
  collided = true;
  collide(ballOne, ballTwo);
  println("One KE : " + pow(ballOne.velocity.mag(), 2)/2);
  println("Two KE : " + pow(ballTwo.velocity.mag(), 2)/2);
  println("Total KE : "  + (int)(pow(ballOne.velocity.mag(), 2)/2 + pow(ballTwo.velocity.mag(), 2)/2));
  }else if((ballOne.location.dist(ballTwo.location) > ballOne.radius + ballTwo.radius)){
    collided = false;
  }
  
  
}

void keyPressed(){
  if(keyCode == UP)
  ballOne = new Ball();
  ballTwo = new Ball(new PVector(0,0,0), new PVector(0,0,0), 100);


}


class Ball{
  PVector velocity;
  PVector location;
  color fill;
  boolean xWall;
  boolean yWall;
  boolean zWall;
  float radius;
  Ball(){
   radius = 100;
   xWall = false;
   yWall = false;
   zWall = false;
   velocity = new PVector(random(-20,20), random(-20,20), random(-20,20));
   velocity.normalize();
   velocity.mult(25);
   fill = color(random(255), random(255), random(255));
   location = new PVector(random(width/2 - radius),random(width/2 - radius),random(width/2 - radius));
   
}

  Ball(PVector v, PVector l, float r){
   radius = r;
   velocity = v;
   fill = color(random(255), random(255), random(255));
   location = l;
  
  
  }
  
  void tick(){
  move();
  }
  void move(){
  location.add(velocity);
  
  
  if(abs(location.x) + radius > width/2){
  if(location.x > 0)
  {velocity.x = abs(velocity.x) *-1;}
  else{
  velocity.x = abs(velocity.x);
  }
  }
  
  if(abs(location.y) + radius > width/2){
  if(location.y > 0)
  {velocity.y = abs(velocity.y) *-1;}
  else{
  velocity.y = abs(velocity.y);
  }
  }
  
  if(abs(location.z) + radius > width/2 && !zWall){
  if(location.z > 0)
  {velocity.z = abs(velocity.z) *-1;}
  else{
  velocity.z = abs(velocity.z);
  }
  }
  
  
  



  

  }
  
  
  
  
  
  void display(){
    pushMatrix();
    stroke(fill);
    noFill();
    translate(location.x, location.y, location.z);
    sphere(radius);
    popMatrix();
  }
  
  
  
  
  
}


void collide(Ball one, Ball two){
    PVector n = PVector.sub(one.location, two.location).normalize();  
    println("n: " + n.mag());
    float Psi = PVector.sub(one.velocity, two.velocity).dot(n);
    println("Om: " + Psi);
    n.mult(Psi);
    one.velocity.sub(n);
    two.velocity.add(n);
  }