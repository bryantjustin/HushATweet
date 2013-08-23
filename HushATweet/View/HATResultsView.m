//
//  HATResultsView.m
//  HushATweet
//
//  Created by Bryant Balatbat on 2013-08-22.
//  Copyright (c) 2013 Bryant Balatbat. All rights reserved.
//

#import "HATResultsView.h"

#pragma mark - 

@implementation HATResultsView
{
    UILabel *hushTotalLabel;
    UILabel *hushTotalSubLabel;
    UILabel *scoreLabel;
    UILabel *scoreSubLabel;
    
    int hushTotal;
    int score;
}
#pragma mark - Synthesized properties

@synthesize delegate = _delegate;

+ (id) viewWithFrame: (CGRect)frame andDelegate: (id<HATResultsViewDelegate>)delegate withHushTotal:(int)hushTotal andScore:(int)score;
{
    return [[self alloc] initWithFrame: frame andDelegate: delegate withHushTotal: hushTotal andScore: score];
}

#pragma mark Initializers

- (id)initWithFrame:(CGRect)frame andDelegate: (id<HATResultsViewDelegate>)delegate withHushTotal:(int)hushTotal andScore:(int)score
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = delegate;
        [self initLabels];
    }
    return self;
}

- (void) initLabels
{
    hushTotalLabel = [self makeLabelWithText: [NSString stringWithFormat: @"%d", hushTotal] andSize: FONT_SIZE_HUSH_TOTAL_LABEL];
    hushTotalSubLabel = [self makeLabelWithText: @"TWEETS HUSHED." andSize: FONT_SIZE_HUSH_TOTAL_SUBLABEL];
    scoreLabel = [self makeLabelWithText: [NSString stringWithFormat: @"%d", score] andSize: FONT_SIZE_SCORE_LABEL];
    scoreSubLabel = [self makeLabelWithText: @"POINTS SCORED." andSize: FONT_SIZE_SCORE_SUBLABEL];
    
    [self addSubview: hushTotalLabel];
    [self addSubview: hushTotalSubLabel];
    [self addSubview: scoreLabel];
    [self addSubview: scoreSubLabel];
}

- (UILabel *) makeLabelWithText: (NSString *)text andSize: (CGFloat)size
{
    UILabel *label = [[UILabel alloc] init];
    [label setTextAlignment: NSTextAlignmentCenter];
    [label setTextColor: [UIColor blackColor]];
    [label setText: text];
    [label setFont: [UIFont fontWithName: FONT_FAMILY_HELVETICA_BOLD size: size]];
    [label sizeToFit];
    
    return label;
}

#pragma mark - Layout subviews

#define HUSH_TOTAL_LABEL_Y 20
- (void) layoutSubviews
{
    hushTotalLabel.frame = CGRectMake( CGRectGetMidX( self.frame ) - CGRectGetMidX( hushTotalLabel.frame ), HUSH_TOTAL_LABEL_Y, CGRectGetWidth( hushTotalLabel.frame ), CGRectGetHeight( hushTotalLabel.frame ));
    hushTotalSubLabel.frame = CGRectMake( CGRectGetMidX( self.frame ) - CGRectGetMidX( hushTotalSubLabel.frame ), CGRectGetMaxY( hushTotalLabel.frame ), CGRectGetWidth( hushTotalSubLabel.frame ), CGRectGetHeight( hushTotalSubLabel.frame ));
    scoreLabel.frame = CGRectMake( CGRectGetMidX( self.frame ) - CGRectGetMidX( scoreLabel.frame ), CGRectGetMaxY( hushTotalSubLabel.frame ), CGRectGetWidth( scoreLabel.frame ), CGRectGetHeight( scoreLabel.frame ));
    scoreSubLabel.frame = CGRectMake( CGRectGetMidX( self.frame ) - CGRectGetMidX( scoreSubLabel.frame ), CGRectGetMaxY( scoreLabel.frame ), CGRectGetWidth( scoreSubLabel.frame ), CGRectGetHeight( scoreSubLabel.frame ));
}

@end
