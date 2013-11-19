//
//  AppDelegate.h
//  ObjectiveAlgs
//
//  Created by Paul Agron on 11/13/13.
//  Copyright (c) 2013 Paul Agron. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Sorter.h"

@class BarView;
@interface AppDelegate : NSObject <NSApplicationDelegate, SorterDelegate>

@property (assign) IBOutlet NSWindow* window;
@property (assign) IBOutlet NSTextView* inputView;
@property (assign) IBOutlet NSTextView* outputView;
@property (assign) IBOutlet BarView* selectionBarView;

-(IBAction)runSelectionSort:(id)sender;
-(IBAction)runInsertionSort:(id)sender;
@end
