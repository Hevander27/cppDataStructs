
public class FBHashTable<E> 
	private LinkedList<E>[] table;
	private int count;
	private static int defaultSize = 12;//nextPrime will produce a 13 from this value
	public FBHashTable() 
	public FBHashTable(int defaultSize) 

	public void makeEmpty()

	public boolean isEmpty()

	public void insert(E val)//O(M) = "Nearly O(1)"

	public boolean contains(E val)

	public E get(E val)//O(2M)
	
	public boolean remove(E val)


	private int hash(E val)//O(1)

	private int nextPrime(int size)

	public String toString()


