//
//  main.m
//  ObjectiveAlgs
//
//  Created by Paul Agron on 11/13/13.
//  Copyright (c) 2013 Paul Agron. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <time.h>
#import <sys/types.h>
/*
NSUInteger partition(NSMutableArray* arr, NSUInteger left, NSUInteger right, NSUInteger pivotIndex) {
    NSNumber* pivotValue = arr[pivotIndex];
    [arr exchangeObjectAtIndex:pivotIndex withObjectAtIndex:right];
    NSUInteger storeIndex = left;
    for (NSUInteger i=left;i<right;i++) {
        if ([arr[i] doubleValue] <= [pivotValue doubleValue]) {
            [arr exchangeObjectAtIndex:i withObjectAtIndex:storeIndex];
            storeIndex++;
        }
    }
    [arr exchangeObjectAtIndex:storeIndex withObjectAtIndex:right];
    return storeIndex;
}

void quicksort(NSMutableArray* array, NSUInteger left, NSUInteger right) {
    // If the list has 2 or more items
    if (left < right) {
        //choose any pivotIndex such that left ≤ pivotIndex ≤ right
        NSUInteger pivotIndex = left;
        // Get lists of bigger and smaller items and final position of pivot
        NSUInteger pivotNewIndex = partition(array, left, right, pivotIndex);
        // Recursively sort elements smaller than the pivot
        quicksort(array, left, pivotNewIndex - 1);
        // Recursively sort elements at least as big as the pivot
        quicksort(array, pivotNewIndex + 1, right);
    }
}*/


int main(int argc, const char * argv[])
{
    time_t t;
    (void) time(&t);
    srand48((long) t);
    
   /*
    NSLog(@"---------------- partitioning");
    NSMutableArray* arr = [@[@25, @7, @55, @32, @16, @29, @2] mutableCopy];
    NSLog(@"before: %@", [arr description]);
    partition(arr, 0, 6, 1);
    NSLog(@"after: %@", [arr description]);
    
    NSLog(@"---------------- sorting");
    NSMutableArray* arr2 = [@[@25, @7, @55, @32, @16, @29, @2, @11, @40] mutableCopy];
    NSLog(@"before: %@", [arr2 description]);
    quicksort(arr2, 0, [arr2 count] - 1);
    NSLog(@"after: %@", [arr2 description]);
    */


    
    
    return NSApplicationMain(argc, argv);
}
