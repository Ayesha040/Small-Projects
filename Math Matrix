/**
* The MathMatrix class represents a matrix with integer values and provides 
* constructors for deep copying an existing matrix or initializing one with 
* a default value. It includes methods for matrix operations like addition, 
* subtraction, multiplication, scaling, transposition, and element retrieval, 
* along with an equals method for comparison.
*/

import java.util.Arrays;

public class MathMatrix {

	// instance variable
	private int numCols;	
	private int numRows;
	private int [][] values;


	/**
	 * create a MathMatrix with cells equal to the values in mat.
	 * A "deep" copy of mat is made.
	 * Changes to mat after this constructor do not affect this
	 * Matrix and changes to this MathMatrix do not affect mat
	 * @param  mat  mat !=null, mat.length > 0, mat[0].length > 0,
	 * mat is a rectangular matrix
	 */
	public MathMatrix(int[][] mat) {

		if(mat.length > 0) {
			this.numRows = mat.length;
			this.numCols = mat[0].length;
			values = new int [mat.length] [mat[0].length];
			for (int i = 0; i < mat.length; i ++) {
				for (int j = 0; j < mat[0].length; j ++) {
					values[i][j] = mat[i][j];
				}
			}
		}
	}


	/**
	 * create a MathMatrix of the specified size with all cells set to the intialValue.
	 * <br>pre: numRows > 0, numCols > 0
	 * <br>post: create a matrix with numRows rows and numCols columns.
	 * All elements of this matrix equal initialVal.
	 * In other words after this method has been called getVal(r,c) = initialVal
	 * for all valid r and c.
	 * @param numRows numRows > 0
	 * @param numCols numCols > 0
	 * @param initialVal all cells of this Matrix are set to initialVal
	 */
	public MathMatrix(int numRows, int numCols, int initialVal) {
		this.numRows = numRows; 
		this.numCols = numCols; 
		values = new int[numRows][numCols];
		for (int i = 0; i < numRows; i ++) {
			for (int j = 0; j < numCols; j++) {
				values[i][j] = initialVal;
			}
		}
	}

	/**
	 * Get the number of rows.
	 * @return the number of rows in this MathMatrix
	 */
	public int getNumRows() {
		int num = values.length;  	
		return num;
	}


	/**
	 * Get the number of columns.
	 * @return the number of columns in this MathMatrix
	 */
	public int getNumColumns(){
		int num = values[0].length;
		return num;
	}



	/**
	 * get the value of a cell in this MathMatrix.
	 * <br>pre: row  0 <= row < getNumRows(), col  0 <= col < getNumColumns()
	 * @param  row  0 <= row < getNumRows()
	 * @param  col  0 <= col < getNumColumns()
	 * @return the value at the specified position
	 */
	public int getVal(int row, int col) {
		int cell = values[row][col];
		return cell;
	}


	/**
	 * implements MathMatrix addition, (this MathMatrix) + rightHandSide.
	 * <br>pre: rightHandSide != null, rightHandSide.getNumRows() = getNumRows(),
	 * rightHandSide.numCols() = getNumColumns()
	 * <br>post: This method does not alter the calling object or rightHandSide
	 * @param rightHandSide rightHandSide.getNumRows() = getNumRows(),
	 * rightHandSide.numCols() = getNumColumns()
	 * @return a new MathMatrix that is the result of adding this Matrix to rightHandSide.
	 * The number of rows in the returned Matrix is equal to the number of rows in this MathMatrix.
	 * The number of columns in the returned Matrix is equal to the number of columns
	 * in this MathMatrix.
	 */
	public MathMatrix add(MathMatrix rightHandSide){
		int additionArray[][] = new int[numRows][numCols];
		for (int i = 0; i < numRows ; ++i) {
			for (int j = 0; j < numCols ; ++j) {
				additionArray[i][j] = values[i][j] + rightHandSide.getVal(i,j);
			}
		}			
		return new MathMatrix(additionArray);
	}


	/**
	 * implements MathMatrix subtraction, (this MathMatrix) - rightHandSide.
	 * <br>pre: rightHandSide != null, rightHandSide.getNumRows() = getNumRows(),
	 * rightHandSide.numCols() = getNumColumns()
	 * <br>post: This method does not alter the calling object or rightHandSide
	 * @param rightHandSide rightHandSide.getNumRows() = getNumRows(),
	 * rightHandSide.numCols() = getNumColumns()
	 * @return a new MathMatrix that is the result of subtracting rightHandSide
	 * from this MathMatrix. The number of rows in the returned MathMatrix is equal to the number
	 * of rows in this MathMatrix.The number of columns in the returned MathMatrix is equal to
	 * the number of columns in this MathMatrix.
	 */
	public MathMatrix subtract(MathMatrix rightHandSide){
		int subtractionArray[][] = new int[numRows][numCols];
		for (int i = 0; i < numRows; ++ i) {
			for (int j = 0; j < numCols; ++j) {
				subtractionArray[i][j] = values[i][j] - rightHandSide.getVal(i,j);
			}
		}			
		return new MathMatrix(subtractionArray);
	}


