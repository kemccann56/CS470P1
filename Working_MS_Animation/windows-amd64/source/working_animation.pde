/**
 * MergeSort Visualization - Java
 * by Alyssa Gabrielson 
 * 
 * Currently only displays the Merge Sort algorithm
 * I want to color the left, mid, and right indexes but not sure how
 *
 * Width of the bars and amount of numbers in the array can be changed
 * just by changing the "w" variable below, but the numbers at the
 * top won't adjust their size to match yet
 *
 * Still need to implement Quick Select
 * 
 */
 
 import java.io.*;
 import java.util.List;
 import java.util.ArrayList;
 import java.util.Arrays;
 
String buffer = "";
String saved = "";

int state = 0; // tracks current state; necessary because draw() is an infinite loop
long startTime = 0;
long endTime = 0;
long totalTime = 0;

int w = 30; // width for bars, larger width means less numbers in array
int x = 0; // used to draw intermittent arrays
int y = 0; // used to draw intermittent arrays
int z = 0; // used to draw final array

float array[];
float random[];  
ArrayList<Integer> colors = new ArrayList<Integer>();
ArrayList<float[]> arrays = new ArrayList<float[]>();
 
 // This function fills the background
void setup() {
  size(852, 480);
  textSize(32);
  frameRate(60);
  
  random = new float[floor((width/w))]; // Initializing random array
  
  for (int i = 0; i < random.length; i++) {
      random[i] = random(height);
      colors.add(i, -1);
  }
}

// This function loops to display things on the screen
// I use different states to decide what will be looping to display
void draw() {
  if (state == 0) { // state 0: Wait for user to be ready for array
    background(0);
    
    text("Click in this window to start typing. \nPress 1 and hit enter for a random array.", 50, 100);
    text("Input: " + buffer, 50, 400);
  }
  else if (state == 1) { // state 1: Array sorting
    background(0);
    
    // Draw Initial Unsorted Array
    for (int i = 0; i < random.length; i++) {
      stroke(51);
      fill(255);
      rect(i*w, height - random[i], w, random[i]);
      fill(198, 165, 201);
      textSize(16);
      text(" " + round(random[i]) + " ", i*w, w);
    }
    
    stroke(0);
    fill(85, 71, 87);
    textSize(60);
    text("Unsorted Array", 200, 400);
    
    // Sort the Array
    startTime = System.nanoTime();
    System.out.println("Start time: " + startTime);
    sort(random, 0, random.length - 1);
    endTime = System.nanoTime();
    System.out.println("End time: " + endTime);
    totalTime = endTime - startTime;
    
    state = 2;
  }
  else if (state == 2) { // state 2: Delay to show unsorted array
    delay(3000);
    state = 5;
  }
  else if (x >= arrays.size() - 1) { // break from loop
    x = 0;
    y = 0; // this might cause a bug if y >= arrays.get(x).length happen to both equal 0
    state = 6;
  }
  else if (y >= arrays.get(x).length) { // next loop
    x++;
    System.out.println("x is: " + x);
    y = 0;
    state = 5;
    System.out.println("state is: " + state);
  }
  else if (state == 5) { // state 5: Drawing intermittent arrays
    fill(0);
    rect(y*w, 0, w, height);
    fill(255);
    rect(y*w, height - arrays.get(x)[y], w, arrays.get(x)[y]);
    textSize(16);
    fill(198, 165, 201);
    text(" " + round(arrays.get(x)[y]) + " ", y*w, w);
    y++;
  }
  else if (z >= random.length) {
    delay(2000);
    background(0);
    textSize(32);
    text("Merge Sort Function total time: " + totalTime + " nanoseconds.", 50, 100);
    // Not yet implemeneted:
    // text("Click on this window to start typing. \nPress 2 and hit enter to show the Quick Select animation.", 50, 200);
  }
  else if (state == 6) { // state 6: Draw the final sorted array
    // Draw Final Sorted Array
    fill(0);
    rect(z*w, 0, w, height);
    fill(255); // Color white
    rect(z*w, height - random[z], w, random[z]);
    textSize(16);
    fill(198, 165, 201);
    text(" " + round(random[z]) + " ", z*w, w);
    z++;
  }
}

// This function takes keyboard input
void keyTyped(){
  if (state == 0 && key == '\n') { // Decides which mode. Press 1 = random array, Press 2 = custom array
    saved = buffer;
    buffer = "";
    
    if (saved.equals("1")) { // Random state
      state = 1;
    }
    else if (saved.equals("2")) { // Custom state
      state = 7;
    }
  }
  else { // keeps track of whats currently being typed before pressing enter
    buffer = buffer + key;
  }
}

void update(float arr[]) { // adds arrays to the list to be drawn
  float temp[] =  new float[arr.length];
  for (int i = 0; i < arr.length; i++) { // Adding array to draw list
    temp[i] = arr[i];
  }
  if((arrays.size() > 1) && (Arrays.equals(arrays.get(arrays.size()-1), temp))); // skip any side-by-side duplicate arrays
    arrays.add(temp);
}

// ===================================================================================================

//   MergeSort Function
//   By Kyle McCann

void merge(float a[], int left, int midpt, int right) { 
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
 
    // Main function that sorts array using
    // merge()
void sort(float a[], int left, int right) { // ,int offset) 
  if (left >= right){
    return;
  }
  
  int midpt;
  
  midpt = left + ((right - left) / 2);
  sort(a, left, midpt);
  sort(a, midpt + 1, right);
  
  merge(a, left, midpt, right);
  
  update(a); // adds arrays to the list to be drawn
}
