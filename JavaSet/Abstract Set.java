import java.util.Iterator;

public abstract class AbstractSet<E> implements ISet<E> {

	/**
	 * Return a String version of this set. 
	 * Format is (e1, e2, ... en)
	 * @return A String version of this set.
	 */
	public String toString() {
		StringBuilder result = new StringBuilder();
		String seperator = ", ";
		result.append("(");

		Iterator<E> it = this.iterator();
		while (it.hasNext()) {
			result.append(it.next());
			result.append(seperator);
		}
		// get rid of extra separator
		if (this.size() > 0) {
			result.setLength(result.length() - seperator.length());
		}

		result.append(")");
		return result.toString();
	}




	/**
	 * A union operation. Add all items of otherSet that 
	 * are not already present in this set to this set.
	 * @param otherSet != null
	 * @return true if this set changed as a result of this operation, 
	 * false otherwise.
	 */
	public boolean addAll(ISet<E> otherSet) {
		if(otherSet == null) {
			throw new NullPointerException("Precondition: otherSet != null");
		}
		Iterator <E> it = otherSet.iterator();
		int initSize = this.size();
		//while there is a next item, add it 
		while(it.hasNext()) {
			E temp = it.next();
			this.add(temp);
		}	
		return this.size() > initSize;
	}

	/**
	 * Make this set empty.
	 * <br>pre: none
	 * <br>post: size() = 0
	 */
	public void clear() {		
		Iterator<E> it = this.iterator(); 
		//iterate through and remove all elements
		while(it.hasNext()) {
			it.next();
			it.remove();
		}
	}


	/**
	 * Determine if item is in this set. 
	 * <br>pre: item != null
	 * @param item element whose presence is being tested. 
	 * Item may not equal null.
	 * @return true if this set contains the specified item, false otherwise.
	 */
	public boolean contains(E item) {
		if(item == null) {
			throw new NullPointerException("Precondition: item != null");
		}
		Iterator<E> it = this.iterator(); 
		//iterate through and if the next == item, return true
		while(it.hasNext()){
			if(it.next().equals(item))
				return true;
		}
		//not found
		return false;
	}

	/**
	 * Determine if all of the elements of otherSet are in this set.
	 * <br> pre: otherSet != null
	 * @param otherSet != null
	 * @return true if this set contains all of the elements in otherSet, 
	 * false otherwise.
	 */
	public boolean containsAll(ISet<E> otherSet) {
		if(otherSet == null) {
			throw new NullPointerException("Precondition: otherSet != null");
		}
		Iterator <E> otherIt = otherSet.iterator(); 
		//itherate through the other set
		while (otherIt.hasNext()) {
			//check the elements one by one
			if (!this.contains(otherIt.next()))
				return false;
		}
		return true;
	}


	
	 /**
     * Determine if this set is equal to other.
     * Two sets are equal if they have exactly the same elements.
     * The order of the elements does not matter.
     * <br>pre: none
     * @param other the object to compare to this set 
     * @return true if other is a Set and has the same elements as this set
     */
	public boolean equals(Object other) {	
		//check if other is a set
		if (other instanceof ISet<?>) {
			ISet<E> otherSet = (ISet<E>) other;
			return otherSet.containsAll(this) && this.containsAll(otherSet);
		}		
    		return false;
	}


	 /**
     * Remove the specified item from this set if it is present.
     * pre: item != null
     * @param item the item to remove from the set. item may not equal null.
     * @return true if this set changed as a result of this operation, 
     * false otherwise
     */
	public boolean remove(E item) {
		if(item == null) {
			throw new NullPointerException("Precondition: item != null");
		}
		Iterator <E> it = this.iterator(); 
		//iterate and remove element that are equal to item
		while (it.hasNext()) {
			E temp = it.next();
			if (temp.equals(item)) {
				it.remove();
				return true;
			}
		}	
		//if item is not in this set
		return false;
	}

	/**
     * Return the number of elements of this set.
     * pre: none
     * @return the number of items in this set
     */
	public int size() {
		int size = 0;
		Iterator<E> it = this.iterator(); 
		//count all items
		while(it.hasNext()){
			it.next();
			size++;
		}
		return size;
	}
	
	
	public abstract ISet<E> difference(ISet<E> otherSet);

	public abstract ISet<E> intersection(ISet<E> otherSet);

	public abstract Iterator<E> iterator();
	
	public abstract ISet<E> union(ISet<E> otherSet); 
	
	public abstract boolean add(E item);


}


