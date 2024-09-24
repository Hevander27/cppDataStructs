#include <stdlib.h>
#include <string>
#include <sstream>


template <class Type>
struct Node 
{
    Type item;
    Node<Type>* next = NULL;
};

template <class Type>
class SingleLinkedList {

    Node<Type>* first = NULL;
    Node<Type>* end = NULL; 
    int count =  0;

    public:

    ~SingleLinkedList() {
        while (first != NULL) {
            Remove(0);
            //printf("Removed:%i\n", count);
            
        }
    }
    void Append(Type item) {

        Node<Type>* node = new Node<Type>();

        node->item = item;

        if (first == NULL) {

            first = node;

        } else {
            end->next = node;
        }

        end = node;
        count++;
    }

    std::string toString() {
        std::basic_stringstream<char> ss;
        //printf("ENTERING LOOP\n");
        for (Node<Type>* node = first; node != NULL; node = node->next) {
            //printf("Node: %p\n",node);
            //printf("Item: %i\n",node->item);
            ss << node->item << ",";  
        }
        //printf("EXITING LOOP");
        return ss.str();
    }

    void Remove(int index) {

        if (index >= 0 && index < count) {
            Node<Type>* node = first;
            Node<Type>* temp = NULL;
            for (int i = 0; i < index; i++) {
                temp = node;
                //printf("temp:%p\n",temp);
                node = node->next;
                //printf("node:%p\n",node);
            }
            
            if (temp != NULL) {
                temp->next = node->next;
                 //printf("temp->next:%p\n",node->next);
            
            } else {
                first = node->next;
            }
            
            if (node == end) {
                end = temp;
            }
            //printf("del_node:%p\n",node);
            delete node;
            count--;
        }
    }

    void Insert(Type item, int index) {
        /**
         * Consider empty list
         * Consider insertion between two nodes
         * Consider insertion at the end: can be null or not~
         * **/
        
        Node<Type>* inserted = new Node<Type>();
        inserted->item = item;

        if (index >= 0 && index < count) {
                
            if (index == 0) { // insert at 0
                        
                inserted->next = first;
                first = inserted;
        

            }else {// general case

                Node<Type>* preIndex = first;
                        
                for (int i = 0; i < index-1; i++) {
                    preIndex = preIndex->next;
                }
                inserted->next = preIndex->next;
                preIndex->next = inserted;
                
            }
                    
        } else { 
            Append(item);
        }
        count++;
        
    }

};

int main() {
    SingleLinkedList<int> list;
    
    list.Append(2);
    list.Append(5);
    list.Append(9);
    list.Append(12);
    //printf("List:(%s)\n",list.toString().c_str());
    list.Insert(3,1);
    list.Insert(4,0);
    list.Insert(7,6);
    //printf("List:(%s)\n",list.toString().c_str());
    
    return 0;
}