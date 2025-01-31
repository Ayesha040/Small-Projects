/*  
 * Recursive.java
 * 
 * This program implements various recursive methods, including:
 * - Converting a base 10 integer to binary.
 * - Reversing a string recursively.
 * - Counting elements in an array followed by double their value.
 * - Generating all possible mnemonics for a given phone number.
 * - Drawing a Sierpinski Carpet using recursion.
 * 
 * CS314 Assignment - University of Texas at Austin
 * Author: [Your Name]
 */

// Imports
import java.awt.Color;
import java.awt.Graphics;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class Recursive {
    
    /**
     * Problem 1: Convert a base 10 integer to binary recursively.
     * Precondition: n != Integer.MIN_VALUE
     * Postcondition: Returns a String that represents n in binary.
     */
    public static String getBinary(int n) {
        if (n == Integer.MIN_VALUE) {
            throw new IllegalArgumentException("Failed precondition: getBinary. n cannot be Integer.MIN_VALUE.");
        }
        if (n < 0) return "-" + getBinary(-n);
        if (n < 2) return String.valueOf(n);
        return getBinary(n / 2) + getBinary(n % 2);
    }

    /**
     * Problem 2: Reverse a String recursively.
     * Precondition: stringToRev != null
     * Postcondition: Returns a reversed version of stringToRev.
     */
    public static String revString(String stringToRev) {
        if (stringToRev == null) {
            throw new IllegalArgumentException("Failed precondition: revString. Parameter may not be null.");
        }
        if (stringToRev.length() <= 1) return stringToRev;
        return revString(stringToRev.substring(1)) + stringToRev.charAt(0);
    }
    
    /**
     * Problem 3: Count elements in data followed by double their value.
     * Precondition: data != null
     */
    public static int nextIsDouble(int[] data) {
        if (data == null) {
            throw new IllegalArgumentException("Failed precondition: nextIsDouble. Parameter may not be null.");
        }
        return countDoubles(data, 0);
    }
    
    private static int countDoubles(int[] data, int index) {
        if (index >= data.length - 1) return 0;
        return (data[index] * 2 == data[index + 1] ? 1 : 0) + countDoubles(data, index + 1);
    }
    
    /**
     * Problem 4: Generate all mnemonics for a given phone number.
     * Precondition: number != null, number.length() > 0, all characters in number are digits.
     */
    public static ArrayList<String> listMnemonics(String number) {
        if (number == null || number.isEmpty() || !number.matches("\\d+")) {
            throw new IllegalArgumentException("Failed precondition: listMnemonics");
        }
        ArrayList<String> results = new ArrayList<>();
        generateMnemonics(results, "", number);
        return results;
    }
    
    private static void generateMnemonics(ArrayList<String> mnemonics, String current, String remaining) {
        if (remaining.isEmpty()) {
            mnemonics.add(current);
        } else {
            String letters = digitLetters(remaining.charAt(0));
            for (char letter : letters.toCharArray()) {
                generateMnemonics(mnemonics, current + letter, remaining.substring(1));
            }
        }
    }
    
    private static final List<String> LETTERS_FOR_NUMBER = List.of("0", "1", "ABC", "DEF", "GHI", "JKL", "MNO", "PQRS", "TUV", "WXYZ");
    
    private static String digitLetters(char ch) {
        if (ch < '0' || ch > '9') throw new IllegalArgumentException("Character must be a digit (0-9). Given: " + ch);
        return LETTERS_FOR_NUMBER.get(ch - '0');
    }
    
    /**
     * Problem 5: Draw a Sierpinski Carpet recursively.
     */
    public static void drawCarpet(int size, int limit) {
        DrawingPanel p = new DrawingPanel(size, size);
        Graphics g = p.getGraphics();
        g.setColor(Color.BLACK);
        g.fillRect(0, 0, size, size);
        g.setColor(Color.WHITE);
        drawSquares(g, size, limit, 0, 0);
    }
    
    private static void drawSquares(Graphics g, int size, int limit, int x, int y) {
        if (size <= limit) return;
        int newSize = size / 3;
        g.fillRect(x + newSize, y + newSize, newSize, newSize);
        for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 3; j++) {
                if (i != 1 || j != 1) {
                    drawSquares(g, newSize, limit, x + i * newSize, y + j * newSize);
                }
            }
        }
    }
}
