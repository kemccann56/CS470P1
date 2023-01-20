#include <iostream>
#include <vector>

using namespace std;

void swap(int& first, int& second){
    int temp = first;
    first = second;
    second = temp;
}

int partition(int a[], int left, int right)
{
    int x = a[right];
    int i = left;

    for (int j = left; j <= right - 1; j++) {
        if (a[j] <= x) {
            swap(a[i], a[j]);
            i++;
        }
    }
    swap(a[i], a[right]);
    return i;
}
  
int findK(int arr[], int l, int r, int k)
{
    int index = partition(arr, l, r);

    if (index - l == k - 1){
        return index;
    }

    if (index - l > k - 1){
        return findK(arr, l, index - 1, k);
    }

    return findK(arr, index + 1, r, k - index + l - 1);
}

void printQuick(int x[], int k, int n){
    int temp = findK(x, 0, n - 1, n - k);

    cout << "Quick: ";
    for (int i = n - k; i < n; i++){
        cout << x[i] << " ";
    }

    cout << endl;
}