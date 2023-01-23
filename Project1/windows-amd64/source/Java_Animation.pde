/**
 * Group Members: Alyssa Gabrielson, Kyle McCann, Eleri Floyd
 * Shelby Deerman, Michael Honrine, Ryan Moddessette, Summer Davis
 *
 * Algorithm Functions -
 * Group Collaboration
 *
 * MergeSort & QuickSelect Animations - Processing Java
 * by Alyssa Gabrielson 
 *
 * Animated Merge Sort & Quick Sort Algorithms
 * Generates a random array to compare algorithm speeds
 * and visualize movement inside arrays
 *
 */
 
 import java.io.*;
 import java.util.List;
 import java.util.ArrayList;
 import java.util.Arrays;
 
String buffer = "";
String saved = "";
boolean mergesort = false;

int state = 0; // tracks current state; necessary because draw() is an infinite loop
long startTime = 0;
long endTime = 0;
long totalTime = 0;

int w = 30; // width for bars, larger width means less numbers in array
int x = 0; // used to draw intermittent arrays
int y = 0; // used to draw intermittent arrays
int z = 0; // used to draw final array
float numHeight = 0; // used to place numbers at correct height on or above bar
int delay = 0; // used to delay repeat menu

int k = 0; // k integers from user

float original[];
float random[];  
ArrayList<float[]> arrays = new ArrayList<float[]>();
 
 // This function fills the background
void setup() {
  size(840, 500); // Window size. Small: (840, 500). Medium: (1200, 720).
  textSize(32);
  frameRate(40); // Decrease to slow down animation, increase to speed up
  
  random = new float[floor((width/w))]; // Initializing random array
  original = new float[floor((width/w))]; // Keeping original array incase user wants to directly compare sorts
  
  for (int i = 0; i < random.length; i++) {
      random[i] = random(height);
      original[i] = random[i];
  }
}
  
// This function loops to display things on the screen
// Uses different states to decide what will be looping to the display, 0-4 states total
void draw() {
  if (state == 0) { // state 0: User chooses Merge Sort or Quick Select animation
    background(0);
    textAlign(CENTER, CENTER);
    text("Top K Integers - Processing Java", width/2, 30);
    text("Click in this window to start typing. \nFirst, type in K between 1 and " + (random.length -1)+ ", then press enter.", width/2, 100);
    text("Next, Press M for Merge Sort then press enter.", width/2, 200);
    text("Or, press Q for Quick Select then press enter.", width/2, 250);
    text("(Restart the program to get a new random array)", width/2, 350);
    text("Please do not hit backspace -- it breaks the program", width/2, 400);
    text("Input: " + buffer, width/2, 450);
  }
  
  // state 1: Array sorting
  else if (state == 1) { 
    background(0);
    
    // Resets array to unsorted array if necessary
    if(delay == -1) {
      for (int i = 0; i < random.length; i++) {
        random[i] = original[i];
      }
      arrays.clear();
      z = 0;
      delay = 0;
    }
    
    // Draw initial unsorted array
    for (int i = 0; i < random.length; i++) {
      stroke(51);
      fill(198, 165, 201); // color bars purple
      rect(i*w, height - random[i], w, random[i]);
      fill(255); // color text white
      textSize(16);
      
      checkHeight(random[i]);
      textAlign(LEFT, LEFT);
      text(" " + round(random[i]) + " ", i*w, numHeight);
    }
    
    stroke(0);
    fill(255); // Color text white
    textSize(64);
    textAlign(CENTER, CENTER);
    text("Unsorted Array", width/2,60);
    
    // Sort the array
    startTime = System.nanoTime();
    if (mergesort)
      MergeSort(random, 0, random.length - 1);
    else
      findK(random, 0, random.length - 1, random.length - k);  
    endTime = System.nanoTime();
    totalTime = endTime - startTime;
    
    state = 2;
  }
  // State 2: Delay to show unsorted array
  else if (state == 2) { 
    delay(2000);
    state = 3;
  }
  
  // State 3 Block
  // Break from loop in state 3, move to state 4
  else if (x >= arrays.size() - 1) {
    x = 0;
    y = 0;
    state = 4;
  }
  else if (y >= arrays.get(x).length) { // Loop in state 3
    x++;
    y = 0;
    state = 3;
  }
  // State 3: Drawing intermittent arrays
  else if (state == 3) {
    fill(0);
    rect(y*w, 0, w, height);
    fill(198, 165, 201); // Color bars purple
    rect(y*w, height - arrays.get(x)[y], w, arrays.get(x)[y]);
    textSize(16);
    fill(255); // Color text white
    
    checkHeight(arrays.get(x)[y]);
    textAlign(LEFT, LEFT);
    text(" " + round(arrays.get(x)[y]) + " ", y*w, numHeight);
    
    y++;
  }
  
  // State 4 Block
  // Break loop in state 4, display results
  else if (z >= random.length) {
    if (delay > 0) {
      text("Press enter to continue", 30, 300);
    }
    delay(2000);
    if(delay == 0)
      background(0);
    textSize(32);
    
    // Display top K integers and total time
    text("Top k = " + k + " integers: ",30, 100);
    for (int i = random.length - k, j = 30, newline = 0, tracker = 0; i < random.length; i++, tracker++){
        if(tracker % 10 == 0) { // wrap around k integers if the list is too long
          newline+= 35;
          j = 30;
        }
        if (i == random.length - 1) // no comma
          text(round(random[i]), j, 150 + newline);
        else
          text(round(random[i]) + ", ", j, 150 + newline);
        j+=75;
    }
    
    text("Total time to get top K integers: " + totalTime + " nanoseconds.", 30, 400);
    ++delay;
    text("Press enter to continue", 30, 300);
  }
  // State 4: Draw the final sorted array
  else if (state == 4) {
    fill(0);
    rect(z*w, 0, w, height);
    fill(198, 165, 201); // Color bars purple
    rect(z*w, height - random[z], w, random[z]);
    textSize(16);
    fill(255); // Color text white
    
    checkHeight(random[z]);
    textAlign(LEFT, LEFT);
    text(" " + round(random[z]) + " ", z*w, numHeight);
    
    z++;
  }
}

