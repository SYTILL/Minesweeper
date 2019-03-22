String[] imageNames = {"def.png","1.png","2.png","3.png","4.png","5.png","6.png","7.png","8.png","flag.png","space.png","mine.png","red.png",
"smile1.png","smile2.png","smile3.png","smile4.png","smilepressed.png","top_left.png","top_right.png","middle_left.png","middle_right.png","bottom_left.png","bottom_right.png","line_ver.png","line_hor.png"};
PImage[] images = new PImage[imageNames.length]; //def=0 flag=9 space=10 mine=11 red=12
int x = 0, y = 0, px, py;                        //smile1=13 s2=14 s3=15 s4=16 pressed=17 
boolean pressing = false;                        //top l18 r19 mid l20 r21 bot l22 r23 v-line24 h-line25
boolean gameend = false;
boolean mousein = false;
int msize = 40; //real size - 16 pixel
int ssize = msize*26/16; //size of smile - 26 pixel
int smile = 13; // mode of smile (13~17)
int outline = 20; // size of outline
int xnum = 10; //ez 10 inter 16 exp 30
int ynum = 10; //ez 10 inter 16 exp 16
int xadj = 20;
int yadj = 120;
int minenum = 10; //ez 10 inter 40 exp 99
int[][] array = new int[xnum][ynum];
int[][] m_array = new int[xnum][ynum];

void setup(){
  loop();
  clear();
  background(192,192,192);
  size(440,540); //ez 440,540 inter 680,780 exp 1240,780
  loadImages();
  drawOutline();
  reset();
}

void draw(){ //update
    drawGame(); //draw game
    mousePos(); //get position of mouse
    if(!gameend){
      click();  //click check
      open();   //reveal block
      status(); // check status - win/gameover
    }
    smile(); //smile - reset button
}

void smile(){ //reset button
  if((width/2)-(ssize/2)<mouseX&&mouseX<(width/2)+(ssize/2)&&(yadj/2)-(ssize/2)<mouseY&&mouseY<(yadj/2)+(ssize/2)){
    if(mousePressed){
      smile = 17 ;
      mousein = true;
    }else if(mousein){
      smile = 13;
      mousein = false;
      gameend = false;
      reset();
    }
  }else if(mousePressed && mousein){
    smile = 13;
    mousein = false;
  }
  image(images[smile],(width/2)-(ssize/2),(yadj/2)-(ssize/2),ssize,ssize); // draw smile
}

void drawGame(){ // draw mines
  int i,j;
  for(i=0;i<xnum;i++){ 
    for(j=0;j<ynum;j++){
      image(images[array[i][j]],i*msize+xadj,j*msize+yadj,msize,msize);
    }
  }
}

void drawOutline(){
  int i;
  for(i=0;i<xnum*2;i++){
    image(images[25],i*outline+xadj,0,outline,outline);
    image(images[25],i*outline+xadj,yadj-outline,outline,outline);
    image(images[25],i*outline+xadj,height-outline,outline,outline);
  }
  for(i=0;i<height/outline-2;i++){
    image(images[24],0,i*outline+outline,outline,outline);
    image(images[24],width-outline,i*outline+outline,outline,outline);
  }
  image(images[18],0,0,outline,outline);
  image(images[19],width-outline,0,outline,outline);
  image(images[20],0,yadj-outline,outline,outline);
  image(images[21],width-outline,yadj-outline,outline,outline);
  image(images[22],0,height-outline,outline,outline);
  image(images[23],width-outline,height-outline,outline,outline);
}

void reset(){
  int i,j;
  smile = 13;
  for(i=0;i<xnum;i++){ //reset array
    for(j=0;j<ynum;j++){
      array[i][j] = 0; //def
      image(images[0],i*msize+xadj,j*msize+yadj,msize,msize);
    }
  }
  for(i=0;i<xnum;i++){ //reset m_array
    for(j=0;j<ynum;j++){
      m_array[i][j] = 0; //0
    }
  }
  for(i=0;i<minenum;i++){ //set mine
    while(true){ //not to overlap mines
      x = int(random(0,xnum));
      y = int(random(0,xnum));
      if(m_array[x][y]!=11){
        m_array[x][y] = 11; //mine
        break;
      }
    }
    
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
          smile = 14;
          if(!pressing){ //if first click/ not pressed
            px=x; py=y;
            pressing = true; //pressed
          }
          if(px!=x||py!=y){ //if mouse is out of previous block
             array[px][py] = 0;
             px=x; py=y;
          }array[x][y] = 10;
        }
      }else{ //mouse right click
        if(!pressing){// if first click/ not pressed
          if(array[x][y]==0){// if def block --> flag
            array[x][y] = 9; 
          }else if(array[x][y]==9){ // if flag --> def block
            array[x][y] = 0;
          }pressing = true;
        }
      }
    }else{
      pressing = false; //not pressing
      smile = 13;
    }
  }
}

void open(){
  if(!pressing){
    if(array[x][y]==10){
      if(m_array[x][y]==11){//if mine pressed - gameover
        gameend = true;
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
      if(ix>=0&&ix<=xnum-1&&iy>=0&&iy<=ynum-1&&m_array[ix][iy]==11)check++; //if x,y is in limit & if mine
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
        if(ix>=0&&ix<=xnum-1&&iy>=0&&iy<=ynum-1&&m_array[ix][iy]!=1)search(ix,iy);
      }
    }
  }
}

void status(){
  int i,j;
  boolean win = true;
  for(i=0;i<xnum;i++){
    for(j=0;j<ynum;j++)
    {
      if(m_array[i][j]==0){
         win = false;
      }
    }
  }
  if(win){ //WIN!!!
    smile = 16;
    gameend = true;
  }else if(gameend){ //GAMEOVER :(
    smile = 15;
    for(i=0;i<xnum;i++){ //show position of all the mines
      for(j=0;j<ynum;j++){
        if(m_array[i][j]==11&&array[i][j]!=9){
          array[i][j]=11; 
        }
      }
    }
    array[px][py]=12; //change color of changed mine to red
  }
}

void loadImages(){
  int i;
  for(i=0; i < imageNames.length; i++){
    String imageName = imageNames[i];
    images[i] = loadImage(imageName);
  }
}
