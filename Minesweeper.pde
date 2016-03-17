

import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs; //ArrayList of just the minesweeper buttons that are mined
boolean loseG = false;
boolean winG = false;
void setup ()
{
    size(400, 500);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to declare and initialize buttons goes here
    bombs = new ArrayList <MSButton> ();

    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int y = 0; y < 20; y++)
        for(int x = 0; x < 20; x++)
        {
            buttons[x][y] = new MSButton(x,y);
        }
    
    
    setBombs();
}
public void setBombs()
{
    int randRow = (int)(Math.random() * 20);
    int randCol = (int)(Math.random() * 20);
    //your code

    for(int i = 0; i < 50; i ++)
     if(!bombs.contains(buttons[randRow][randCol]))
        bombs.add(buttons[(int)(Math.random() * 20)][(int)(Math.random() * 20)]);
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    int win = 0;
     for(int i = 0; i < bombs.size(); i++)
        if(bombs.get(i).isMarked()){
           win++;
            if(win == bombs.size())
            return true; 
        }
            
    return false;
}
public void displayLosingMessage()
{
    textSize(20);

    fill(197);
    if(winG == false){
        text("You Lose", 200, 450);
     for(int i = 0; i < bombs.size(); i++)
        bombs.get(i).mousePressed();
    }
    else
        text("Don't Cheat", 200, 450);
     

    

    textSize(10); 

}
public void displayWinningMessage()
{
    //your code here
    winG = true;
    fill(197);
    textSize(20);
    if(loseG == false)
    text("YOU WIN", 200, 450);



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
        //your code here
            /*
            if(keyPressed && marked == true)
            {
                marked = false;
            }
            else if(keyPressed && marked == false)
            {
                marked = true;
            
            }
            */
            if(keyPressed)
                marked = !marked;
            
            else if(bombs.contains(this))
                loseG = true;
            

            else if(this.countBombs(r,c) > 0)
            {
                int num = countBombs(r,c);
                this.setLabel("" + num);
            }
            else //if(clicked == true)
            {
                marked = false;
                
                if(isValid(r,c-1) && buttons[r][c-1].isClicked() == false)
                     buttons[r][c-1].mousePressed();
                
               if(isValid(r,c+1) && buttons[r][c+1].isClicked() == false)
                    buttons[r][c+1].mousePressed();

                if(isValid(r-1,c) && buttons[r-1][c].isClicked() == false)
                    buttons[r-1][c].mousePressed(); 
                
                if(isValid(r+1,c) && buttons[r+1][c].isClicked() == false)
                    buttons[r+1][c].mousePressed();

                if(isValid(r-1,c-1) && buttons[r-1][c-1].isClicked() == false)
                    buttons[r-1][c-1].mousePressed();
                
                if(isValid(r-1,c+1) && buttons[r-1][c+1].isClicked() == false)
                    buttons[r-1][c+1].mousePressed();

                if(isValid(r+1,c-1) && buttons[r+1][c-1].isClicked() == false)
                    buttons[r+1][c-1].mousePressed();

                if(isValid(r+1,c+1) && buttons[r+1][c+1].isClicked() == false)
                    buttons[r+1][c+1].mousePressed();
                
            }
            
            /*

        if(clicked == true)
        {
            marked = false;
            if(isValid(r,c-1)) //&& buttons[r][c-1].isMarked())
                buttons[r][c-1].mousePressed();
            if(isValid(r,c+1)) //&& buttons[r][c+1].isMarked())
                buttons[r][c+1].mousePressed();
            if(isValid(r+1,c)) //&& buttons[r+1][c].isMarked())
                buttons[r+1][c].mousePressed();
            if(isValid(r-1,c)) //&& buttons[r-1][c].isMarked())
                buttons[r-1][c].mousePressed();
        }
          */
        

        
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
        if(loseG == true)
            displayLosingMessage();
       
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        //your code here
        if(r > -1 && r < 20 && c > -1 && c < 20)
            return true;
        else
            return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        /*
        //your code here
        if(buttons[r][c+1].isValid(r,c+1) && bombs.contains(buttons[r][c+1]))
            numBombs++;
        if(buttons[r][c-1].isValid(r,c-1) && bombs.contains(buttons[r][c-1]))
            numBombs++;
        if(buttons[r+1][c].isValid(r+1,c) && bombs.contains(buttons[r+1][c]))
            numBombs++;
        if(buttons[r-1][c].isValid(r-1,c) && bombs.contains(buttons[r-1][c]))
            numBombs++;
        if(buttons[r+1][c+1].isValid(r+1,c+1) && bombs.contains(buttons[r+1][c+1]))
            numBombs++;
        if(buttons[r-1][c-1].isValid(r-1,c-1) && bombs.contains(buttons[r-1][c-1]))
            numBombs++;
        if(buttons[r+1][c-1].isValid(r+1,c-1) && bombs.contains(buttons[r+1][c-1]))
            numBombs++;
        if(buttons[r-1][c+1].isValid(r-1,c+1) && bombs.contains(buttons[r-1][c+1]))
            numBombs++;
        */
         if(this.isValid(r,c+1) && bombs.contains(buttons[r][c+1]))
            numBombs++;
        if(this.isValid(r,c-1) && bombs.contains(buttons[r][c-1]))
            numBombs++;
        if(this.isValid(r+1,c) && bombs.contains(buttons[r+1][c]))
            numBombs++;
        if(this.isValid(r-1,c) && bombs.contains(buttons[r-1][c]))
            numBombs++;
        if(this.isValid(r+1,c+1) && bombs.contains(buttons[r+1][c+1]))
            numBombs++;
        if(this.isValid(r-1,c-1) && bombs.contains(buttons[r-1][c-1]))
            numBombs++;
        if(this.isValid(r+1,c-1) && bombs.contains(buttons[r+1][c-1]))
            numBombs++;
        if(this.isValid(r-1,c+1) && bombs.contains(buttons[r-1][c+1]))
            numBombs++;
        

        return numBombs;
    }
}



