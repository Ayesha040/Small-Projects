import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Scanner;

/**


 * Analysis of results
FILE: wbb08s.txt
Total number of games: 14
Number of games with a home team: 9
Percentage of games with a home team: 64.3%
Number of games the home team won: 6
Home team win percentage: 66.7%
Home team average margin: 6.00

FILE: cfb05.txt
Total number of games: 4,069
Number of games with a home team: 3,955
Percentage of games with a home team: 97.2%
Number of games the home team won: 2,257
Home team win percentage: 57.1%
Home team average margin: 4.24

FILE: cfb08.txt
Total number of games: 4,702
Number of games with a home team: 4,592
Percentage of games with a home team: 97.7%
Number of games the home team won: 2,617
Home team win percentage: 57.0%
Home team average margin: 4.28

FILE: mbb12.txt
Total number of games: 15,842
Number of games with a home team: 14,481
Percentage of games with a home team: 91.4%
Number of games the home team won: 9,178
Home team win percentage: 63.4%
Home team average margin: 5.37

FILE: mbb14.txt
Total number of games: 16,219
Number of games with a home team: 14,754
Percentage of games with a home team: 91.0%
Number of games the home team won: 9,276
Home team win percentage: 62.9%
Home team average margin: 5.18

FILE: mbb12_r.txt
Total number of games: 15,842
Number of games with a home team: 14,481
Percentage of games with a home team: 91.4%
Number of games the home team won: 9,178
Home team win percentage: 63.4%
Home team average margin: 5.37

FILE: mlb12.txt
Total number of games: 2,467
Number of games with a home team: 2,465
Percentage of games with a home team: 99.9%
Number of games the home team won: 1,312
Home team win percentage: 53.2%
Home team average margin: 0.16

FILE: mscc06.txt
Total number of games: 8,380
Number of games with a home team: 7,373
Percentage of games with a home team: 88.0%
Number of games the home team won: 3,962
Home team win percentage: 53.7%
Home team average margin: 0.51

FILE: wbb00.txt
Total number of games: 4,607
Number of games with a home team: 4,345
Percentage of games with a home team: 94.3%
Number of games the home team won: 2,696
Home team win percentage: 62.0%
Home team average margin: 5.60

FILE: wbb05.txt
Total number of games: 14,687
Number of games with a home team: 13,261
Percentage of games with a home team: 90.3%
Number of games the home team won: 8,043
Home team win percentage: 60.7%
Home team average margin: 4.95

FILE: wbb14.txt
Total number of games: 15,790
Number of games with a home team: 14,305
Percentage of games with a home team: 90.6%
Number of games the home team won: 8,471
Home team win percentage: 59.2%
Home team average margin: 4.24

FILE: wbb12.txt
Total number of games: 15,640
Number of games with a home team: 14,303
Percentage of games with a home team: 91.5%
Number of games the home team won: 8,496
Home team win percentage: 59.4%
Home team average margin: 4.41

FILE: wbb13.txt
Total number of games: 15,722
Number of games with a home team: 14,341
Percentage of games with a home team: 91.2%
Number of games the home team won: 8,512
Home team win percentage: 59.4%
Home team average margin: 4.23

FILE: wscc10.txt
Total number of games: 10,593
Number of games with a home team: 9,941
Percentage of games with a home team: 93.8%
Number of games the home team won: 5,392
Home team win percentage: 54.2%
Home team average margin: 0.51

 	Home field advantage is  the benefit that a home team has over the visiting team due to the 
 familiar environment in which they are playing on. This can be seen through the data that Professor 
 Ken Massey has collected and how the code analyzes it. When looking at the total number of games and 
 the number of games with a home team playing, you can see a correlation. 
 	The closer that the number of games with a home team playing is to the total number of games, the
 greater the home team win percentage. This is because the more games that are played at home, the
 more chance the home team has at winning the game. 
 	Another correlation that can be seen in this data collection is that as the team winning 
 percentage increases, so does the average margin. When the team percentage is in the fifty percent
 range, the average margin is less than one.
 	Lastly, no matter how many games have been played or won, all of the home team win percentages
 are in the range of fifty to sixty percent, so no matter how many games are played its on the higher 
 end of having a chance at winning.
 */

public class HomeField {

	// Ask the user for the name of a data file and process
	// it until they want to quit.
	public static void main(String[] args) throws IOException {
		System.out.println("A program to analyze home field advantage in sports.");
		System.out.println();
		// CS312 students. Do not create any other Scanners connected to System.in.
		// Pass keyboard as a parameter to all the methods that need it. 
		Scanner keyboard = new Scanner(System.in);       
		//file data

		//if the file name is found run the analysis
		runProgram(keyboard);

		keyboard.close();
	}


