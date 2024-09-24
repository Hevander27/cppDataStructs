#include <stdlib.h>
#include <string>
#include <sstream>

template <class Type>
struct Node
{
    Type item;
    Node<Type>* next = NULL;
    Node<Type>* prev = NULL;
};

template <class Type>
class Queue {

    Node<Type>* front = NULL;
    Node<Type>* end = NULL;
    int length = 0;

    public:

    // add a node to the list
    void Enqueue(Type item) {
        Node<Type>* node = new Node<Type>();
        node->item = item;
        if (front == NULL) {
            front = node;

        } else {
            end->next = node;
            node->prev = end;
        }
        end = node;
        length++;
    }

    // remove a node from the list and return it
    std::Type Dequeue() {
        if (first == NULL) return NULL;

        Node<Type>* remove = new Node<Type>();
        remove = first;

        if (first->next != NULL) {

            first = first->next;
            first->prev = NULL;

        } else {
            end = NULL;
            first = NULL;
        }
        length--;
        return remove->item;
    }

    // show the top node from the list
    std::Type peek() { 
        if (first == NULL) return NULL;
        return first->item;
    }




};

int main() {
    Queue<int> queue;

    queue.Enqueue(3)
    queue.Enqueue(7);
    queue.Enqueue(2);
    return 0;
}