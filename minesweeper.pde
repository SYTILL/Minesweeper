String[] imageNames = {"def.png","1.png","2.png","3.png","4.png","5.png","6.png","7.png","8.png","flag.png","space.png","mine.png","red.png" };
PImage[] images = new PImage[imageNames.length]; //def=0 flag=9 mine=10 space=11 red=12
float x = 0, y = 0;
boolean gameover = false;
int msize = 40;
int xnum = 10;
int ynum = 10;
int xadj = 20;
int yadj = 120;
int[][] array = new int[xnum+2][ynum+2]; //0 is not 1, 1 is 1
int minenum = 10;

void setup(){
  size(440,560);
  noSmooth();
  loadImages();
  reset();
}

void draw(){
  game();
  reset();
}

void game(){
  while(!gameover){
    mousePos();
    click();
  }
}

void drawMine(){
   
}

void reset(){
  int i,j;
  for(i=0;i<xnum;i++){ //reset with def
    for(j=0;j<ynum;j++){
      array[i][j] = 0; //def
      //image(images[array[i][j]],i*40+xadj,j*40+yadj,msize,msize);
    }
  }
  for(i=0;i<minenum;i++){ //set mine
    array[int(random(1,10))][int(random(1,10))] = 10; //mine
  }
}

void mousePos(){
  //clear();
  //textSize(32);
  
  float x = 0, y = 0;
  x = (mouseX-xadj)/msize+1;
  y = (mouseY-yadj)/msize+1;
  
  //text("x="+x+" y="+y,32,32);
  //text("x="+mouseX+" y="+mouseY,32,80);
}

void click(){
   if(mousePressed == true){
     array[] 
   }
}







void loadImages(){
  int i;
  for(i=0; i < imageNames.length; i++){
    String imageName = imageNames[i];
    images[i] = loadImage(imageName);
  }
}
