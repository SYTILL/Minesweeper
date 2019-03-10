String[] imageNames = {"def.png","1.png","2.png","3.png","4.png","5.png","6.png","7.png","8.png","flag.png","space.png","mine.png","red.png","smile1.png","smile2.png","smile3.png","smile4.png","smilepressed.png" };
PImage[] images = new PImage[imageNames.length]; //def=0 flag=9 space=10 mine=11 red=12
int x = 0, y = 0, px, py;                        //smile1=13 s2=14 s3=15 s4=16 pressed=17
boolean gameover = false;
boolean pressing = false;
int msize = 40; //16

int xnum = 10;
int ynum = 10;
int xadj = 20;
int yadj = 120;
int[][] array = new int[xnum+2][ynum+2]; //0 is not 1, 1 is 1
int minenum = 10;

void setup(){
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
    gameover(); //check gameover
}

void drawMine(){
  int i,j;
  for(i=0;i<xnum;i++){ 
    for(j=0;j<ynum;j++){
      image(images[array[i+1][j+1]],i*msize+xadj,j*msize+yadj,msize,msize);
    }
  }
}

void reset(){
  int i,j;
  for(i=0;i<xnum;i++){ //reset with def
    for(j=0;j<ynum;j++){
      array[i+1][j+1] = 0; //def
      image(images[0],i*40+xadj,j*40+yadj,msize,msize);
    }
  }
  for(i=0;i<minenum;i++){ //set mine
    array[int(random(1,xnum))][int(random(1,ynum))] = 11; //mine
  }
}

void mousePos(){
  if(xadj<mouseX && xadj+xnum*msize>mouseX && yadj<mouseY && yadj+ynum*msize>mouseY){
    x = (mouseX-xadj)/msize+1;
    y = (mouseY-yadj)/msize+1;
  }
  delay(500);
  print("x:"+x+" y:"+y+'\n');
}

void click(){
  if(xadj<mouseX && xadj+xnum*msize>mouseX && yadj<mouseY && yadj+ynum*msize>mouseY){
    if(mousePressed == true){
      if(mouseButton == LEFT){ //mouse left click
        if(array[x][y]==0){ //only def block is click-able
          if(!pressing){ //if mouse is not pressed
            px=x; py=y;
            pressing = true; //pressed
          }
          if(px!=x||py!=y){ //if mouse is out of previous block
             array[px][py] = 0;
             print("----------");
             px=x; py=y;
          }
          array[x][y] = 10;
        }/*else if(array[x][y]==11){
          
        }*/
      }else{ //mouse right click
        
        
        
      }
    }else pressing = false; //not pressing
  }
}

void open(){
  int check=0,i,j;
  if(!pressing){
    if(array[x][y]==10){
      for(i=0;i<3;i++){ //search mine around clicked block
        for(j=0;j<3;j++){
           if(array[x-1+i][y-1+j]==11)check++;
        }
      }
    }
    array[x][y]=check;
  }
}


void gameover(){
  
}

void loadImages(){
  int i;
  for(i=0; i < imageNames.length; i++){
    String imageName = imageNames[i];
    images[i] = loadImage(imageName);
  }
}
