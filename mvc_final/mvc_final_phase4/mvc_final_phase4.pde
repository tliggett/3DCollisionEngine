import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;
import java.util.*;

Ball[] ballArray;
PeasyCam cam;
int count;
HashSet<Pair<Integer>> links;

void setup(){
  
  size(800,800, P3D);
  colorMode(HSB, 360 , 100 , 100);
  count = 100;
  ballArray = new Ball[count];
  
  cam = new PeasyCam(this, 1500);
  links = new HashSet<Pair<Integer>>();
  
  for(int i = 0; i<ballArray.length; i++){
    ballArray[i] = new Ball(random(15,40), random(15,20));
    //ballArray[i] = new Ball(40,0);  
}
  //ballArray[0] = new Ball(25, 20);
  //ballArray[0] = new Ball(400, 0);
  //ballArray[1] = new Ball(25, 0);
  

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
        Pair<Integer> l = new Pair<Integer>(i,j);
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
  text("MVC Final Project Phase 4 - TJ Liggett", 20, 20);
  cam.endHUD();
  
}

void keyPressed(){
  if(keyCode == UP){
  }

}


class Ball{
  PVector velocity;
  PVector location;
  float radius;
  float mass;
  float hue;
  float saturation;
  float brightness;
  
  
  Ball(){
   radius = 100;
   mass = 4/3 * PI * pow((radius/25),3);
   velocity = new PVector(random(-20,20), random(-20,20), random(-20,20));
   velocity.normalize();
   velocity.mult(20);
   initialize();
}


  Ball(float r){
   radius = r;
   mass = 4/3 * PI * pow((radius/25),3);
   velocity = new PVector(random(-20,20), random(-20,20), random(-20,20));
   velocity.normalize();
   velocity.mult(20);
   initialize();
   
}


  Ball(float r, float vm){
   radius = r;
   mass = 4/3 * PI * pow((radius/25),3);
   velocity = new PVector(random(-20,20), random(-20,20), random(-20,20));
   velocity.normalize();
   velocity.mult(vm);
   initialize();
   
}

    
  void initialize(){
   location = new PVector(random(-width/2 + radius, width/2 - radius),random(-width/2 + radius, width/2 - radius),random(-width/2 + radius, width/2 - radius));
   hue = random(360);
   //hue = 9*(float)Math.pow(velocity.mag(), 2)/40 + 180;
   saturation = mass*(float)Math.pow(velocity.mag(), 2)/10;
   brightness = 100;
  
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
  
  if(abs(location.z) + radius > width/2){
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
    
    PVector nA = PVector.sub(one.location, two.location).normalize();
    float OmA = 2*PVector.sub(one.velocity, two.velocity).dot(nA)/(1 + one.mass/two.mass);
    nA.mult(OmA);
    
    PVector nB = PVector.sub(two.location, one.location).normalize();
    float OmB = 2*PVector.sub(two.velocity, one.velocity).dot(nB)/(1 + two.mass/one.mass);
    nB.mult(OmB);
    
    one.velocity.sub(nA);
    two.velocity.sub(nB);
    one.saturation = one.mass*(float)Math.pow(one.velocity.mag(), 2)/10;
    two.saturation = two.mass*(float)Math.pow(two.velocity.mag(), 2)/10;
    //one.hue = 9*(float)Math.pow(one.velocity.mag(), 2)/40 + 180;
    //two.hue = 9*(float)Math.pow(two.velocity.mag(), 2)/40 + 180;
  }
  
 
class Pair<E>{
  private HashSet<E> items;
  
  public Pair(E one, E two){
    items = new HashSet<E>();
    items.add(one);
    items.add(two);  
  }
  
  public HashSet<E> getItems(){
    return items;
  }
  
  public boolean equals(Object o){
    if(! (o instanceof Pair<?>)){
      return false;
    }
    Pair<E> p = (Pair<E>)o;
    return p.getItems().equals(this.getItems());
  }
  
  public boolean equals(E one, E two){
    return items.contains(one) && items.contains(two);
  }
  
  public int hashCode(){
     int h = 0;
        Iterator<E> i = items.iterator();
        while (i.hasNext()) {
            E obj = i.next();
            if (obj != null)
                h += obj.hashCode();
       }
       return h;
  
  }
  
  public String toString(){
  String output = "[";
  for(E i : items){
    output += i + ",";
  }
  output = output.substring(0,output.length()-1) + "]";
  return output;
  }

} 