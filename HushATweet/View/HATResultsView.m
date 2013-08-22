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
    
}

- (void) layoutSubviews
{
    
}

@end
