#include "merge.h"
#include "quick.h"

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

    printQuick(x, k, n);
    printMerged(x, k, n);
    
    return 0;
}