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
class CircularLinkedList {
    
    Node<Type>* head = NULL;
    Node<Type>* tail = NULL;
    int count = 0;

    public:

    //~CircularLinkedList() {
    //    while (head != NULL) {
    //        Remove(0);
    //        printf("Removed:%i\n", count);
            
    //    }
    //}

    void Append(Type item) {

        Node<Type>* node = new Node<Type>();
        node->item = item;
        if (head == NULL && tail == NULL) {
            printf("Append Head: %i\n",node->item);
            head = node;
            tail = node;
            printf("Head Node: %i\n",head->item);
            printf("Tail Node: %i\n",tail->item);
            printf("Head Next: %p\n",head->next);
            printf("Tail Next: %p\n",tail->next);
        } else {
            printf("Append: %i\n",node->item);
            tail->next = node;
        }

        tail = node;
        tail->next = head;
        count++;

    }

    std::string toString(Type item) {
        std::basic_stringstream<char> ss;
        printf("ENTERING LOOP\n");
        for (Node<Type>* node = head; node != NULL; node = node->next) {
            printf("Node: %p\n",node);
            printf("Item: %i\n",node->item);
            ss << node->item << " ";
        }
        printf("EXITING LOOP");
        return ss.str();
    }

    void Remove(int index) {

        if (index >= 0 && index < count) {
            Node<Type>* node = head;
            
            if (index == 0) {

                tail->next = head->next;
                head = head->next;
             } else {
                Node<Type>* temp = tail ;
                for (int i = 0; i < index; i++) {
                    temp = node;
                    //printf("temp:%p\n",temp);
                    node = node->next;
                    //printf("node:%p\n",node);
                }
                temp->next = node->next;

            }
            printf("del_node:%i\n",node->item);
            delete node;
            count--; 
        }

    }

    void Insert(Type item, int index) {

        Node<Type>* inserted = new Node<Type>();
        inserted->item = item;

        if (index>= 0 && index < count && head != NULL) {
            Node<Type>* preIndex = head;
            
            // inserting with item in list
            if (index == 0 && head->next == tail) {
                tail->next = inserted;
                inserted->next = tail;
                head = inserted;
            } else {

                for (int i = 0; i < index-1; i++) {
                    //printf("preIndex: %p\n",preIndex);
                    preIndex = preIndex->next;
                }
                Node<Type>* temp = new Node<Type>();
                temp = preIndex->next;
                inserted->next = temp;//;
                preIndex = inserted;
                temp->next = inserted;
                
                
            }
            printf("Inserted: %i\n", inserted->item); 

        } else {
            Append(item);
        }
        count++;
    }
};

int main() {
    CircularLinkedList<int> list;
    
    list.Append(2);
    list.Append(5);
    list.Append(9);
    list.Append(12);
    list.Remove(3);
    //printf("List:(%s)\n",list.toString().c_str());
    //list.Insert(3,1);
    //list.Insert(4,0);
    //list.Insert(7,6);
    //printf("List:(%s)\n",list.toString().c_str());
    
    return 0;

}