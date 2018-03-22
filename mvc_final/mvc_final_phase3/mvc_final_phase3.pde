import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;
import java.util.*;

Ball[] ballArray;
PeasyCam cam;
int count;
HashSet<Link> links;
HashSet<Link> store;

void setup(){
  
  size(800,800, P3D);
  colorMode(HSB, 360 , 100 , 100);
  count = 100;
  ballArray = new Ball[count];

  cam = new PeasyCam(this, 1500);
  links = new HashSet<Link>();
  store = new HashSet<Link>();
  for(int i = 0; i<ballArray.length; i++){
    ballArray[i] = new Ball();
    for(int j = 0; j < ballArray.length; j++){
        if(i != j){
        Link l = new Link(i,j);
        
        store.add(l);
    }}
  }

}

void draw(){
  
  
  
  background(0);
  noFill();
  stroke(0,0,100);
  box(width);
  for(int i = 0; i<ballArray.length; i++){
    ballArray[i].tick();
    ballArray[i].display();
    
    for(int j = i+1; j<ballArray.length; j++){
        Link l = new Link(i,j);
        if((ballArray[i].location.dist(ballArray[j].location) < ballArray[i].radius + ballArray[j].radius)){
                if(!links.contains(l)){
                 collide(ballArray[i], ballArray[j]);
                 links.add(l);  
              }
          }else{
           links.remove(l); 
          }
      
      
      
      
      
    }
    
  }
  cam.beginHUD();
  textSize(20);
  fill(0, 0, 100);
  text("MVC Final Project Phase 3 - TJ Liggett", 20, 20);
  text("PRESS UP TO RESTART", width*2/3, 20);
  cam.endHUD();
  
}

void keyPressed(){
  if(keyCode == UP){
  }

}


class Ball{
  PVector velocity;
  PVector location;
  boolean xWall;
  boolean yWall;
  boolean zWall;
  float radius;
  float mass;
  float hue;
  float saturation;
  float brightness;
  
  
  Ball(){
   radius = 25;
   mass = 4/3 * PI * pow((radius/25),3);
   xWall = false;
   yWall = false;
   zWall = false;
   velocity = new PVector(random(-20,20), random(-20,20), random(-20,20));
   velocity.normalize();
   velocity.mult(20);
   location = new PVector(random(-width/2 + radius, width/2 - radius),random(-width/2 + radius, width/2 - radius),random(-width/2 + radius, width/2 - radius));
   hue = 9*(float)Math.pow(velocity.mag(), 2)/40 + 180;
   saturation = 100;
   brightness = 100;
   
}

  Ball(PVector v, PVector l, float r){
   radius = r;
   velocity = v;
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
  }}
  
  
  
  
  
  void display(){
    pushMatrix();
    stroke(hue, saturation, brightness);
    noFill();
    translate(location.x, location.y, location.z);
    sphere(radius);
    popMatrix();
  }
  
  
  
  
  
}


void collide(Ball one, Ball two){
    
    PVector n = PVector.sub(one.location, two.location).normalize();  
    float Om = PVector.sub(one.velocity, two.velocity).dot(n);
    n.mult(Om);
    
    
    one.velocity.sub(n);
    two.velocity.add(n);
    one.hue = 9*(float)Math.pow(one.velocity.mag(), 2)/40 + 180;
    two.hue = 9*(float)Math.pow(two.velocity.mag(), 2)/40 + 180;
  }
  
  
class Link{
  HashSet<Integer> balls;
  int hash;
  public Link(int i, int j){
  balls = new HashSet<Integer>();
  balls.add(i);
  balls.add(j);
  String o = "";
  if(i < j){
    o = 9 + "" + i + 9 + j + 9;
  }else{
    o = 9 + "" + j + 9 + i + 9;
  }
  
  hash = Integer.parseInt(o);
  }
  public boolean is(int i, int j){
   return balls.contains(i) && balls.contains(j); 
  }
  
  public boolean equals(Object c){
   
    return this.hashCode() == c.hashCode();
    
  }
  
    
  
  
  public int hashCode(){
    return hash; 
  }
  
  public String toString(){
  String output = "[";
  for(Integer i : balls){
    output += i + ",";
  }
  output = output.substring(0,output.length()-1) + "]";
  return "" + hash;
  }
  
  
}