//
//  NHAssistedNotebookView.h
//  NoteHub
//
//  Created by Mateo Olaya Bernal on 8/13/14.
//  Copyright (c) 2014 Mateo Olaya Bernal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#define DEFAULT_COLOR               [UIColor blackColor]
#define DEFAULT_WIDTH               2.0f
#define DEFAULT_BACKGROUND_COLOR    [UIColor whiteColor]

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

static const CGFloat kPointMinDistance = 2.5f;
static const CGFloat kPointMinDistanceSquared = kPointMinDistance * kPointMinDistance;

typedef enum {
    NHAssistedNotebookPatternGridded,
    NHAssistedNotebookPatternStriped,
    NHAssistedNotebookPatternFlat
} NHAssistedNotebookPatternStyle;

@interface NHAssistedNotebookView : UITextView <UITextViewDelegate>
{
    @protected
    CGMutablePathRef _path;
}

@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign) NHAssistedNotebookPatternStyle style;
@property (nonatomic, assign) UIEdgeInsets margins;
@property (nonatomic, assign, getter=isDrawable) BOOL drawable;

@property (nonatomic, assign, readonly) BOOL empty;
@property (nonatomic, assign, readonly) CGPoint currentPoint;
@property (nonatomic, assign, readonly) CGPoint previousPoint;
@property (nonatomic, assign, readonly) CGPoint previousPreviousPoint;

- (void)clear;
- (void)update;
- (void)setMargins:(UIEdgeInsets)margins;

@end
