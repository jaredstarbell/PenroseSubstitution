// Penrose Substitution
//   Jared S Tarbell
//   February 9, 2020
//   Albuquerque, New Mexico, USA
//
//   Processing 3.5.3

ArrayList<Tri> tris = new ArrayList<Tri>();

// jackson pollock CSM colors
color[] pollock = {#E0A867, #BB723A, #CA7947, #C37A4F, #C37A47, #B46A41, #B47249, #6F372C, #603F36, #613731, #D9D9D3, #BA8960, #A46333, #D19937, #9A732F, #EFCF2C, #C9A941, #3E393B, #5C4F50, #7C644C, #817B63, #D29070, #BA8137, #955C3D, #B0B1AC, #502B2A, #CB6A3A, #444143, #6B7343, #593737, #8A7B63, #93735B, #E2E2E3, #3E2C27, #B28237, #51322C, #A28A49, #C0B1B2, #C8B977, #764E3D, #938251, #655546, #B19A8A, #E7B84F, #33485A, #373335, #7792B8, #EA9F61, #8B6B53, #B46A5A, #CB5235, #A18A7B, #BD5243, #E6A87F, #516587, #85544C, #70836C, #8A8A51, #D1B166, #8C636C, #8D5C54, #EEEFF2, #584037, #B54B31, #517CAB, #544F48, #4E4041, #E0B840, #48392E, #9E5343, #392B2D, #6E4E57, #41322E, #8C6B43, #9E362C, #6883AA, #7C7342, #2E333D, #BC5B30, #382B2A, #3F4033, #63654E, #A37251, #683F31, #BB7A48, #66402C, #6E839D, #C0A988, #A98A72, #38322E, #333A3D, #874436, #60382C, #40392E, #3A5E7F, #C28948, #413234, #302C35, #92826B, #BA9160, #C1A16F, #D9A97F, #7C6C4B, #D9B976, #6E7C7F, #7D5D4C, #A28A50, #8B7335, #5D4E2E, #E6D8D8, #B47240, #292627, #615E61, #37333C, #946B43};
// flourescent colors
color[] fColor = {#ff9966, #ccff00, #ff9933, #ff00cc, #ee34d3, #4fb4e5, #abf1cf, #ff6037, #ff355e, #66ff66, #ffcc33, #ff6eff, #ffff66, #fd5b78};
color somecolor() { return pollock[floor(random(pollock.length))]; }
color ayc;
color byc;

// pre-compute helpful constants
float TAU5 = TAU/5;                 // 2*PI/5
float phi = (1+sqrt(5))/2;          // 1.6180339887498948482045868343656
float phiSqr = phi*phi;             // phi squared
float H = sqrt(1-phiSqr/4);         // height of oblique triangle
float h = sqrt(1 - 1/(4*phiSqr));   // height of acute triangle
float n = phi - 2/phi;              // 

int maxgen = 5;                    // maximum number of substitution generations

void setup() {
  //size(2000,1000,FX2D);
  fullScreen(FX2D);
  background(0);
  blendMode(SCREEN);

  // alternating colors for two triangle shapes
  ayc = somecolor();
  byc = somecolor();
  
  // begin generating with a seed object
  seed();
  
}

void seed() {
  /*
  // small acute triangles
  Tri neos = new Tri(width/2-1000*h,height/2,0,1000,1,0,0);
  tris.add(neos);
  Tri neob = new Tri(width/2+1000*h,height/2,PI,1000,1,1,0);
  tris.add(neob);
  */
  
  /*
  // two oblique triangles as rhomb
  float s = 3400;
  Tri neoL = new Tri(width/2,height/2-s*H,HALF_PI,s,0,0,0);
  tris.add(neoL);
  Tri neoR = new Tri(width/2,height/2+s*H,-HALF_PI,s,0,1,0);
  tris.add(neoR);
  */
  
  /*
  // two oblique triangles as dart
  float s = 1600;
  Tri neoL = new Tri(width/2,height/2,4*PI/10,s,0,1,0);
  Tri neoR = new Tri(width/2,height/2,PI,s,0,0,0);
  tris.add(neoL);
  tris.add(neoR);
  */
  /*
  // two acute triangles as rhomb
  float s = width/2;
  Tri neoL = new Tri(width/2-s*h,height/2,0,s,1,1,0);
  Tri neoR = new Tri(width/2+s*h,height/2,PI,s,1,0,0);
  tris.add(neoL);
  tris.add(neoR);
  */

  
  // sun
  float s = width;
  for (int i=0;i<5;i++) {
    float theta = i*TAU/5;
    Tri neoL = new Tri(width/2,height/2,theta,s,1,0,0);
    Tri neoR = new Tri(width/2,height/2,theta+PI/5,s,1,1,0);
    tris.add(neoL);
    tris.add(neoR);
  }
  /*
  
  // cube
  float s = height/2;
  float dh = s/phi;
  for (int i=0;i<5;i++) {
    float bit = (i+1)%2;
    Tri neoL = new Tri(width/2-s*h*bit,height/2-dh+dh*i/2,0,s,1,0,0);
    Tri neoR = new Tri(width/2+s*h*bit,height/2-dh+dh*i/2,PI,s,1,1,0);
    tris.add(neoL);
    tris.add(neoR);
  }
  */
  
  
}

void renderOutlines() {
  // render just the outlines
  blendMode(MULTIPLY);
  for (Tri t:tris) t.renderOutline(color(0,44));
  blendMode(SCREEN);
}

void changeColors() {
  // periodically switch up the colors
  if (random(1.0)<.01) ayc = somecolor();
  if (random(1.0)<.01) byc = somecolor();
}  

void draw() {
  // nothing to do here,
  // renders in one go
}

void keyPressed() {
  if (key==' ') {
    // press spacebar to generate new composition
    tris.clear();
    background(0);
    ayc = somecolor();
    byc = somecolor();
    seed();
  }
  if (key=='b' || key=='B') {
    renderOutlines();
  }
}
