import java.util.Scanner;

/**
 * Program that allows two people to
 *  play Connect Four.
 */


public class ConnectFour {

	public static void main(String[] args) {
		Scanner keyboard = new Scanner(System.in); 
		intro();
		runProgram(keyboard);

	}



	//collects player names
	public static String playerNames(Scanner keyboard, int playerNum) {
		System.out.print("Player " + playerNum + " enter your name: ");
		String playerName = keyboard.nextLine();
		return playerName;
	}

	//run the program
	public static void runProgram(Scanner keyboard) {
		String playerOne = playerNames(keyboard, 1);
		System.out.println();
		String playerTwo = playerNames(keyboard, 2);
		String current = "Current Board";
		String finalB = "Final Board";
		String currentPlayer = "";
		System.out.println();
		String[][] grid = board();
		printBoard(grid, current);
		int roundCount = 0;
		boolean runGame = true;
		String prompt = "";  
		int fullBoard = grid.length * grid[0].length;

		while (runGame == true) {    
			//player takes there turn
			playerTurn(playerOne, keyboard, grid,roundCount, playerTwo, prompt);
			//for every turn count a round
			roundCount++;
			currentPlayer = currentPlayer(roundCount, playerOne, playerTwo);
			//if the game hits a Draw, runGame is false, else keep it true
			runGame = gameDraw(roundCount, runGame, grid, fullBoard);
			//checks for wins
			runGame = wins(runGame, grid, currentPlayer, roundCount, fullBoard);
			//print the current board
			if (runGame == true) {
				printBoard(grid, current);
			} else if (runGame == false) {
				printBoard(grid, finalB);
			}
		}   	
	}

	//creates the board
	public static String[][] board() {
		String [][] grid = new String [6] [7];
		for (int row = 0; row < 6; row ++) { 		
			for (int column = 0; column < 7; column ++) {
				grid[row][column] = ".";	    		
			}
		}
		return grid;
	}

	//prints the board
	public static void printBoard(String[][] grid, String board) {
		System.out.println(board);
		System.out.println("1 2 3 4 5 6 7  column numbers");
		for (int row = 0; row < 6; row ++) { 		
			for (int column = 0; column < 7; column ++) {
				System.out.print(grid[row][column]); 	
				System.out.print(" ");
			}	    	  		
			System.out.println(); 	
		}
	}

	//decides which players turn it is depending on the round number
	public static String player(String playerOne, String playerTwo, int roundCount, String prompt) {
		String playerOneToken = "r";
		String playerTwoToken = "b";
		if (roundCount % 2 == 0) {
			System.out.println();
			prompt= playerOne + ", enter the column to drop your checker: ";
			System.out.println(playerOne + " it is your turn.");
			System.out.println("Your pieces are the " + playerOneToken + "'s.");
		}else {
			System.out.println();
			prompt= playerTwo + ", enter the column to drop your checker: ";
			System.out.println(playerTwo + " it is your turn.");
			System.out.println("Your pieces are the " + playerTwoToken + "'s.");
		}	
		return prompt;
	}

	//asks player to do take a turn and determines if valid
	public static void playerTurn(String playerOne, Scanner keyboard, String[][] grid, 
			int roundCount, String playerTwo, String prompt) {
		int result = 0;
		prompt = player(playerOne, playerTwo, roundCount, prompt);
		boolean valid = false;    	   	
		while (valid == false) {   	
			System.out.print(prompt);
			//get the user input
			result = getInt(keyboard, prompt);
			//check if its a valid response
			valid = invalid(result, playerOne, keyboard, valid);	 
			//if the number is valid check of the column is full
			if (valid == true) {
				valid = fullColumn(result , grid, valid);	
			} 
		}  
		grid = placeToken(result, grid, roundCount);
	}

	// if the input from the player isnt a number for a column, it is invalid
	public static boolean invalid(int result, String playerOne, Scanner keyboard, boolean valid) {
		System.out.println();
		if (result > 7) {
			System.out.println(result + " is not a valid column.");
		} else if (result < 1) {
			System.out.println(result + " is not a valid column.");
		} else
			valid = true;
		return valid;
	}

	//place the token that the player inputs if the column is not full
	public static String[][] placeToken(int result , String[][] grid, int roundCount) {
		String playerOneToken = "r";
		String playerTwoToken = "b";
		String playerToken = "";
		boolean emptySpot = false;
		int rows = 5;
		int column = result - 1; //since an array starts at 0
		if (roundCount % 2 == 0) {
			playerToken = playerOneToken;
		}else {
			playerToken = playerTwoToken;
		}
		//if the spot has a . replace it, otherwise keep going through the loop
		while(emptySpot == false) {   	
			if ((grid[rows][column] == ".")) {
				grid[rows][column] = playerToken;
				emptySpot = true;
			} else if (!(grid[rows][column] == ".")){
				rows--;
			}
			if (rows == -1) {
				emptySpot = true;
			}   		
		}
		return grid;		
	}

