

import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs; //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to declare and initialize buttons goes here
    bombs = new ArrayList <MSButton> ();

    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int y = 0; y < 20; y += 1)
        for(int x = 0; x < 20; x += 1)
        {
            buttons[x][y] = new MSButton(x,y);
        }
    
    
    setBombs();
}
public void setBombs()
{
    int randRow = (int)(Math.random() * 21);
    int randCol = (int)(Math.random() * 21);
    //your code

    for(int i = 0; i < 100; i ++)
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
    //your code here

    return false;
}
public void displayLosingMessage()
{
    fill(197);
    ellipse(200, 200, 200, 200);
}
public void displayWinningMessage()
{
    //your code here

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
            if(keyPressed && marked == true)
            {
                marked = false;
            }
            else if(keyPressed && marked == false)
            {
                marked = true;
            
            }
            if(bombs.contains(this))
                displayLosingMessage();
            else if(this.countBombs(r,c) > 0)
            {
                int num = countBombs(r,c);
                this.setLabel("" + num);
            }
            if(marked == true)
            {
                marked = false;
                if(isValid(r,c-1) && clicked == false )
                    buttons[r][c-1].mousePressed();
            }
            /*
        else if(marked == true)
        {
            marked = false;
            if(isValid(r,c-1) && buttons[r][c-1].isMarked())
                buttons[r][c-1].mousePressed();
            if(isValid(r,c+1) && buttons[r][c+1].isMarked())
                buttons[r][c+1].mousePressed();
            if(isValid(r+1,c) && buttons[r+1][c].isMarked())
                buttons[r+1][c].mousePressed();
            if(isValid(r-1,c) && buttons[r-1][c].isMarked())
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
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        //your code here
        if(r >= 0 && r < 20 && c >=0 && c < 20)
            return true;
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
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
        

        return numBombs;
    }
}



