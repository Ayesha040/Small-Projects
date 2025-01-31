import java.util.Iterator;
import java.util.ArrayList;

/**
 * In this implementation of the ISet interface, the elements in the Set are 
 * maintained in ascending order.
 * 
 * The data type for E must be a type that implements Comparable.
 * 
 * Implement methods that were not implemented in AbstractSet 
 * and override methods that can be done more efficiently. An ArrayList must 
 * be used as the internal storage container. For methods involving two sets, 
 * if that method can be done more efficiently if the other set is also a 
 * SortedSet, then do so.
 */
public class SortedSet<E extends Comparable<? super E>> extends AbstractSet<E> {
    private ArrayList<E> myCon;
    private int size = 0;

    /**
     * Create an empty SortedSet.
     */
    public SortedSet() {
        myCon = new ArrayList<E>();
        size = 0;
    }

    /**
     * Create a SortedSet out of an unsorted set.
     * @param other != null
     * O(NlogN)
     */
    public SortedSet(ISet<E> other) {
        if(other == null) {
            throw new NullPointerException("Precondition: otherSet != null");
        }
        Iterator<E> it = other.iterator();
        while (it.hasNext()) {
            E temp = it.next();
            myCon.add(temp);
        }
        quickSort(myCon);
        size = myCon.size();
    }

    // Method that does the sorting using quicksort
    // O(NlogN)
    private ArrayList<E> quickSort(ArrayList<E> sort) {
        if (sort.size() <= 1) {
            return sort; // Already sorted
        }
        ArrayList<E> sorted = new ArrayList<E>();
        ArrayList<E> lesser = new ArrayList<E>();
        ArrayList<E> greater = new ArrayList<E>();
        // Use the last element as the pivot
        E pivot = sort.get(sort.size() - 1);
        for (int i = 0; i < sort.size() - 1; i++) {
            if (sort.get(i).compareTo(pivot) < 0) {
                lesser.add(sort.get(i));
            } else {
                greater.add(sort.get(i));
            }
        }
        lesser = quickSort(lesser); // Sort through the lesser elements
        greater = quickSort(greater); // Sort through the greater elements
        // Merge them together
        lesser.add(pivot);
        lesser.addAll(greater);
        sorted = lesser;
        return sorted;
    }

    /**
     * Return the smallest element in this SortedSet.
     * <br> pre: size() != 0
     * @return the smallest element in this SortedSet.
     * O(1)
     */
    public E min() {
        if(size() == 0) {
            throw new NullPointerException("Precondition: size != 0");
        }
        return myCon.get(0); // First element
    }

    /**
     * Return the largest element in this SortedSet.
     * <br> pre: size() != 0
     * @return the largest element in this SortedSet.
     * O(1)
     */
    public E max() {
        if(size() == 0) {
            throw new NullPointerException("Precondition: size != 0");
        }
        return myCon.get(myCon.size() - 1); // Last element
    }

    /**
     * Add an item to this set.
     * <br> item != null
     * @param item the item to be added to this set. item may not equal null.
     * @return true if this set changed as a result of this operation, 
     * false otherwise.
     * O(N)
     */
    @Override
    public boolean add(E item) {
        if(item == null) {
            throw new NullPointerException("Precondition: item != null");
        }
        if (this.contains(item)) {
            return false; // Item already exists in the set
        }
        if (size == 0) {
            myCon.add(item);
            size++;
            return true;
        }
        // Add item while keeping the set in sorted order
        for (int i = 0; i < myCon.size(); i++) {
            E temp = myCon.get(i);
            if (item.compareTo(temp) < 0) {
                myCon.add(i, item);
                size++;
                return true;
            }
        }
        // Item is greater than all elements, add to the end
        myCon.add(item);
        size++;
        return true;
    }

    // O(N)
    @Override
    public boolean addAll(ISet<E> otherSet) {
        if(otherSet == null) {
            throw new NullPointerException("Precondition: otherSet != null");
        }
        int initialSize = size();
        SortedSet<E> otherSorted;
        if (!(otherSet instanceof SortedSet)) {
            otherSorted = new SortedSet<E>(otherSet);
        } else {
            otherSorted = (SortedSet<E>) otherSet;
        }

        for (E otherTemp : otherSorted) {
            if (!this.contains(otherTemp)) {
                size++;
                this.add(otherTemp);
            }
        }
        return size != initialSize;
    }

    // O(N)
    @Override
    public void clear() {
        myCon.clear();
        size = 0;
    }

