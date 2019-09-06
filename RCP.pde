
int ritmoCardiaco=33, compresion=0, tiempo;
int tiempoActual;
int tiempoCardiaco;
color fondo =#FEF1E0;
PImage corazon, reloj, ritmo, cuerpo;
PImage[] persona = new PImage[18];
color boton1=#00aaff; //color primario del botón.
color boton2=#F75C1B; //color secundario del boton.
boolean inicio=false, tec=false;
String texto;
Button botonInicio, botonVolver;
void setup() {
  size(800, 600);
  botonInicio= new Button(300, 10, 60, 32, " Iniciar RPC ", boton1, boton2, textWidth(" Iniciar RPC ")*2+50);
  botonVolver= new Button(610, 500, 50, 24, " Reintentar ", boton1, boton2, textWidth(" Iniciar RPC ")*2+50 );
  corazon = loadImage("corazon.png");
  reloj = loadImage("tiempo.png");
  ritmo = loadImage("cardiograma.png");
  persona[0] = loadImage( "frame_00_delay-0.07s.gif" );
  persona[1] = loadImage( "frame_01_delay-0.07s.gif" );
  persona[2] = loadImage( "frame_02_delay-0.07s.gif" );
  persona[3] = loadImage( "frame_03_delay-0.07s.gif" );
  persona[4] = loadImage( "frame_04_delay-0.07s.gif" );
  persona[5] = loadImage( "frame_05_delay-0.07s.gif" );
  persona[6] = loadImage( "frame_06_delay-0.07s.gif" );
  persona[7] = loadImage( "frame_07_delay-0.07s.gif" );
  persona[8] = loadImage( "frame_08_delay-0.07s.gif" );
  persona[9] = loadImage( "frame_09_delay-0.07s.gif" );
  persona[10] = loadImage( "frame_10_delay-0.07s.gif" );
  persona[11] = loadImage( "frame_11_delay-0.07s.gif" );
  persona[12] = loadImage( "frame_12_delay-0.07s.gif" );
  persona[13] = loadImage( "frame_13_delay-0.07s.gif" );
  persona[14] = loadImage( "frame_14_delay-0.07s.gif" );
  persona[15] = loadImage( "frame_15_delay-0.07s.gif" );
  persona[16] = loadImage( "frame_16_delay-0.07s.gif" );
  persona[17] = loadImage( "frame_17_delay-0.07s.gif" );

  frameRate(8);
}


void draw() {
  background(fondo);
  fill(0);
  tiempoCardiaco++;
  textAlign(LEFT);
  textSize(30);
  text("RCP", 50, 50 );
  textSize(20);
  textAlign(CENTER);
  text(ritmoCardiaco, 650, 40);
  text(compresion, 650, 90);
  text(tiempo, 650, 140);
  image( persona[15], 200, 200, 400, 350 );

  image(ritmo, 600, 20, 30, 30);
  image(corazon, 600, 70, 30, 30);
  image(reloj, 600, 120, 30, 30);


  if (!inicio) {
    compresion=0;
    ritmoCardiaco=33;
    tiempoActual=(int)millis()/1000;
    tiempo=int( millis()/1000)-tiempoActual;
    botonInicio.draw();
    textSize(20);
    fill(0);
    textAlign(CENTER);
    text("Tiempo máximo: 30 Seg", width/2, height/2-200);
    textSize(18);
    text(" Presiona las tecla w para hacer RCP ", width/2, height/2-160);
  } else {
    if (tiempo<=30&&compresion<30) {
        frameRate(8);
      interaccionKeyboard();
      textSize(34);
      fill(0);
      textAlign(CENTER);
      timer();
      variarRitmo(30, 36);
    } else {
      botonVolver.draw(); 

      if (compresion>=30) {
        textAlign(CENTER);
        fill(#9DE22F);
        text("HAZ SALVADO UNA VIDA", width/2, height/2-200);
        variarRitmo(60, 66);
        frameRate(30);
        image( persona[frameCount%17], 200, 200, 400, 350 );

      }  
      if (tiempo>30) {
        textAlign(CENTER);
        fill(#E2062C);
        text("LA VICTIMA HA MUERTO", width/2, height/2-200);
        variarRitmo(0, 1);
      }
    }
  }
}


void mousePressed() {
  println(inicio);
  if (botonInicio.over()) {
    inicio=true;
  } 
  else if (botonVolver.over()) {
    inicio=false;
  }
}
void variarRitmo(int a, int b) {
  if (tiempoCardiaco>=20) {
    ritmoCardiaco=(int) random(a, b);
    tiempoCardiaco=0;
  }
}


void timer() {
  tiempo=int( millis()/1000)-tiempoActual;
}

void interaccionKeyboard()
{
  if (keyPressed==true)
  {
    if (key=='w'||key=='W')
    {   
      if(!tec){
      tec=true;
      compresion++;
      image( persona[0], 200, 200, 400, 350 );
      }
    }
  }else if(tec==true){
    tec=false;

  }
}




class Button {
  int x, y, alto, texto;
  float w;
  String label ;
  color relleno, resaltado;
  Button(int x, int y, int alto, int texto, String label, color relleno, color resaltado) {
    this.x = x;
    this.y = y;
    this.alto=alto;
    this.texto= texto;
    this.label = label;
    this.relleno = relleno;
    this.resaltado = resaltado;
    this.w= x + textWidth(label) +5;
  }
  Button(int x, int y, int alto, int texto, String label, color relleno, color resaltado, float w) {
    this.x = x;
    this.y = y;
    this.alto=alto;
    this.texto= texto;
    this.label = label;
    this.relleno = relleno;
    this.resaltado = resaltado;
    this.w=w +x +5;
  }
  void draw() {
    textSize(texto);

    fill(relleno);
    if (over()) {
      fill(resaltado);
    }
    rect(x, y, textWidth(label)+5, alto, 6);
    fill(255);
    textAlign(LEFT);
    text(label, x, y +alto -2*alto/7);
  }

  void changeLabel(String label) {
    this.label=label;
  }
  boolean over() {
  
    if (mouseX >= x && mouseY >= y && mouseX <= w && mouseY <= y + alto) {
      return true;
    }
    return false;
  }
}
