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
    if (!_sorting) {
        _sorting=YES;
        [NSThread detachNewThreadSelector:@selector(_insertionSortArray:) toTarget:self withObject:arr];
    }
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

-(void) _insertionSortArray:(NSArray*)arr {
    _sorting = NO;
}



@end
