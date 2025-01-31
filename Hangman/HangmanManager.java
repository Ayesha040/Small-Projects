
import java.util.*;

/**
 * Manages the details of EvilHangman. This class keeps
 * tracks of the possible words from a dictionary during
 * rounds of hangman, based on guesses so far.

 */

public class HangmanManager {


	// instance variables / fields
	private Set<String> allWords; //all the given words in the file
	private Set<String> currentList; //list of words with the right length
	private int wrongGuesses;
	private Set<String> guessedLetters; //store guessed letters
	private Set<String> patternList; //list of words with the right length
	private TreeMap<String, Set<String>> groupFams; //map of the pattern with count
	private TreeMap<String, Integer> bestFam; //makes a map of the families and their count
	private char currentLetterGuess; //saves the most recent guess
	private String currentPattern; //the active pattern
	private String finalAnswer; //the final answer
	private String difficulty; //the difficulty input by user
	private int roundNumber; //count what round its on


	/**
	 * Create a new HangmanManager from the provided set of words and phrases.
	 * pre: words != null, words.size() > 0
	 * @param words A set with the words for this instance of Hangman.
	 * @param debugOn true if we should print out debugging to System. out.
	 */
	public HangmanManager(Set<String> words, boolean debugOn) {
		allWords = words; //set the current list (which is a Set<String>) to all the given words
		currentList = new TreeSet<>();
		patternList = new TreeSet<>();
		guessedLetters = new TreeSet<>();
		groupFams = new TreeMap<>();
		bestFam = new TreeMap<>();
		currentLetterGuess = ' ';
		currentPattern = "";
		finalAnswer = "";
		difficulty = "";
		roundNumber = 0;
	}


	/**
	 * Create a new HangmanManager from the provided set of words and phrases.
	 * Debugging is off.
	 * pre: words != null, words.size() > 0
	 * @param words A set with the words for this instance of Hangman.
	 */
	public HangmanManager(Set<String> words) {
		//inistating all the variables
		allWords = words; //set the current list (which is a Set<String>) to all the given words
		currentList = new TreeSet<>();
		patternList = new TreeSet<>();
		guessedLetters = new TreeSet<>();
		groupFams = new TreeMap<>();
		bestFam = new TreeMap<>();
		currentLetterGuess = ' ';
		currentPattern = "";
		finalAnswer = "";
		difficulty = "";
		roundNumber = 1;
	}


	/**
	 * Get the number of words in this HangmanManager of the given length.
	 * pre: none
	 * @param length The given length to check.
	 * @return the number of words in the original Dictionary
	 * with the given length
	 */
	public int numWords(int length) {
		int wordsWithLength = 0; //count of words with the given length
		//look at every string element in the set
		for (String currentWord : allWords) {
			//if the current word has the given length, increment it
			if (currentWord.length() == length) {
				wordsWithLength ++;							
			}
		}
		return wordsWithLength;
	}


	/**
	 * Get for a new round of Hangman. Think of a round as a
	 * complete game of Hangman.
	 * @param wordLen the length of the word to pick this time.
	 * numWords(wordLen) > 0
	 * @param numGuesses the number of wrong guesses before the
	 * player loses the round. numGuesses >= 1
	 * @param diff The difficulty for this round.
	 */
	public void prepForRound(int wordLen, int numGuesses, HangmanDifficulty diff) {
		resetGameState();//reset
		// Set difficulty
		difficulty = diff.toString();
		// Add to the set of words with correct lengths
		for (String currentWord : allWords) {
			if (currentWord.length() == wordLen) {
				currentList.add(currentWord);
			}	
		}
		//Set wrongGuesses to the user's input of numGuesses
		wrongGuesses = numGuesses;
		//Create initial  pattern
		StringBuilder pattern = new StringBuilder();
		for(int i = 0; i < wordLen; i++) {
			pattern.append("-");
		}
		currentPattern = pattern.toString();
	}

	/**
	 * Resets all Game state variables
	 */
	private void resetGameState() {
		currentList = new TreeSet<>();
		patternList = new TreeSet<>();
		guessedLetters = new TreeSet<>();
		groupFams = new TreeMap<>();
		bestFam = new TreeMap<>();
		currentLetterGuess = ' ';
		currentPattern = "";
		finalAnswer = "";
		difficulty = " ";
		roundNumber = 1;
	}


	/**
	 * The number of words still possible (live) based on the guesses so far.
	 *  Guesses will eliminate possible words.
	 * @return the number of words that are still possibilities based on the
	 * original dictionary and the guesses so far.
	 */
	public int numWordsCurrent() {
		return currentList.size() ;
	}


	/**
	 * Get the number of wrong guesses the user has left in
	 * this round (game) of Hangman.
	 * @return the number of wrong guesses the user has left
	 * in this round (game) of Hangman.
	 */
	public int getGuessesLeft() {
		return wrongGuesses;
	}


