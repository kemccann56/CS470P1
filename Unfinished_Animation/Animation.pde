/**
 * MergeSort Visualization
 * by Alyssa Gabrielson 
 * 
 * Currently only displays the initial array with colors and
 * sorts the array with Merge Sort, but does not show it. 
 * I think it would be easier to animate quicksort
 * using Processing since it is in-place,
 * so I might change the algorithm later.
 *
 * Still need to add animation to the sorting and 
 * implement Quick Selection.
 * 
 */
 import java.io.*;
 import java.util.List;
 import java.util.ArrayList;
 
String buffer = "";
String saved = "";

int state = 0;
int num = 0;
int size = 0;
int numEntered = 0;
int startTime = 0;
int endTime = 0;
int totalTime = 0;
int m = 0;
int w = 10;
int x = 0;
int y = 0;

float array[];
float random[];
ArrayList<Integer> colors = new ArrayList<Integer>();
ArrayList<float[]> arrays = new ArrayList<float[]>();
 
 // This function fills the background
void setup() {
  size(1280, 720);
  textSize(64);
  random = new float[floor((width/w))]; // Initializing random test array
  
  for (int i = 0; i < random.length; i++) {
      random[i] = random(height);
      colors.add(i, -1);
  }
  
  frameRate(20);
}

// This function loops to display things on the screen
// I use different states to decide what will be looping to display
void draw() {
  if (state == 0) {
    background(0);
    
    text("Please select a mode.\nClick in this window to start typing. \nPress 1 and hit enter for a random array.", 50, 100);
    text("Press 2 and hit enter for a custom array.", 50, 400);
    text("Input: " + buffer, 50, 600);
  }
  else if (state == 1) { // state 1 = random array sorting
    background(0);
    
    startTime = millis();
    sort(random, 0, random.length - 1);
    endTime = millis();
    totalTime = endTime - startTime;
    state = 5;
  }
  else if (state == 2) { // state 2 = get size of array
    background(0);
    
    text("Hit enter after each entry. ", 50, 100);
    text("Please enter size of the array to be sorted.", 50, 200);
    text("Input: " + buffer, 50, 600);
  }
  else if (state == 3) { // state 3 = get numbers to sort
    background(0);
    
    text("Please enter the integers to be sorted.", 50, 100);
    text("The size of bars is currently relative to \nwindow height, will change later. \nEnter numbers 100+ for now", 50, 200);
    text("Hit enter after each entry. ", 50, 500);
    text("Input: " + buffer, 50, 600);
    if(numEntered == size) {
        state++;
    }
  }
  else if (state == 4) { // state 4 = sort the array
    background(152,190,100);
    
    for (int i = 0; i < array.length; i++) {
      stroke(51);
      fill(255);
      rect(i*w, height - array[i], w, array[i]); // Separate this into two states later, depending on 
    }                                            // if Random array or Custom array was chosen (make rectangles fit screen width).
    
    startTime = millis();
    sort(array, 0, array.length - 1);
    endTime = millis();
    totalTime = endTime - startTime;
    state = 5;
  }
  else if (y >= arrays.get(x).length) { // next loop
    x++;
    y = 0;
    state = 5;
  }
  else if (x >= arrays.size() - 1) { // break from loop
    state = 6;
  }
  else if (state == 5) { // state 5 = Drawing arrays
//    background(152,190,100);
//    stroke(51);
//    noStroke();

    fill(180, 223, 229);
    if (colors.get(y) == 0) // Color right(?) side red
      fill(255, 0, 0);
    else if (colors.get(y) == 1) // Color left(?) side green
      fill(0, 255, 0);
    else
      fill(255); // Color white
      
    rect(y*w, height - arrays.get(x)[y], w, arrays.get(x)[y]);
    y++;
  }
  else if (state == 6) {
    text("Total time to sort: " + totalTime + " milliseconds.", 50, 400);
    // make this loop to the beginning later
  }
}

// This function takes keyboard input
// This part is done you can ignore it
void keyTyped(){
  if (state == 0 && key == '\n') { // Decides which mode. Press 1 = random array, Press 2 = custom array
    saved = buffer;
    buffer = "";
    
    if (saved.equals("1")) { // Random state
      state = 1;
    }
    else if (saved.equals("2")) { // Custom state
      state = 2;
    }
  }
  else if (state == 2 && key == '\n') { // getting array size from user
    saved = buffer;
    buffer = "";
    size = Integer.valueOf(saved);
    array = new float[size];
    ++state;
  }
  else if (state == 3 && key == '\n') { // getting array integers from user
    saved = buffer;
    buffer = "";
    num = Integer.valueOf(saved);
    array[numEntered] = num;
    ++numEntered;
  }
  else { // keeps track of whats currently being typed before pressing enter
    buffer = buffer + key;
  }
}

// ===================================================================================================

//   MergeSort Function
//   By Kyle McCann

    void merge(float a[], int left, int midpt, int right)
    { 
      int sizeLeft = midpt - left + 1;
      int sizeRight = right - midpt;
      
      float vLeft[] =  new float[sizeLeft]; 
      float vRight[] =  new float[sizeRight];
  
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
              colors.add(indexLeft, 1); // if left <= right, color red
          }
  
          else{
              a[indexMerged] = vRight[indexRight];
              indexRight++;
              colors.add(indexRight, 0); // if left > right, color green
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
      
      // Store array after merge
      update(a);
    }
 
    // Main function that sorts array using
    // merge()
    void sort(float a[], int left, int right) // ,int offset)
    {          
      if (left >= right){
        return;
      }
      
      int midpt;
    
      midpt = left + ((right - left) / 2);
      sort(a, left, midpt);
      sort(a, midpt + 1, right);
      
      merge(a, left, midpt, right);
    }
    
    void update(float arr[]) {
      float temp[] =  new float[arr.length];
      for (int i = 0; i < arr.length; i++) { // Adding array to draw list
        temp[i] = arr[i];
      }
      arrays.add(temp);
    }
