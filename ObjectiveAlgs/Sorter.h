//
//  Sorter.h
//  ObjectiveAlgs
//
//  Created by Paul Agron on 11/18/13.
//  Copyright (c) 2013 Paul Agron. All rights reserved.
//


@protocol SorterDelegate <NSObject>
-(void) didImproveArrayTo:(NSArray*)arr;
-(void) willSwapElementsAt:(NSIndexSet*)idxs;
@end

@interface Sorter : NSObject
@property (weak) id<SorterDelegate> delegate;

-(void) selectionSortArray:(NSArray*)arr;
-(void) quickSortArray:(NSArray*)arr;
//-(void) insertionSortArray:(NSArray*)arr;


@end
