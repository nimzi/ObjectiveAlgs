//
//  AppDelegate.m
//  ObjectiveAlgs
//
//  Created by Paul Agron on 11/13/13.
//  Copyright (c) 2013 Paul Agron. All rights reserved.
//

#import "AppDelegate.h"
#import "Sorter.h"

static NSNumber* maxElement(NSArray* arr) {
    NSNumber* max = [NSNumber numberWithDouble:-INFINITY];
    for (NSNumber* n in arr) {
        if ([max doubleValue] < [n doubleValue]) max = n;
    }
    return max;
    
}

static NSNumber* minElement(NSArray* arr) {
    NSNumber* min = [NSNumber numberWithDouble:INFINITY];
    for (NSNumber* n in arr) {
        if ([min doubleValue] > [n doubleValue]) min = n;
    }
    return min;
    
}

@interface BarView : NSView
@property (nonatomic, strong) NSArray* bars;
@property (nonatomic, strong) NSIndexSet* markedIndexes;
@end

@implementation BarView
-(id) initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    [self setWantsLayer:YES];
    return self;
}

-(void) awakeFromNib {
    [self setWantsLayer:YES];
    _markedIndexes = [NSIndexSet new];
}

-(void) viewDidMoveToWindow {
    self.layer.backgroundColor = [NSColor blackColor].CGColor;
}

-(void) setBars:(NSArray *)bars {
    _bars = bars;
    double max = [maxElement(bars) doubleValue];
    double min = [minElement(bars) doubleValue];
    double range = max - min;
    NSSize size = [self bounds].size;

    NSUInteger sublayerCount = [self.layer.sublayers count];
    NSUInteger barCount = [_bars count];
    
    if (barCount != sublayerCount) {
        for (CALayer* l in [self.layer.sublayers copy]) {
            [l removeFromSuperlayer];
        }
        
        for (NSUInteger j=0;j<barCount;j++) {
            CALayer *l = [CALayer layer];
            [self.layer addSublayer:l];
        }
    }
    
    //[self setNeedsLayout:YES];
    
    [_bars enumerateObjectsUsingBlock:^(NSNumber* obj, NSUInteger idx, BOOL*stop) {
        double hSp = (size.width / [bars count]) * 0.07; // horizontal spacing
        hSp = MAX(2,hSp);
        
        double barHeight = (([obj doubleValue] - min) / range) * size.height;
        double barWidth = (size.width - (hSp * ([bars count] - 1))) / [bars count];
        
        CALayer *l = self.layer.sublayers[idx];
        l.frame = CGRectMake((barWidth + hSp)*idx, 0, barWidth, MAX(2,barHeight));
        l.backgroundColor = [NSColor colorWithCalibratedRed:1
                                                      green:.8
                                                       blue:0
                                                      alpha:1.0].CGColor;

    }];
}

-(void) setMarkedIndexes:(NSIndexSet *)markedIndexes {
    _markedIndexes = markedIndexes;
    [self.layer.sublayers enumerateObjectsUsingBlock:^(CALayer* obj, NSUInteger idx, BOOL*stop) {
        if ([_markedIndexes containsIndex:idx]) {
            obj.backgroundColor = [NSColor redColor].CGColor;
        }
    }];
}

-(void) layout {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    [super layout];
    if (self.inLiveResize) {
        [self setBars:_bars];
    }
}

-(void) viewDidEndLiveResize {
        [self setBars:_bars];
}

//
//-(void) layoutSublayersOfLayer:(CALayer *)layer {
//    NSLog(@"%@", NSStringFromSelector(_cmd));
//}
//
//-(void) layoutSubtreeIfNeeded {
//    NSLog(@"%@", NSStringFromSelector(_cmd));
//}
//
@end


#pragma mark -

static void applyInsertionSort(NSMutableArray* arr) {
    NSUInteger size = [arr count];
    
    for (NSUInteger i=1;i<size;i++) {
        
        for (NSUInteger j=0;j<i;j++) {
            NSNumber* __strong iNum = arr[i];
            NSNumber* __strong jNum = arr[j];
            if ( [jNum doubleValue] > [iNum doubleValue]) {
                [arr removeObjectAtIndex:i];
                [arr insertObject:iNum atIndex:j];
                break;
            }
        }
        //[arr exchangeObjectAtIndex:i withObjectAtIndex:maxIdx];
    }
    
    
}


@implementation AppDelegate {
    Sorter* _sorter;
}

+(NSString*) stringFromArray:(NSArray*)numbers {
    NSMutableString* output = [NSMutableString new];
    NSUInteger count = [numbers count];
    [numbers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [output appendString:[obj description]];
        if (idx < count - 1) [output appendString:@", "];
    }];
    return output;
}


-(IBAction)runSelectionSort:(id)sender {
    NSString* input = [_inputView string];
    NSArray* comps = [input componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSMutableArray* numbers = [NSMutableArray new];
    for (NSString* c in comps) {
        [numbers addObject: @([c doubleValue])];
    }
    
    [_outputView setString:[[self class] stringFromArray:numbers]];
    [_sorter selectionSortArray:numbers];
}

-(IBAction)runInsertionSort:(id)sender {
    NSString* input = [_inputView string];
    NSArray* comps = [input componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSMutableArray* numbers = [NSMutableArray new];
    for (NSString* c in comps) {
        [numbers addObject: @([c doubleValue])];
    }
    
    applyInsertionSort(numbers);
    
    [_outputView setString:[numbers description]];
    
    [_selectionBarView setBars:numbers];
    [_selectionBarView setNeedsLayout:YES];
}

-(void) didImproveArrayTo:(NSArray*)arr {
    [_selectionBarView setBars:arr];
//    [_selectionBarView setNeedsLayout:YES];
    //[_selectionBarView.layer layoutIfNeeded];
    NSString* s = [@"\n" stringByAppendingString:[[self class] stringFromArray:arr]];
    NSAttributedString* string = [[NSAttributedString alloc] initWithString:s attributes:nil];
    [_outputView.textStorage appendAttributedString:string];
    
    [_outputView scrollRangeToVisible:NSMakeRange([[_outputView string] length], 0)];
    [_outputView setNeedsDisplay:YES];
}

-(void) willSwapElementsAt:(NSIndexSet *)idxs {
    [_selectionBarView setMarkedIndexes:idxs];
}


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    _sorter = [Sorter new];
    _sorter.delegate = self;
    _inputView.string = @"64 5 26 7 9 8 4 12 2 1 16 10 22 29 55 63 37";
    //_selectionBarView;
}

-(void)dealloc {
//    [super dealloc];
}

@end
