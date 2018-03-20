// me permite tener acceso a todos los objetos y propiedades de box2d

import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;

Box2DProcessing box2d;
Particle una;
ArrayList <Particle> Particulas;
ArrayList<Boundary> boundaries;
int s = second();
int an = 0;
int pantalla;
void setup(){
    background(0);  
  size(400,600);
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0,-3);
  box2d.listenForCollisions();
  Particulas = new ArrayList<Particle>();
  boundaries = new ArrayList<Boundary>();
  una = new Particle(200,10,30);
  boundaries.add(new Boundary(240,191,75,20));
  boundaries.add(new Boundary(233,93,60,15));
  boundaries.add(new Boundary(55,260,100,20));
  boundaries.add(new Boundary(170,480,60,20));
  boundaries.add(new Boundary(265,540,80,20));
  boundaries.add(new Boundary(330,330,105,20));
  
  boundaries.add(new Boundary(-60,height/2,0,height));
  
  boundaries.add(new Boundary(width/2,0,width,0));
  
  boundaries.add(new Boundary(width+60,height/2,0,height));
  
  boundaries.add(new Boundary(width/2,height,width,0));

}



void draw(){

  switch(pantalla) {
  case 0:
    intro();
    break;
  case 1:
    instruccion();
    break;
  case 2:
    vacio();
    break;
  case 3:
    fin();
    break;
  }
}
void intro(){
  background(0);
  textSize(50);
  fill(255,0,0);
  text("THE VOID",100,200);
  textSize(25);
  stroke(2);
  text("Presiona para continuar 'w'",60,450);
  keyPressed();
  if (key == 'w'|| key=='W') {
    pantalla = 1;
    background(0);
  }
}
void instruccion(){
  
  fill(255,0,0);
  textSize(25);
  text("Para maniobrar utiliza la tecla ",30,150);
  text("'a'(Izquierda) y 'd'(Derecha)",30,250);
  text("Presiona para continuar 'S'",40,550);
  if (key == 's'|| key=='S') {
    pantalla = 2;
    background(0);
  }
}
void vacio(){  

  box2d.step();
 /* if(ini==1){
  una = new Particle(200,10,30);
  ini++;
  }
  */
  una.display();
  una.done();
  fill(255);
  textSize(20);
  text("FAMILIA",200,200);
  text("AMOR",200,100);
  text("AMISTADES",0,270);
  text("METAS",135,490);
  text("EXITOS",233,544);
  text("OBJETIVOS",280,340);
    if (s<=59){
   
      fill(0);
    rect(0,0,350,30);
    fill(255,0,0);
    text("Años de Vida: "+an,10,20);
    s +=1; 
     }else{
      an=an+1;
      s=0;
     }
     if (an==27){
      box2d.setGravity(-3.3,0); 
     }
     if (an>=100){
       una.done();
 
     }
  delay(0);
  //  una.mover();
  //una.mover();
   for (Particle c:Particulas){
    c.display();
  }

   if (keyPressed && key=='a' || key=='A'){
       box2d.setGravity(-3.1,-1);
      
  }
  if (keyPressed && key=='s' || key=='S'){
       box2d.setGravity(0,-3.1);
  }
  if (keyPressed && key=='d' || key=='D'){
       box2d.setGravity(3.1,-1);
  }
}
void fin(){
  
  fill(255,0,0);
  textSize(25);
  
  text("El fin a llegado y una estela has dejado...",60,350);
  text("Presiona 0 para regresar",60,450);
  if (keyPressed && key=='0'){
      pantalla = 0;
      background(0);
      una = new Particle(200,10,30);
  }
}

void beginContact(Contact cp) {
  // Get both fixtures
  Fixture f1 = cp.getFixtureA();
  Fixture f2 = cp.getFixtureB();
  // Get both bodies
  Body b1 = f1.getBody();
  Body b2 = f2.getBody();

  // Get our objects that reference these bodies
  Object o1 = b1.getUserData();
  Object o2 = b2.getUserData();
  
  if (o1.getClass() == Boundary.class && o2.getClass() == Particle.class) {
    Boundary boundaries= (Boundary) o1;
    boundaries.change();
    Particle una = (Particle) o2;
    una.change(1);

  }
  if (o1.getClass() == Particle.class && o2.getClass() == Boundary.class) {
    Boundary boundaries= (Boundary) o1;
    boundaries.change();
    Particle una = (Particle) o2;
    una.change(3);

  }

}