	/**
	 * Return a String that contains the letters the user has guessed
	 * so far during this round.
	 * The characters in the String are in alphabetical order.
	 * The String is in the form [let1, let2, let3, ... letN].
	 * For example [a, c, e, s, t, z]
	 * @return a String that contains the letters the user
	 * has guessed so far during this round.
	 */
	public String getGuessesMade() {
		return guessedLetters.toString();
	}


	/**
	 * Check the status of a character.
	 * @param guess The characater to check.
	 * @return true if guess has been used or guessed this round of Hangman,
	 * false otherwise.
	 */
	public boolean alreadyGuessed(char guess) {
		if (guessedLetters.contains(Character.toString(guess))) {
			return true;
		}
		return false;
	}


	/**
	 * turn the current word into a pattern of dashes 
	 * @return a string of the pattern
	 */
	private String makePattern(String word){
		//create a string for the pattern
		StringBuilder pattern = new StringBuilder();
		//go through the charcaters of the word
		for (int i = 0; i < word.length(); i++) {
			//ch is the current letter we are looking at for word
			char ch = word.charAt(i);
			String s = "" + ch;
			//if the guessed letters has a letter in the current word, show the letter
			if (guessedLetters.contains(s)) {
				pattern.append(s);
			} else { //otherwise show a -
				pattern.append("-");
			}           
		}
		return pattern.toString();

	}

	/**
	 * Iterates of the currentList of words and creates the dashed pattern for each word
	 * adds patterns to patternList
	 */
	private void savePattern(){
		for (String word : currentList) {
			patternList.add(makePattern(word));
		}
	}
	/**
	 * Get the current pattern. The pattern contains '-''s for
	 * unrevealed (or guessed) characters and the actual character 
	 * for "correctly guessed" characters.
	 * @return the current pattern.
	 */
	public String getPattern() {
		return currentPattern;
	}


	/**
	 * updating the most curent list based on difficultly
	 * saves final answers when theres only one familt left
	 */
	private void updateCurrentList() {
		int greatestNumWordsInList = 0;
		int secondGreatest = 0;
		//Return initial pattern if no guesses have been made
		if( guessedLetters.size() == 0 ) {
			return;
		}
		// Updates current pattern based on difficulty
		selectNewCurrentPattern(greatestNumWordsInList, secondGreatest);
		//Update currentList to be the list of the new currentPattern
		currentList = groupFams.get(currentPattern);
		// If the list size is 1, then we have a final answer.
		if (currentList.size() == 1){
			Object[] arr = currentList.toArray();
			finalAnswer = (String) arr[0];
		}
	}

	/**
	 * @param greatestNumWordsInList = 0
	 * @param secondGreatest = 0
	 * Computes largest and second largest list of words and
	 * updates new currentPattern based on difficulty
	 */
	private void selectNewCurrentPattern(int greatestNumWordsInList, int secondGreatest) {
		String secondGreatestKey = "";
		for (String key : groupFams.keySet()) {
			Set<String> listWords = groupFams.get(key);
			// Iterate over the list of words and find those that do not contain the guessed letter
			//, keep track of the list size.
			greatestNumWordsInList = getNumberOfWordsWithoutGuessedLetter(greatestNumWordsInList, 
					listWords);

			//compares and saves the largest list size and key based on size - the key with largest 
			//size is used as current pattern
			if (listWords.size() > greatestNumWordsInList) {
				secondGreatest = greatestNumWordsInList;
				greatestNumWordsInList = listWords.size();
				currentPattern = key;
			}
			// If the largest size list is greater than the second largest list size and the list 
			//of words is not equal to the largest list size and less than the second largest.
			// Save the second largest size and key.
			if (listWords.size() > secondGreatest && listWords.size() != greatestNumWordsInList) {
				secondGreatest = listWords.size();
				secondGreatestKey = key;
				secondGreatest = listWords.size();
			}
			// Resolve clashes of lists with the same size.
			lexicographicallyChoose(greatestNumWordsInList, key, listWords);
			// Updates currentPattern based on difficulty and round number
			selectNewPatternbasedOnDifficulty(secondGreatestKey);
		}
	}

	/**
	 * @param greatestNumWordsInList = "0"
	 * @param listWords = list of words associated to any given pattern = ["fret, "bret"]
	 * @return the count of words in list without the guessed letter
	 */
	private int getNumberOfWordsWithoutGuessedLetter(int greatestNumWordsInList, Set<String> 
	listWords) {
		for (String word : listWords) {
			if (!word.contains(Character.toString(currentLetterGuess))) {
				greatestNumWordsInList++;
			}
		}
		return greatestNumWordsInList;
	}


	/**
	 * @param greatestNumWordsInList = largest list size found = "2"
	 * @param key = pattern being checked = "--e-"
	 * @param listWords = list of words associated to pattern 'key'   = ["fret, "bret"]
	 * If the listWords is equal to the greatestNumWordsInList,
	 * then   we choose currentPattern lexicographically
	 */
	private void lexicographicallyChoose(int greatestNumWordsInList, String key,
			Set<String> listWords) {
		if(!key.contains(Character.toString(currentLetterGuess))) {
			if(listWords.size() == greatestNumWordsInList){
				if (currentPattern.compareTo(key) < 0) {
					currentPattern = key;
				}
			}
		}
	}