	//check to see of the column is full
	public static boolean fullColumn(int result , String[][] grid, boolean valid) {
		int column = result - 1; //since an array starts at 0
		if (!(grid[0][column] == ".")) {
			System.out.println(result + " is not a legal column. That column is full");  
			valid = false;
		} else 
			valid = true;    	
		return valid;
	}

	//looks to see if the board is full for a Draw
	public static boolean gameDraw(int roundCount, boolean runGame, String[][]grid, int fullBoard){
		if (roundCount == fullBoard) {
			System.out.println("The game is a draw.");
			System.out.println();
			runGame = false;
		} else if (roundCount < 42) {
			runGame = true;
		}
		return runGame;
	}

	//looks for a verticle win
	public static boolean verticleWin(String [][] grid, boolean runGame, String currentPlayer) { 	
		for (int row = 0; row < grid.length - 3; row ++) { 
			for (int column = 0; column < grid.length; column ++) { 
				if (!(grid[row][column] == ".") &&
						grid[row][column] == grid [row + 1][column] &&
						grid[row][column] == grid [row + 2][column] &&
						grid[row][column] == grid [row + 3][column]) {
					runGame = false;
				} 
			}
		} 

		return runGame;

	}

	//looks for a horizontal win
	public static boolean horizontalWin(String [][] grid, boolean runGame, String currentPlayer) { 	
		for (int row = 0; row < grid.length; row ++) { 
			for (int column = 0; column < grid.length - 3; column ++) { 
				if (!(grid[row][column] == ".") &&
						grid[row][column] == grid [row][column + 1] &&
						grid[row][column] == grid [row][column + 2] &&
						grid[row][column] == grid [row][column + 3]) {
					runGame = false;
				} 
			}
		}   	
		return runGame;   	
	}

	//looks for a diagonal going down
	public static boolean diagonalOneWin(String [][] grid, boolean runGame, String currentPlayer) { 	
		for (int row = 0; row < grid.length - 3; row ++) { 
			for (int column = 0; column < grid[row].length - 3; column ++) { 
				if (!(grid[row][column] == ".") &&
						grid[row][column] == grid [row + 1][column + 1] &&
						grid[row][column] == grid [row + 2][column + 2] &&
						grid[row][column] == grid [row + 3][column + 3]) {
					runGame = false;
				} 
			}
		}   	
		return runGame;   	
	}

	//looks for a diagonal going up
	public static boolean diagonalTwoWin(String [][] grid, boolean runGame, String currentPlayer) { 	
		for (int row = 3; row < grid.length; row ++) { 
			for (int column = 0; column < grid[row].length - 3; column ++) { 
				if (!(grid[row][column] == ".") &&
						grid[row][column] == grid [row - 1][column + 1] &&
						grid[row][column] == grid [row - 2][column + 2] &&
						grid[row][column] == grid [row - 3][column + 3]) {
					runGame = false;
				} 
			}
		}   	
		return runGame;   	
	}

	//looks to see whos the current player
	public static String currentPlayer(int roundCount, String playerOne, String playerTwo) {
		String currentPlayer = "";   	
		if (!((roundCount % 2) == 0)) {
			currentPlayer = playerOne;
		}else {
			currentPlayer = playerTwo;
		}
		return currentPlayer;

	}

	//looks for an of the four wins
	public static boolean wins(boolean runGame, String [][]grid, String currentPlayer, int roundCount, int fullBoard) {
		runGame = verticleWin(grid, runGame, currentPlayer);
		runGame = horizontalWin(grid, runGame, currentPlayer);
		runGame = diagonalOneWin(grid, runGame, currentPlayer);
		runGame = diagonalTwoWin(grid, runGame, currentPlayer);
		if (runGame == false && !(roundCount == fullBoard )) {
			System.out.println(currentPlayer + " wins!!");
			System.out.println();			
		}
		return runGame;
	}

	// Show the introduction.
	public static void intro() {
		System.out.println("This program allows two people to play the");
		System.out.println("game of Connect four. Each player takes turns");
		System.out.println("dropping a checker in one of the open columns");
		System.out.println("on the board. The columns are numbered 1 to 7.");
		System.out.println("The first player to get four checkers in a row");
		System.out.println("horizontally, vertically, or diagonally wins");
		System.out.println("the game. If no player gets fours in a row and");
		System.out.println("and all spots are taken the game is a draw.");
		System.out.println("Player one's checkers will appear as r's and");
		System.out.println("player two's checkers will appear as b's.");
		System.out.println("Open spaces on the board will appear as .'s.\n");
	}


	// Prompt the user for an int. The String prompt will
	// be printed out. key must be connected to System.in.
	public static int getInt(Scanner key, String prompt) {
		while(!key.hasNextInt()) {
			String notAnInt = key.nextLine();
			System.out.println();
			System.out.println(notAnInt + " is not an integer.");
			System.out.print(prompt);
		}
		int result = key.nextInt();
		key.nextLine();
		return result;
	}
}