// This function takes keyboard input
void keyTyped(){
  if (state == 0 && key == '\n') { // Takes user input of K and which algorithm to animate
    saved = buffer;
    buffer = "";
    if (saved.equals("M") || saved.equals("m")) { // Random state
      mergesort = true;
      state = 1;
    }
    else if (saved.equals("Q") || saved.equals("q")) {
      mergesort = false;
      state = 1;
    }
    else if (isNumeric(saved)) {
      k = Integer.parseInt(saved);
    }
  }
  else if (delay > 0 && key == '\n') { // Restart program, keeps original array
    delay = -1;
    state = 0;
  }
  else { // keeps track of whats currently being typed before pressing enter
    buffer = buffer + key;
  }
}

void update(float arr[]) { // Adds arrays to the list to be drawn
  float temp[] =  new float[arr.length];
  for (int i = 0; i < arr.length; i++) { // Adding array to draw list
    temp[i] = arr[i];
  }
  if((arrays.size() > 1) && (Arrays.equals(arrays.get(arrays.size()-1), temp))); // skip any side-by-side duplicate arrays
    arrays.add(temp);
}

// Checks if string contains an integer
boolean isNumeric(String str) {
  try {  
    Integer.parseInt(str);  
    return true;
  } catch(NumberFormatException e){  
    return false;  
  }  
}

// Checks number height for placement above or below bar
void checkHeight(float num) {
  if (round(num) < 25) // Place number above bar if too short
    numHeight = height - num - 10;
  else
    numHeight = height - num + 20;
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
void MergeSort(float a[], int left, int right) { // ,int offset) 
  if (left >= right){
    return;
  }
  
  int midpt;
  
  midpt = left + ((right - left) / 2);
  MergeSort(a, left, midpt);
  MergeSort(a, midpt + 1, right);
  
  merge(a, left, midpt, right);
  
  update(a); // Adds array to the list to be drawn
}

// ===================================================================================================

//  Quick Select Functions
//  By Kyle McCann

void swap(float a[], int first, int second) {
    float temp = a[first];
    a[first] = a[second];
    a[second] = temp;
}

int partition(float a[], int left, int right)
{
    float x = a[right];
    int i = left;

    for (int j = left; j <= right - 1; j++) {
        if (a[j] < x) {
            swap(a, i, j);
            i++;
        }
    }
    swap(a, i, right);
    return i;
}

float findK(float arr[], int left, int right, int k)
{
    int index = partition(arr, left, right);

    if (index - left == k - 1) {
        update(arr);
        return index;
    }

    if (index - left > k - 1) {
        update(arr);
        return findK(arr, left, index - 1, k);
    }
    update(arr); // Adds array to the list to be drawn
    return findK(arr, index + 1, right, k - index + left - 1);
}
