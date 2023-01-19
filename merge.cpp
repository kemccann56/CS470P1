#include <iostream>
#include <vector>

using namespace std;

void merge(int a[], int left, int midpt, int right){
    int sizeLeft = midpt - left + 1;
    int sizeRight = right - midpt;
    
    int vLeft[sizeLeft]; 
    int vRight[sizeRight];

    for (int i = 0; i < sizeLeft; i++){
        vLeft[i] = a[left + i];
    }   

    for (int i = 0; i < sizeRight; i++){
        vRight[i] = a[midpt + 1 + i];
    }

    int indexLeft, indexRight, indexMerged;
    indexLeft = indexRight = 0;
    indexMerged = left;

    while ((indexLeft < sizeLeft) && (indexRight < sizeRight)){
        if (vLeft[indexLeft] <= vRight[indexRight]){
            a[indexMerged] = vLeft[indexLeft];
            indexLeft++;
        }

        else{
            a[indexMerged] = vRight[indexRight];
            indexRight++;
        }

        indexMerged++;
    }

    while (indexLeft < sizeLeft){
        a[indexMerged] = vLeft[indexLeft];
        indexLeft++;
        indexMerged++;
    }

    while (indexRight < sizeRight){
        a[indexMerged] = vRight[indexRight];
        indexRight++;
        indexMerged++;
    }
}

void mergeSort(int a[], int left, int right){
    if (left >= right){
        return;
    }
    int midpt;
    
    midpt = left + ((right - left) / 2);
    mergeSort(a, left, midpt);
    mergeSort(a, midpt + 1, right);
    merge(a, left, midpt, right);
}

int main() {
    int n = 0;
    int k = 0;

    cout << "N integers?";
    cin >> n;
    cout << "Top k?";
    cin >> k;

    int x[n];

    for (int i = 0; i < n; i++){
        int temp;
        cin >> temp;
        x[i] = temp;
    }

    mergeSort(x, 0, n - 1);

    for (int i = n - 1; i > n - k - 1; i--){
        cout << x[i] << " ";
    }
    
    return 0;
}