//
//  NHAssistedNotebookView.m
//  NoteHub
//
//  Created by Mateo Olaya Bernal on 8/13/14.
//  Copyright (c) 2014 Mateo Olaya Bernal. All rights reserved.
//

#import "NHAssistedNotebookView.h"

@implementation NHAssistedNotebookView
@synthesize lineColor;
@synthesize lineWidth;
@synthesize empty;
@synthesize currentPoint;
@synthesize previousPoint;
@synthesize previousPreviousPoint;
@synthesize style;
@synthesize drawable;

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        self.backgroundColor = UIColorFromRGB(0xfdfbe9);
        
        _path = CGPathCreateMutable();
        lineWidth = DEFAULT_WIDTH;
        lineColor = DEFAULT_COLOR;
        empty = YES;
        
        [self initialize];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = DEFAULT_BACKGROUND_COLOR;
        
        _path = CGPathCreateMutable();
        lineWidth = DEFAULT_WIDTH;
        lineColor = DEFAULT_COLOR;
        empty = YES;
    }
    
    return self;
}

- (void)initialize {
    [self setDelegate:self];
    [self setMargins:UIEdgeInsetsMake(0, 45, 0, 0)];
    
    style = NHAssistedNotebookPatternStriped;
    
    drawable = YES;
    
    self.text = @"Hola?= Mundo";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didTextChange:) name:UITextViewTextDidChangeNotification object:nil];
    
    [self updateStyle];
}

- (void)didTextChange:(id)sender {
    [self updateStyle];
}

- (void)updateStyle {
    [self setFont:[UIFont fontWithName:@"EuphemiaUCAS" size:25]];
}

- (void)updateAttributedText:(NSAttributedString *) attributedString {
    self.scrollEnabled = NO;
    NSRange selectedRange = self.selectedRange;
    self.attributedText = attributedString;
    self.selectedRange = selectedRange;
    self.scrollEnabled = YES;
}

- (void)drawRect:(CGRect)rect {
    [self.backgroundColor set];
    
    UIRectFill(rect);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Se crea el fondo y rayado de la nota
    
    if (style != NHAssistedNotebookPatternFlat) {
        CGContextBeginPath(context);
        
        CGContextSetLineWidth(context, 1.0f);
        CGContextSetLineCap(context, kCGLineCapSquare);
        
        for (int i = 0; i < self.bounds.size.height; i += 35) {
            CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
            CGContextMoveToPoint(context, 0 - _margins.left, (i + 1) - _margins.left);
            CGContextAddLineToPoint(context, self.bounds.size.width, (i + 1) - _margins.left);
            
            CGContextStrokePath(context);
            
            CGContextSetStrokeColorWithColor(context, UIColorFromRGB(0xebe8d7).CGColor);
            CGContextMoveToPoint(context, 0 - _margins.left, i - _margins.left);
            CGContextAddLineToPoint(context, self.bounds.size.width, i - _margins.left);
            
            CGContextStrokePath(context);
            
            
            
            if (style == NHAssistedNotebookPatternGridded) {
                for (int j = 0; j < self.bounds.size.width; j += 35) {
                    CGContextSetStrokeColorWithColor(context, UIColorFromRGB(0xebe8d7).CGColor);
                    CGContextMoveToPoint(context, j, i);
                    CGContextAddLineToPoint(context, j, self.bounds.size.height);
                    CGContextStrokePath(context);
                }
            } else if (style == NHAssistedNotebookPatternStriped) {
                CGContextSetStrokeColorWithColor(context, UIColorFromRGB(0xf4d8c2).CGColor);
                
                CGContextMoveToPoint(context, 40 - _margins.left, 0);
                CGContextAddLineToPoint(context, 40 - _margins.left, self.bounds.size.height);
                
                CGContextMoveToPoint(context, 45 - _margins.left, 0);
                CGContextAddLineToPoint(context, 45 - _margins.left, self.bounds.size.height);
                
                CGContextStrokePath(context);
            }
        }
        
        
    }
    
    
    CGContextBeginPath(context);
    CGContextAddPath(context, _path);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, lineWidth);
    CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
    
    CGContextStrokePath(context);
    
    empty = NO;
}

- (void)update {
    [self setNeedsDisplay];
}

-(void)dealloc {
    CGPathRelease(_path);
}

CGPoint midPoint(CGPoint p1, CGPoint p2) {
    return CGPointMake((p1.x + p2.x) * 0.5, (p1.y + p2.y) * 0.5);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (drawable) {
        [self setScrollEnabled:NO];
    } else {
        [self setScrollEnabled:YES];
    }
    
    UITouch *touch = [touches anyObject];
    

    previousPoint = [touch previousLocationInView:self];
    previousPreviousPoint = [touch previousLocationInView:self];
    currentPoint = [touch locationInView:self];
    

    [self touchesMoved:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    
    if (!drawable) {
        return;
    }
    
    CGPoint point = [touch locationInView:self];
    
    // if the finger has moved less than the min dist ...
    CGFloat dx = point.x - self.currentPoint.x;
    CGFloat dy = point.y - self.currentPoint.y;
    
    if ((dx * dx + dy * dy) < kPointMinDistanceSquared) {
        // ... then ignore this movement
        return;
    }
    
    // update points: previousPrevious -> mid1 -> previous -> mid2 -> current
    previousPreviousPoint = previousPoint;
    previousPoint = [touch previousLocationInView:self];
    currentPoint = [touch locationInView:self];
    
    CGPoint mid1 = midPoint(self.previousPoint, self.previousPreviousPoint);
    CGPoint mid2 = midPoint(self.currentPoint, self.previousPoint);
    
    // to represent the finger movement, create a new path segment,
    // a quadratic bezier path from mid1 to mid2, using previous as a control point
    CGMutablePathRef subpath = CGPathCreateMutable();
    CGPathMoveToPoint(subpath, NULL, mid1.x, mid1.y);
    CGPathAddQuadCurveToPoint(subpath, NULL,
                              self.previousPoint.x, self.previousPoint.y,
                              mid2.x, mid2.y);
    
    // compute the rect containing the new segment plus padding for drawn line
    CGRect bounds = CGPathGetBoundingBox(subpath);
    CGRect drawBox = CGRectInset(bounds, -2.0 * self.lineWidth, -2.0 * self.lineWidth);
    
    // append the quad curve to the accumulated path so far.
    CGPathAddPath(_path, NULL, subpath);
    CGPathRelease(subpath);
    
    [self setNeedsDisplayInRect:drawBox];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self setNeedsDisplay];
}

- (void)setMargins:(UIEdgeInsets)margins
{
    _margins = margins;
    
    self.contentInset = (UIEdgeInsets) {
        .top = self.margins.top,
        .left = self.margins.left,
        .bottom = self.margins.bottom,
        .right = self.margins.right - self.margins.left
    };
    
    [self setContentSize:self.contentSize];
}

#pragma mark interface

-(void)clear {
    CGMutablePathRef oldPath = _path;
    CFRelease(oldPath);
    
    _path = CGPathCreateMutable();
    
    [self setNeedsDisplay];
}

@end
