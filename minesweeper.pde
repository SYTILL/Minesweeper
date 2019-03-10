String[] imageNames = {"def.png","1.png","2.png","3.png","4.png","5.png","6.png","7.png","8.png","flag.png","space.png","mine.png","red.png","smile1.png","smile2.png","smile3.png","smile4.png","smilepressed.png" };
PImage[] images = new PImage[imageNames.length]; //def=0 flag=9 space=10 mine=11 red=12
int x = 0, y = 0, px, py;                        //smile1=13 s2=14 s3=15 s4=16 pressed=17  
//boolean gameover = false;
boolean pressing = false;
int msize = 40; //16

int xnum = 10;
int ynum = 10;
int xadj = 20;
int yadj = 120;
int minenum = 10;
int[][] array = new int[xnum][ynum]; //0 is not 1, 1 is 1
int[][] m_array = new int[xnum][ynum];

void setup(){
  loop();
  clear();
  background(192,192,192);
  size(440,540);
  loadImages();
  reset();
}

void draw(){ //update
    drawMine(); //draw mine
    mousePos(); //get position of mouse
    click();    //check click
    open();     //open block
}

void drawMine(){
  int i,j;
  for(i=0;i<xnum;i++){ 
    for(j=0;j<ynum;j++){
      image(images[array[i][j]],i*msize+xadj,j*msize+yadj,msize,msize);
    }
  }
}

void reset(){
  int i,j;
  for(i=0;i<xnum;i++){ //reset array
    for(j=0;j<ynum;j++){
      array[i][j] = 0; //def
      image(images[0],i*40+xadj,j*40+yadj,msize,msize);
    }
  }
  for(i=0;i<xnum;i++){ //reset m_array
    for(j=0;j<ynum;j++){
      m_array[i][j] = 0; //0
    }
  }
  for(i=0;i<minenum;i++){ //set mine
    m_array[int(random(0,xnum))][int(random(0,ynum))] = 11; //mine
  }
}

void mousePos(){
  if(xadj<mouseX && xadj+xnum*msize>mouseX && yadj<mouseY && yadj+ynum*msize>mouseY){
    x = (mouseX-xadj)/msize;
    y = (mouseY-yadj)/msize;
  }
}

void click(){
  if(xadj<mouseX && xadj+xnum*msize>mouseX && yadj<mouseY && yadj+ynum*msize>mouseY){
    if(mousePressed){
      if(mouseButton == LEFT){ //mouse left click
        if(array[x][y]==0){ //only def block is click-able
          if(!pressing){ //if mouse is not pressed
            px=x; py=y;
            pressing = true; //pressed
          }
          if(px!=x||py!=y){ //if mouse is out of previous block
             array[px][py] = 0;
             px=x; py=y;
          }
          
        }array[x][y] = 10;
      }else{ }//mouse right click
    }else pressing = false; //not pressing
  }
}

void open(){
  if(!pressing){
    if(array[x][y]==10){
      if(m_array[x][y]==11){//if mine pressed - gameover
        gameover();
      }else{
        search(x,y);
      }
    }
  }
}

void search(int sx,int sy){
  int check=0;
  int i,j;
  int ix,iy;
  for(i=0;i<3;i++){ 
    for(j=0;j<3;j++){
      ix=sx-1+i; iy=sy-1+j;
      if(ix<0)ix=0;else if(ix>9)ix=9;//limit x value in 0~9
      if(iy<0)iy=0;else if(iy>9)iy=9;//limit y value in 0~9
      if(m_array[ix][iy]==11)check++;
    }
  }
  ix=0; iy=0;
  m_array[sx][sy]=1;
  if(check!=0)array[sx][sy]=check;
  else{
    array[sx][sy]=10;
    for(i=0;i<3;i++){
      for(j=0;j<3;j++){
        ix=sx-1+i; iy=sy-1+j;
        if(ix<0)ix=0;else if(ix>9)ix=9;//limit x value in 0~9
        if(iy<0)iy=0;else if(iy>9)iy=9;//limit y value in 0~9
        if(m_array[ix][iy]!=1)search(ix,iy);
      }
    }
  }
}

void gameover(){
  int i,j;
  for(i=0;i<xnum;i++){ //show position of all the mines
    for(j=0;j<ynum;j++){
      if(m_array[i][j]==11){
        array[i][j]=11; 
      }
    }
  }
  drawMine();
  noLoop();
}

void loadImages(){
  int i;
  for(i=0; i < imageNames.length; i++){
    String imageName = imageNames[i];
    images[i] = loadImage(imageName);
  }
}
