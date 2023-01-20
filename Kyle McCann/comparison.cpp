#include "merge.h"
#include "quick.h"
#include <chrono>
using namespace std::chrono;

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

    auto quickFirst = high_resolution_clock::now();
    printQuick(x, k, n);
    auto quickSecond = high_resolution_clock::now();
    auto mergeFirst = high_resolution_clock::now();
    printMerged(x, k, n);
    auto mergeSecond = high_resolution_clock::now();
    
    cout << "Quick Select Method is: " << duration_cast<microseconds>(quickSecond - quickFirst).count() << " nanoseconds" << endl;
    cout << "Merge Method is: " << duration_cast<microseconds>(mergeSecond - mergeFirst).count() << " nanoseconds" << endl;
    return 0;
}