	/**
	 * implements matrix multiplication, (this MathMatrix) * rightHandSide.
	 * <br>pre: rightHandSide != null, rightHandSide.getNumRows() = getNumColumns()
	 * <br>post: This method should not alter the calling object or rightHandSide
	 * @param rightHandSide rightHandSide.getNumRows() = getNumColumns()
	 * @return a new MathMatrix that is the result of multiplying 
	 * this MathMatrix and rightHandSide.
	 * The number of rows in the returned MathMatrix is equal to the number of rows
	 * in this MathMatrix. The number of columns in the returned MathMatrix is equal to the number
	 * of columns in rightHandSide.
	 */
	public MathMatrix multiply(MathMatrix rightHandSide){


		int multiplyArray[][] = new int[values.length][rightHandSide.getNumColumns()];

		for (int i = 0; i < values.length; ++ i) {
			for (int j = 0; j < rightHandSide.getNumColumns(); ++j) {
				for (int a = 0; a < rightHandSide.getNumRows(); ++ a) { 
					multiplyArray[i][j] += values[i][a] * rightHandSide.getVal(a, j);	        	
				}
			}
		}

		return new MathMatrix(multiplyArray);
	}


	/**
	 * Create and return a new Matrix that is a copy
	 * of this matrix, but with all values multiplied by a scale
	 * value.
	 * <br>pre: none
	 * <br>post: returns a new Matrix with all elements in this matrix
	 * multiplied by factor.
	 * In other words after this method has been called
	 * returned_matrix.getVal(r,c) = original_matrix.getVal(r, c) * factor
	 * for all valid r and c.
	 * @param factor the value to multiply every cell in this Matrix by.
	 * @return a MathMatrix that is a copy of this MathMatrix, but with all
	 * values in the result multiplied by factor.
	 */
	public MathMatrix getScaledMatrix(int factor) {
		int factoredArray[][] = values;
		for (int i = 0; i < numRows; ++ i) {
			for (int j = 0; j < numCols; ++j) {
				factoredArray[i][j] *= factor;
			}
		}
		return new MathMatrix(factoredArray);
	}


	/**
	 * accessor: get a transpose of this MathMatrix.
	 * This Matrix is not changed.
	 * <br>pre: none
	 * @return a transpose of this MathMatrix
	 */
	public MathMatrix getTranspose() {
		int transposedArray[][] = new int [numCols][numRows];
		for (int i = 0; i < numRows; ++ i) {
			for (int j = 0; j < numCols; ++j) {
				transposedArray[j][i] = values[i][j];			
			}
		}
		return new MathMatrix(transposedArray);
	}


	/**
	 * override equals.
	 * @return true if rightHandSide is the same size as this MathMatrix and all values in the
	 * two MathMatrix objects are the same, false otherwise
	 */
	public boolean equals(Object rightHandSide){
		/* CS314 Students. The following is standard equals
		 * method code. We will learn about in the coming weeks.
		 *
		 * We use getClass instead of instanceof because we only want a MathMatrix to equal
		 * another MathMatrix as opposed to any possible sub classes. We would
		 * use instance of if we were implementing am interface and wanted to equal
		 * other objects that are instances of that interface but not necessarily
		 * MathMatrix objects.
		 */

		if (rightHandSide == null || this.getClass() != rightHandSide.getClass()) {
			return false;
		}
		// We know rightHandSide refers to a non-null MathMatrix object, safe to cast.
		MathMatrix otherMathMatrix = (MathMatrix) rightHandSide;
		// Now we can access the private instance variables of otherMathMatrix
		// and / or call MathMatrix methods on otherMathMatrix.

		for (int i = 0; i < numRows; ++ i) {
			for (int j = 0; j < numCols; ++j) {
				if (this.values[i][j] != otherMathMatrix.getVal(i, j)) {
					return false;
				}
			}
		}
		return true; // CS314 students, alter as necessary
	}



	/**
	 * override toString.
	 * @return a String with all elements of this MathMatrix.
	 * Each row is on a separate line.
	 * Spacing based on longest element in this Matrix.
	 */
	public String toString() {
		int temp = 0;
		StringBuilder arrayString = new StringBuilder();
		int padding = 0; //spacing
		//first loop to find the longest length of an element
		for (int i = 0; i < numRows; ++ i) {
			for (int j = 0; j < numCols; ++ j) {
				int length = String.valueOf(this.values[i][j]).length();
				if (length > temp) {
					temp  = length + 1;					
				}				
			}
		}

		//now loop through to build the string
		for (int i = 0; i < numRows; ++ i) {
			arrayString.append("|");
			for (int j = 0; j < numCols; ++ j) {
				padding = temp - String.valueOf(this.values[i][j]).length();
				for (int a = 0; a < padding; a ++) {
					arrayString.append(" ");
				}
				arrayString.append(String.valueOf(this.values[i][j]));

			}
			arrayString.append("|\n");
		}

		return arrayString.toString();
	}



	/**
	 * Return true if this MathMatrix is upper triangular. To
	 * be upper triangular all elements below the main
	 * diagonal must be 0.<br>
	 * pre: this is a square matrix. getNumRows() == getNumColumns()
	 * @return <tt>true</tt> if this MathMatrix is upper triangular,
	 * <tt>false</tt> otherwise.
	 */
	public boolean isUpperTriangular(){
		for (int i = 0; i < numRows; ++ i) {
			for (int j = 0; j < numCols; ++ j) {
				if (i > j) {
					if (this.values[i][j] != 0) {
						return false;
					}
				}
			}
		}
		return true;
	}

	// method to ensure mat is rectangular. It is public so that
	// tester classes can use it.
	// pre: mat != null, mat has at least one row
	// return true if all rows in mat have the same
	// number of columns false otherwise.
	public static boolean rectangularMatrix(int[][] mat) {
		if (mat == null || mat.length == 0) {
			throw new IllegalArgumentException("argument mat may not be null and must "
					+ " have at least one row. mat = " + Arrays.toString(mat));
		}
		boolean isRectangular = true;
		int row = 1;
		final int COLUMNS = mat[0].length;
		while (isRectangular && row < mat.length) {
			isRectangular = (mat[row].length == COLUMNS);
			row++;
		}
		return isRectangular;
	}

}
