//
//  Sorter.m
//  ObjectiveAlgs
//
//  Created by Paul Agron on 11/18/13.
//  Copyright (c) 2013 Paul Agron. All rights reserved.
//

#import "Sorter.h"

@implementation Sorter {
    BOOL _sorting;
}


-(void) selectionSortArray:(NSArray*)arr {
    if (!_sorting) {
        _sorting = YES;
        [NSThread detachNewThreadSelector:@selector(_selectionSortArray:) toTarget:self withObject:arr];
    }
    
}

-(void) insertionSortArray:(NSArray*)arr {
//    if (!_sorting) {
//        _sorting=YES;
//        [NSThread detachNewThreadSelector:@selector(_insertionSortArray:) toTarget:self withObject:arr];
//    }
}

-(void) _selectionSortArray:(NSArray*)input {
    NSMutableArray* arr = [input mutableCopy];
    NSUInteger size = [arr count];
    
    for (NSUInteger i=0;i<size;i++) {
        NSUInteger minIdx = i;
        for (NSUInteger j=i + 1;j<size;j++) {
            NSNumber* minNum = arr[minIdx];
            NSNumber* jNum = arr[j];
            if ( [jNum doubleValue] < [minNum doubleValue]) { minIdx = j; }
        }
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            NSMutableIndexSet* iset = [NSMutableIndexSet new];
            [iset addIndex:i];
            [iset addIndex:minIdx];
            [_delegate willSwapElementsAt:iset];
        }];
        
        
        [NSThread sleepForTimeInterval:1.5];
        [arr exchangeObjectAtIndex:i withObjectAtIndex:minIdx];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [_delegate didImproveArrayTo:[arr copy]];
        }];
    }
    
    _sorting = NO;
}

//-(void) _insertionSortArray:(NSArray*)arr {
//    _sorting = NO;
//}


#pragma mark - QuickSort Impl

-(NSUInteger) partitionSubArray:(NSMutableArray*)arr
                  fromLeftIndex:(NSUInteger)left
                   toRightIndex:(NSUInteger)right
             aroundPivotAtIndex:(NSUInteger)pivotIndex
{
//    if (left == right) return left;
    
    double threadSleepInterval = 0.2;
    
    NSNumber* pivotValue = arr[pivotIndex];
    [arr exchangeObjectAtIndex:pivotIndex withObjectAtIndex:right];
    NSUInteger storeIndex = left;
    for (NSUInteger i=left;i<right;i++) {
        if ([arr[i] doubleValue] <= [pivotValue doubleValue]) {
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                NSMutableIndexSet* iset = [NSMutableIndexSet new];
                [iset addIndex:i];
                [iset addIndex:storeIndex];
                [_delegate willSwapElementsAt:iset];
            }];
            
            [NSThread sleepForTimeInterval:threadSleepInterval];
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [_delegate didImproveArrayTo:[arr copy]];
            }];


            [arr exchangeObjectAtIndex:i withObjectAtIndex:storeIndex];
            storeIndex++;
        }
    }
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        NSMutableIndexSet* iset = [NSMutableIndexSet new];
        [iset addIndex:storeIndex];
        [iset addIndex:right];
        [_delegate willSwapElementsAt:iset];
    }];
    
    [NSThread sleepForTimeInterval:threadSleepInterval];
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [_delegate didImproveArrayTo:[arr copy]];
    }];


    
    [arr exchangeObjectAtIndex:storeIndex withObjectAtIndex:right];
    
    return storeIndex;
}

-(void) _quicksortSubArray:(NSMutableArray*)array
             fromLeftIndex:(NSUInteger)left
              toRightIndex:(NSUInteger)right
{
    // If the list has 2 or more items
    if (left < right) {
        //choose any pivotIndex such that left ≤ pivotIndex ≤ right
        NSUInteger pivotIndex = round(left + drand48() * (right - left));
        // Get lists of bigger and smaller items and final position of pivot
        NSUInteger pivotNewIndex = [self partitionSubArray:array
                                             fromLeftIndex:left
                                              toRightIndex:right
                                        aroundPivotAtIndex:pivotIndex];
        
        // Recursively sort elements smaller than the pivot
        if (pivotNewIndex > 0) {
            [self _quicksortSubArray:array fromLeftIndex:left toRightIndex:pivotNewIndex - 1];
//            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                [_delegate didImproveArrayTo:[array copy]];
//            }];
        
        
            
        }

        // Recursively sort elements at least as big as the pivot
        if (pivotNewIndex < right) {
            [self _quicksortSubArray:array fromLeftIndex:pivotNewIndex + 1 toRightIndex:right];
//            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                [_delegate didImproveArrayTo:[array copy]];
//            }];
            
            
        }

        
    }
}

-(void) quickSortArray:(NSArray*)arr {
    if (!_sorting) {
        _sorting = YES;
        [NSThread detachNewThreadSelector:@selector(_quickSortArray:) toTarget:self withObject:arr];
    }
}

-(void) _quickSortArray:(NSArray*)arr {
    [self _quicksortSubArray:[arr mutableCopy]
               fromLeftIndex:0
                toRightIndex:[arr count]-1];
    _sorting = NO;
}



@end
