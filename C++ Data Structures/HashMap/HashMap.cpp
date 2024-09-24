#include <iostream>
#include <list>
#include <cstring>
using namespace std;

class HashMap
{
    private:
        static const int hashGroups = 10;
        list<pair<int, string>> table[hashGroups];

    public:
        get(Object key)
        int hashFunction(int key);
        void insertItem(int key, string value);
        void removeItem(int key);
        string searchTable(int key);
        void printTable(); 
        remove(Object key, Object value)


    
};
/*
public class Key {

    private final int x;
    private final int y;

    public Key(int x, int y) {
        this.x = x;
        this.y = y;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Key)) return false;
        Key key = (Key) o;
        return x == key.x && y == key.y;
    }

    @Override
    public int hashCode() {
        int result = x;
        result = 31 * result + y;
        return result;
    }
    

}
*/











}