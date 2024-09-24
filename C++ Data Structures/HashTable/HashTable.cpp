#include <iostream>
#include <list>
#include <cstring>
using namespace std;

class HashTable {
    private:
        static const int hashGroups = 10;
        list<pair<int, string>> table[hashGroups];

    public:
        bool isEmpty() const;
        int hashFunction(int key);
        void insertItem(int key, string value);
        void removeItem(int key);
        string searchTable(int key);
        void printTable(); 

};

bool HashTable::isEmpty() const {
    int sum{};
    for(int i{}; i < hashGroups; i++) {
        sum += table[i].size();
    }

    if (!sum) {
        return true;
    }
    return false;
}

int HashTable::hashFunction(int key) {
    return key % hashGroups; 
}

void HashTable::insertItem(int key, string value) {
    int hashValue = hashFunction(key);
    auto& cell = table[hashValue];
    auto bItr = begin(cell);
    bool keyExists = false;

    for (; bItr != end(cell); bItr++) {
        if (bItr->first == key) {
            keyExists = true;
            bItr->second = value;
            cout << "[WARNING] Key exists. Value replaced" << endl;
            break;
        }
    }

    if (!keyExists) {
        cell.emplace_back(key, value);
    }

    return;
}

void HashTable::removeItem(int key) {
    int hashValue = hashFunction(key);
    auto& cell = table[hashValue];
    auto bItr = begin(cell);
    bool keyExists = false;
    
    for (; bItr != end(cell); bItr++) {
        if (bItr->first == key) {
            keyExists = true;
            bItr = cell.erase(bItr);
            cout << "[INFO] Pair removed" <<endl;
            break;
        }
    }

    if (!keyExists) {
        cout << "[WARNING] Key not found. Pair not remo " << endl;
    }

    return;
}

void HashTable::printTable() {
    for (int i{}; i < hashGroups; i++) {
        if (table[i].size() == 0) continue;
        
        auto bItr = table[i].begin();
        for (; bItr != table[i].end(); bItr++) {
            cout<< "[INFO] Key: " << bItr->first << ", Value: " << bItr->second << endl;
        }
    }

    return;
}

int main() {
    HashTable HT;

    if (HT.isEmpty()) {
        cout << "Correct answer. Good Job"<< endl;
    } else {
        cout << "Error occured. Check code" << endl;
    }

    HT.insertItem(452, "Jame");
    HT.insertItem(234, "Dean");
    HT.insertItem(563, "John");
    HT.insertItem(123, "Toma");
    HT.insertItem(756, "Dann");
    HT.insertItem(204, "Paul");
    HT.insertItem(226, "Carl");
    HT.insertItem(868, "Isac");

    HT.printTable();

    HT.removeItem(226);
    HT.removeItem(756);

    if (HT.isEmpty()) {
        cout << "Error occured. Check code" << endl;
    } else {
        cout << "Correct answer. Good Job"  << endl;
    }


    return 0;
}

