#include<iostream>
#include<bits/stdc++.h>

template<class T> 
class Vector
{
    /* Add elements
     * Access the ith elemnt
     * Constructor
     * Grow Array at threshhold
     */
    T* data;
    int size;
    public:
        Vector() 
        { 
            data = NULL;
            size = 0;
         }

        Vector(T array[], int n) 
        {
              data = new T[n];
            for(int i = 0; i < n; i++) {
                data[i] = array[i];
            }
            size = n;
        }

        ~Vector() 
        {
            if(data != NULL)
                delete[] data;
        }
        void pushBack(T item) 
        {
            std::cout << item << std::endl;
            T* temp = new T[size  + 1];
            for(int i = 0; i < size; i++) { 
                temp[i] = data[i];
            }

            temp[size] =  item;

            if(data == NULL) 
                delete[] data;
            
            size++;
            data = temp;
            
        }

        T& operator[] (int i) 
        {
            return data[i];
        }

        int getSize()
        {
            return size;
        }

        friend std::ostream &operator<<( std::ostream &output, Vector<T>& v) {
            output << '[';
            for(int i = 0; i < (int)v.getSize()-1; i++) 
                output << v[i] << ", ";

            output << v[v.getSize() - 1];
            output << ']';
            return output;
        }

};

int main() {

    int arr[] = {1,2,3,4,2,1};
    Vector<int> v(arr, 6);
    //v.pushBack(10);
    std::cout << v;
    return 0;
}
