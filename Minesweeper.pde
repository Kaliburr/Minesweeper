import de.bezier.guido.*;
private final static int NUM_ROWS=20;
private final static int NUM_COLS=20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs=new ArrayList<MSButton>(); //ArrayList of just the minesweeper buttons that are mined
void setup ()
{
    size(500, 500);
    textAlign(CENTER,CENTER);
    // make the manager
    Interactive.make( this );
    buttons=new MSButton[NUM_ROWS][NUM_COLS]; 
   for(int r=0;r<20;r++){
    for(int c=0;c<20;c++){
        buttons[r][c]=new MSButton(r,c);
    }
   }
   for(int i=0;i<19;i++){
        setBombs();
    }
}
public void setBombs()
{
    int r=(int)(Math.random()*20);
    int c=(int)(Math.random()*20);
    if(!bombs.contains(buttons[r][c])){
        bombs.add(buttons[r][c]);
    }
    System.out.println(r+","+c);
}
public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    int dead=0;
    for(int i=0;i<bombs.size();i++){
        if(bombs.get(i).isMarked()){
            dead++;
        }
    }
    if(dead==bombs.size()){
        return true;
    }
    return false;
}
public void displayLosingMessage()
{
    noLoop();
    fill(123,31,13);
    text("YOU LOSE",200,450);
}
public void displayWinningMessage()
{
    fill(123,31,13);
    text("YOU WIN",200,450);
}
public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    public void mousePressed () 
    {
        clicked = true;
        if(keyPressed&&!label.contains(""+countBombs(r,c))){
            marked=!marked;
        }
        else if(bombs.contains(this)){
            displayLosingMessage();
        }
        else if(0<countBombs(r,c)){
            setLabel(""+countBombs(r,c));
        }
        else {
        if(isValid(r,c-1)&&buttons[r][c-1].clicked==false){
            buttons[r][c-1].mousePressed();
        }
        if(isValid(r,c+1)&&buttons[r][c+1].clicked==false){
            buttons[r][c+1].mousePressed();
        } 
        if(isValid(r-1,c)&&buttons[r-1][c].clicked==false){
            buttons[r-1][c].mousePressed();
        } 
        if(isValid(r+1,c)&&buttons[r+1][c].clicked==false){
            buttons[r+1][c].mousePressed();
        } 
        if(isValid(r-1,c-1)&&buttons[r-1][c-1].clicked==false){
            buttons[r-1][c-1].mousePressed();
        } 
        if(isValid(r-1,c+1)&&buttons[r-1][c+1].clicked==false){
            buttons[r-1][c+1].mousePressed();
        } 
        if(isValid(r+1,c-1)&&buttons[r+1][c-1].clicked==false){
            buttons[r+1][c-1].mousePressed();
        } 
        if(isValid(r+1,c+1)&&buttons[r+1][c+1].clicked==false){
            buttons[r+1][c+1].mousePressed();
        }
        }
    }

    public void draw () 
    {    
        if (marked)
            fill(194, 110, 110);
        else if( clicked && bombs.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        if(0<=r&&r<=19&&0<=c&&c<=19){
            return true;
        }
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        if(isValid(row,col-1)&&bombs.contains(buttons[row][col-1])){
            numBombs++;
        }
        if(isValid(row,col+1)&&bombs.contains(buttons[row][col+1])){
            numBombs++;
        }
        if(isValid(row-1,col)&&bombs.contains(buttons[row-1][col])){
            numBombs++;
        }
        if(isValid(row+1,col)&&bombs.contains(buttons[row+1][col])){
            numBombs++;
        }
        if(isValid(row-1,col-1)&&bombs.contains(buttons[row-1][col-1])){
            numBombs++;
        }
        if(isValid(row-1,col+1)&&bombs.contains(buttons[row-1][col+1])){
            numBombs++;
        }
        if(isValid(row+1,col-1)&&bombs.contains(buttons[row+1][col-1])){
            numBombs++;
        }
        if(isValid(row+1,col+1)&&bombs.contains(buttons[row+1][col+1])){
            numBombs++;
        }
        return numBombs;
    }
} 