    @Override
    // O(logN)
    public boolean contains(E item) {
        if(item == null) {
            throw new NullPointerException("Precondition: item != null");
        }
        int less = 0;
        int greater = myCon.size() - 1;

        while(less <= greater) {
            int middle = (less + greater) / 2;
            if (myCon.get(middle).compareTo(item) == 0) {
                return true; // Found
            } else if (myCon.get(middle).compareTo(item) > 0) {
                greater = middle - 1;
            } else {
                less = middle + 1;
            }
        }
        return false; // Not found
    }

    @Override
    // O(N)
    public boolean containsAll(ISet<E> otherSet) {
        if(otherSet == null) {
            throw new NullPointerException("Precondition: otherSet != null");
        }
        SortedSet<E> otherSorted;
        if (!(otherSet instanceof SortedSet)) {
            otherSorted = new SortedSet<E>(otherSet);
        } else {
            otherSorted = (SortedSet<E>) otherSet;
        }

        Iterator<E> otherIt = otherSorted.iterator();
        int index = 0;
        E temp = otherIt.next();

        while (otherIt.hasNext()) {
            if (myCon.get(index).compareTo(temp) == 0) {
                index++;
                temp = otherIt.next();
            } else if (myCon.get(index).compareTo(temp) < 0) {
                index++;
            } else {
                return false;
            }
        }
        return true;
    }

    @Override
    // O(N)
    public ISet<E> difference(ISet<E> otherSet) {
        if(otherSet == null) {
            throw new NullPointerException("Precondition: otherSet != null");
        }
        SortedSet<E> otherSorted;
        if (!(otherSet instanceof SortedSet)) {
            otherSorted = new SortedSet<E>(otherSet);
        } else {
            otherSorted = (SortedSet<E>) otherSet;
        }

        Iterator<E> otherIt = otherSorted.iterator();
        SortedSet<E> result = new SortedSet<E>();
        int index = 0;
        E temp = otherIt.next();

        while (index < size) {
            if (myCon.get(index).compareTo(temp) == 0) {
                index++;
                if (otherIt.hasNext()) {
                    temp = otherIt.next();
                }
            } else if (myCon.get(index).compareTo(temp) < 0) {
                result.add(myCon.get(index));
                index++;
            } else if (otherIt.hasNext()) {
                temp = otherIt.next();
            }
        }
        while (index < myCon.size()) {
            result.add(myCon.get(index));
            index++;
        }
        return result;
    }

    @Override
    // O(N)
    public boolean equals(Object other) {
        if (other == null) {
            return false;
        }
        ISet<E> otherSet = (ISet<E>) other;
        SortedSet<E> otherSorted;
        if (!(otherSet instanceof SortedSet)) {
            otherSorted = new SortedSet<E>();
        } else {
            otherSorted = (SortedSet<E>) otherSet;
        }

        if(this.size() != otherSet.size()) {
            return false;
        } else {
            Iterator<E> it = this.iterator();
            Iterator<?> otherIt = otherSet.iterator();
            while(it.hasNext()) {
                if(!it.next().equals(otherIt.next())) {
                    return false;
                }
            }
        }
        return true;
    }

    @Override
    // O(N)
    public ISet<E> intersection(ISet<E> otherSet) {
        if(otherSet == null) {
            throw new NullPointerException("Precondition: otherSet != null");
        }
        SortedSet<E> otherSorted;
        if (!(otherSet instanceof SortedSet)) {
            otherSorted = new SortedSet<E>(otherSet);
        } else {
            otherSorted = (SortedSet<E>) otherSet;
        }

        SortedSet<E> result = new SortedSet<E>();
        for (E thisTemp : this) {
            if (otherSorted.contains(thisTemp)) {
                result.add(thisTemp);
            }
        }
        return result;
    }

    @Override
    // O(N)
    public boolean isEmpty() {
        return myCon.isEmpty();
    }

    @Override
    // O(1)
    public int size() {
        return size;
    }

    @Override
    // O(N)
    public Iterator<E> iterator() {
        return myCon.iterator();
    }
  @Override
  // O(N + M), where N is the size of this set and M is the size of the other set
  public ISet<E> union(ISet<E> otherSet) {
      if (otherSet == null) {
          throw new NullPointerException("Precondition: otherSet != null");
      }
  
      SortedSet<E> otherSorted;
      if (!(otherSet instanceof SortedSet)) {
          otherSorted = new SortedSet<E>(otherSet);
      } else {
          otherSorted = (SortedSet<E>) otherSet;
      }
  
      SortedSet<E> result = new SortedSet<E>();
  
      // Add all elements from this set
      for (E thisTemp : this) {
          result.add(thisTemp);
      }
  
      // Add all elements from the other set
      for (E otherTemp : otherSorted) {
          result.add(otherTemp);
      }
  
      return result;
  }

}