	//run program is user says Y or y
	public static void runProgram(Scanner keyboard) throws FileNotFoundException {
		boolean analyzeData = true;

		//while user still wants to analyze data, keep going
		while (analyzeData) { 		
			boolean fileNameEqual = true;
			int gameCount = 0;
			int homegameCount = 0;	
			int homeTeamScore = 0;
			int otherTeamScore = 0;
			int homeWin = 0;
			double homeSum = 0;
			double otherSum = 0;        		

			//if file name does NOT equal an existing file
			while (fileNameEqual) {    		
				System.out.print("Enter the file name: ");
				String fileName = keyboard.nextLine();
				File theInputFile = new File(fileName);	

				//if the file name that the user inputs does not exist send message
				if (!theInputFile.exists()) {
					System.out.println("Sorry, that file does not exist");
				}
				//if the file name does exist, begin to analyze
				else if (theInputFile.exists()){ 
					fileNameEqual = false;
					Scanner fileScanner = new Scanner(theInputFile);
					//prints the name and date of the game
					introGame (fileScanner, gameCount);
					//calculates all the data
					runningTheAnalysis (fileScanner, gameCount, homegameCount, theInputFile, 
							homeTeamScore, otherTeamScore, homeWin, homeSum, otherSum);   			
				}        		
			}     	
			//asks to analyze another file
			System.out.println();
			System.out.println("Do you want to check another data set?");
			System.out.print("Enter Y or y to analyze another file, anything else to quit: ");
			String anotherFile = keyboard.nextLine();
			String inputY = anotherFile.toUpperCase();
			String yes = "Y";
			//if the user input it not th
			if (!(inputY.equals(yes))) {
				analyzeData = false;   			
			}
			System.out.println();
		}    
	}

	//prints the input for the game it is analyzing
	public static void introGame (Scanner fileScanner, int gameCount) {
		System.out.println();
		System.out.print("**********   ");
		System.out.print(fileScanner.nextLine()); //name of game
		System.out.print(" --- ");
		System.out.print(fileScanner.next());
		System.out.print( fileScanner.nextLine() + ""); //dates
		System.out.println("   **********");
		System.out.println();
		System.out.println("HOME FIELD ADVANTAGE RESULTS");
		System.out.println();
	}

	//running the analysis of at home games, total games, percentage of home games, home wins
	public static void runningTheAnalysis(Scanner fileScanner, int gameCount, int homegameCount, 
			File theInputFile, int homeTeamScore, int otherTeamScore, int homeWin, double homeSum, 
			double otherSum) {
		//while the file still has lines, keep going
		String line = "";
		String atHome = "@";
		int totalHomeWins = 0;

		while (fileScanner.hasNextLine()) {  					
			//for every line count +1 for the number of games played	
			gameCount += 1;   	
			line = fileScanner.nextLine();
			Scanner lineScanner = new Scanner (line); //looks at the individual line

			//if the line has @, + 1
			if (line.indexOf(atHome) != -1) {
				homegameCount += 1;
			}

			//this section counts the amount of home team scores and other team scores
			lineScanner.next();	//skips over the date   	     		 
			String teamName = "";	//right side of the data

			//while the scanner is not at an int, go to the next until you find an int		  
			while (!lineScanner.hasNextInt()) {
				teamName += lineScanner.next();	  	  
			}
			//if there is an @ the int belongs to a home game
			if (teamName.contains(atHome)) {
				homeTeamScore = lineScanner.nextInt();
				homeSum += homeTeamScore;

			} else if (line.contains(atHome)){
				otherTeamScore = lineScanner.nextInt();
				otherSum += otherTeamScore;
			}

			String secondTeamName = "";	//left side of the data

			//while the scanner is not at an int, go to the next until you find an int
			while (!lineScanner.hasNextInt()) {
				secondTeamName += lineScanner.next();	  	  
			}
			//if there is an @ the int belongs to a home game	
			if (secondTeamName.contains(atHome)) {
				homeTeamScore = lineScanner.nextInt();
				homeSum += homeTeamScore;
			} else if (line.contains(atHome)) {
				otherTeamScore = lineScanner.nextInt();
				otherSum += otherTeamScore;
			}

			//if the score is not negative +1 to home wins total
			if (line.contains(atHome)) {
				int difference = homeTeamScore - otherTeamScore;
				if(difference > 0 ) {
					totalHomeWins += 1;		   			
				}
			}	   	   		  
		}	 

		double homegameC = homegameCount;
		double gameC = gameCount;
		double homeGamePercentage = ((homegameC * 100) / gameC);
		double totalHomeWinsD = totalHomeWins;
		double homegameCountC = homegameCount;
		double homeGameWinsPercentage = ((totalHomeWinsD * 100) / homegameCountC);	   
		double averageMargin= ((homeSum-otherSum) / homegameCount);

		System.out.printf("Total number of games: %,d",gameCount);
		System.out.println();
		System.out.printf("Number of games with a home team: %,d",homegameCount);
		System.out.println();
		System.out.printf("Percentage of games with a home team: %2.1f", homeGamePercentage);
		System.out.print("%");
		System.out.println();
		System.out.printf("Number of games the home team won: %,d",totalHomeWins);
		System.out.println();
		System.out.printf("Home team win percentage: %2.1f", homeGameWinsPercentage);
		System.out.print("%");
		System.out.println();
		System.out.printf("Home team average margin: %2.2f",averageMargin);
		System.out.println();	   
	}
}