	/**
	 * This methods keeps selects the new word list and patter to play
	 * based on difficulty.
	 * @param secondGreatestKey = "---e-"
	 * If difficulty="MEIDUM" we choose the second largest list of words every 3 rounds
	 * If difficulty="EASY" we choose the second largest list of words every 2 rounds
	 */
	private void selectNewPatternbasedOnDifficulty(String secondGreatestKey) {
		// Return if we do not have a second largest group
		if(secondGreatestKey.equals("")){
			return;
		}

		// Set current pattern based on difficulty. Every 4 rounds we choose the pattern with 
		//second largest list size if we have one.
		if (difficulty.equals("MEDIUM") && roundNumber % 4 == 0) {
			currentPattern = secondGreatestKey;
		}
		// Every 2 rounds we choose the pattern with second largest list size if we have one.
		if (difficulty.equals("EASY") && roundNumber % 2 == 0) {
			currentPattern = secondGreatestKey;
		}
	}

	/**
	 * This methods keeps track of the patterns at play
	 * based on the number of words for each pattern.
	 * PatternList  ["---e-", "----"]
	 * CountWordsInFamily checks groupFam which contains data like:
	 * {key="--e-"value=["fret","pres"]}, {key="----",value=["frat","prat"]}
	 * Then bestFam should contain key= "--e-" value = 2
	 */
	private void addToFam(){
		//go through all the words in the pattern
		for(String pattern: patternList) {
			//if the pattern exists, add to its count
			int countWords = countWordsInFamily(pattern);
			if (countWords > 0) {
				bestFam.put(pattern, countWords);
			} else{
				bestFam.remove(pattern);
			}
		}
	}


	/**
	 * Generates the next set of patterns and their matching list
	 * of words from the currentList of words.
	 * CurrenLisr contains  ["fret", "pres"]
	 *  Assuming "e" is the guessed letter, then
	 * Groupfams should contain key= "--e-" value = ["fret", "pres"]
	 */
	private void groupMatches() {
		TreeMap<String, Set<String>> newMatches = new TreeMap<>();
		// Iterate over the currentList of words and create new patterns with their list of words
		for(String word: currentList) {
			if(!newMatches.containsKey(makePattern(word))) {
				newMatches.put(makePattern(word), new TreeSet<>());
			}
			newMatches.get(makePattern(word)).add(word);
		}
		groupFams=newMatches;
	}


	//count how many words are in a family
	private int countWordsInFamily(String pattern) {
		if(!groupFams.containsKey(pattern)) {
			return 0;
		}
		return groupFams.get(pattern).size();
	}


	/**
	 * Update the game status (pattern, wrong guesses, word list),
	 * based on the give guess.
	 * @param guess pre: !alreadyGuessed(ch), the current guessed character
	 * @return return a tree map with the resulting patterns and the number of
	 * words in each of the new patterns.
	 * The return value is for testing and debugging purposes.
	 */
	public  TreeMap<String, Integer> makeGuess(char guess) {
		currentLetterGuess = guess;
		guessedLetters.add(Character.toString(guess)); //add the guesses to a set
		//MAIN LOGIC LOOP:
		//Create new patterns using currentList based on the guessed letter - updates patternList
		savePattern();
		//Creates the list of words for each pattern based on currentList - updates groupFam
		groupMatches();
		// Iterates the patternList.Keeps track of patterns based on the size of their list of words
		//- updates bestFam
		addToFam();
		// Determines what will be the next currentPattern based on difficulty - updates 
		//currentPattern and currentList
		updateCurrentList();
		// Assess if hit or miss
		decrementGuesses(guess); //decrease guesses left
		roundNumber++;
		return bestFam;
	}


	/**
	 * Checks if guessed letter was added to the currentPatter to determine a hit or miss.
	 * Input : Guessed letter as type String - to run string.contains method
	 */
	private void decrementGuesses(char character) {
		//if the currentPattern doesnt have the guess, decrement the guesses left
		if(!currentPattern.contains(Character.toString(character))) {
			wrongGuesses--;
		}
	}



	/**
	 * Return the secret word this HangmanManager finally ended up
	 * picking for this round.
	 * If there are multiple possible words left one is selected at random.
	 * <br> pre: numWordsCurrent() > 0
	 * @return return the secret word the manager picked.
	 */
	public String getSecretWord() {
		if (currentList.size() != 1 && wrongGuesses == 0){
			Random rnd = new Random();
			int upperLimit = currentList.size();
			int random = rnd.nextInt(upperLimit);
			Object[] arr = currentList.toArray();
			finalAnswer = (String) arr[random];
		}
		return finalAnswer;
	}
}
