class Tri {
  float x, y;
  float t;
  float s;
  int type;
  int direction;
  int gen;
  
  color myc;
  
  boolean  substituted = false;
  
  Tri(float _x, float _y, float _theta, float _scale, int _type, int _direction, int _gen) {
    x = _x;                    // position
    y = _y;
    t = _theta;                // rotation
    s = _scale;                // scale
    type = _type;              // shape  0:oblique triangle   1:acute triangle
    direction = _direction;    // direction    0:left   1:right
    gen = _gen;                // generation

    // randomly switch up colors
    changeColors();
    if (type==0) {
      myc = ayc;
    } else {
      myc = byc;
    }
    
    // autosubstitute     
    if (gen<maxgen) substitute();
    
    // now render
    render();
    
  }
 
  void render() {
    //if (substituted) return;      // do not render if substituted
    if (gen<maxgen-2) return;       // only render later generations of tiles
    float drawnScale = s;
    pushMatrix();
    translate(x,y);
    scale(drawnScale);
    rotate(t);
    strokeWeight(1.0/drawnScale);
    
    if (type==0) {
      // big oblique triangle
      noStroke();
      //stroke(myc,64);
      fill(myc,173);
      beginShape();
      vertex(H,-phi/2);
      vertex(0,0);
      vertex(H,phi/2);
      endShape(CLOSE);
    } else {
      // small acute triangle
      noStroke();
      //stroke(myc,64);
      fill(myc,173);
      beginShape();
      vertex(h,-1/(phi*2));
      vertex(0,0);
      vertex(h,1/(phi*2));
      endShape(CLOSE);
    }
      
    popMatrix();
    
  }
  
  void renderOutline(color oyc) {
    oyc = somecolor();
    //if (substituted) return;
    float drawnScale = s;
    pushMatrix();
    translate(x,y);
    scale(drawnScale);
    rotate(t);
    strokeWeight(1.0/drawnScale);
    if (type==0) {
      // big oblique triangle
      stroke(oyc,44);
      noFill();
      if (!substituted && random(1.0)<.2) fill(0,random(4,44));
      beginShape();
      vertex(H,-phi/2);
      vertex(0,0);
      vertex(H,phi/2);
      endShape(CLOSE);
    } else {
      // small acute triangle
      stroke(oyc,44);
      noFill();
      if (!substituted && random(1.0)<.2) fill(0,random(4,44));
      beginShape();
      vertex(h,-1/(phi*2));
      vertex(0,0);
      vertex(h,1/(phi*2));
      endShape(CLOSE);
    }
      
    popMatrix();
    
  }  
  
  void substitute() {
    if (substituted) return;     // do not allow double subdivision
    if (type==0) {
      // type 0 is oblique triangle
      float ns = s;
      
      // create same direction oblique triangle
      float td = 3*PI/5;
      float nt = t - td;
      if (direction==1) nt = t + td;
      float gd = -3*PI/10;
      float pt = t - gd;
      if (direction==1) pt = t + gd;
      float nx = x + s*cos(pt);
      float ny = y + s*sin(pt);
      Tri neoSm = new Tri(nx,ny,nt,ns,1,(direction+1)%2,gen+1);
      tris.add(neoSm);
        
      // create same direction oblique triangle
      ns = s/phi;
      td = 4*PI/5;
      nt = t - td;
      if (direction==1) nt = t + td;
      gd = -PI/10;
      pt = t + gd;
      if (direction==1) pt = t - gd;
      float ox = x + s/phi*cos(pt);
      float oy = y + s/phi*sin(pt);
      Tri neoBgo = new Tri(ox,oy,nt,ns,0,direction,gen+1);
      tris.add(neoBgo);
    } else {
      // type 1 is acute triangle 
      // create same direction oblique triangle
      float ns = s/(phi*phi);
      float td = -3*PI/5;
      float nt = t - td;
      if (direction==1) nt = t + td;
      
      float gd = PI/10;
      float pt = t - gd;
      if (direction==1) pt = t + gd;
      float nx = x + ns*cos(pt);
      float ny = y + ns*sin(pt);
      Tri neoBg = new Tri(nx,ny,nt,ns,0,direction,gen+1);
      tris.add(neoBg);
      
      // create same direction acute triangle
      ns = s/phi;
      td = 3*PI/5;
      float bt = t + td;
      if (direction==1) bt = t - td;
      pt = t - gd;
      if (direction==1) pt = t + gd;
      float bx = x + s*cos(pt);
      float by = y + s*sin(pt);
      Tri neoSm = new Tri(bx,by,bt,ns,1,direction,gen+1);
      tris.add(neoSm);
      
      // create opposite direction acute triangle
      td = 4*PI/5;
      float ot = t + td;
      if (direction==1) ot = t - td;
      pt = t - gd;
      if (direction==1) pt = t + gd;
      float ox = x + s*cos(pt);
      float oy = y + s*sin(pt);
      Tri neoSmo = new Tri(ox,oy,ot,ns,1,(direction+1)%2,gen+1);
      tris.add(neoSmo);
    }
    
    // flag this tile as having been substituted
    substituted = true;
  }  
  
  void substituteIanivSchweber() {
    if (substituted) return;     // do not allow double subdivision
    if (type==0) {
      // type 0 is oblique triangle
      float ns = s/phi;
      
      // create opposite direction acute triangle
      float td = 4*PI/5;
      float nt = t + td;
      if (direction==1) nt = t - td;
      float gd = PI/10;
      float pt = t - gd;
      if (direction==1) pt = t + gd;
      float nx = x + s/phi*cos(pt);
      float ny = y + s/phi*sin(pt);
      Tri neoSm = new Tri(nx,ny,nt,ns,1,(direction+1)%2,gen+1);
      tris.add(neoSm);
        
      // create opposite direction oblique triangle
      gd = 3*PI/10;
      pt = t + gd;
      if (direction==1) pt = t - gd;
      float ox = x + s*n*cos(pt);
      float oy = y + s*n*sin(pt);
      Tri neoBgo = new Tri(ox,oy,t,ns,0,(direction+1)%2,gen+1);
      tris.add(neoBgo);
        
      // create same direction oblique triangle
      td = 4*PI/5;
      nt = t - td;
      if (direction==1) nt = t + td;
      gd = PI/10;
      pt = t - gd;
      if (direction==1) pt = t + gd;
      float sx = x + s/phi*cos(pt);
      float sy = y + s/phi*sin(pt);
      Tri neoBgs = new Tri(sx,sy,nt,ns,0,direction,gen+1);
      tris.add(neoBgs);
      
    } else {
      // type 1 is acute triangle 
      // create same direction oblique triangle
      float ns = s/phi;
      float td = 3*PI/5;
      float nt = t - td;
      if (direction==1) nt = t + td;
      
      float gd = PI/10;
      float pt = t + gd;
      if (direction==1) pt = t - gd;
      float nx = x + s/phi*cos(pt);
      float ny = y + s/phi*sin(pt);
      Tri neoBg = new Tri(nx,ny,nt,ns,0,direction,gen+1);
      tris.add(neoBg);
      
      // create same direction acute triangle
      float bt = t + td;
      if (direction==1) bt = t - td;
      pt = t - gd;
      if (direction==1) pt = t + gd;
      float bx = x + s*cos(pt);
      float by = y + s*sin(pt);
      Tri neoSm = new Tri(bx,by,bt,ns,1,direction,gen+1);
      tris.add(neoSm);
    }
    substituted = true;
  }
  
}
    
