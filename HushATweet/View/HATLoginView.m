//
//  FTFLoginView.m
//  HushATweet
//
//  Created by Bryant Balatbat on 2013-08-20.
//  Copyright (c) 2013 Bryant Balatbat. All rights reserved.
//

#import "HATLoginView.h"

#pragma mark - Layout constants

#define BOTTOM_MARGIN_Y 10
#define SIDE_MARGIN_WIDTH 10
#define BUTTON_PADDING_HEIGHT 10

#pragma mark - 

@implementation HATLoginView
{
    UIButton *loginButton;
}

#pragma mark - Synthesized properties

@synthesize delegate = _delegate;

#pragma mark - Constructors & Initializers

#pragma mark Convenience Constructors

+ (id) view
{
    return [[self alloc] initWithFrame: CGRectZero andDelegate: nil];
}

+ (id) viewWithFrame: (CGRect)frame andDelegate: (id<HATLoginViewDelegate>)delegate;
{
    return [[self alloc] initWithFrame: frame andDelegate: delegate];
}

#pragma mark Initializers

- (id) initWithFrame: (CGRect)frame andDelegate: (id<HATLoginViewDelegate>)delegate
{
    self = [super initWithFrame: frame];
    if( self ) {
        
        self.delegate = delegate;
        
        loginButton = [UIButton buttonWithType: UIButtonTypeRoundedRect];
        [loginButton setTitle: @"Login with Twitter" forState: UIControlStateNormal];
        [loginButton setBackgroundColor: [UIColor blackColor]];
        [loginButton setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
        [loginButton.titleLabel setFont: [UIFont fontWithName: FONT_FAMILY_HELVETICA_BOLD size: FONT_SIZE_BUTTON]];
        [loginButton sizeToFit];
        [loginButton addTarget: self action: @selector( onLoginButtonTouchedUpInside ) forControlEvents: UIControlEventTouchUpInside];
        [self addSubview: loginButton];
        
    }
    
    return self;
}

#pragma mark - Button handlers

- (void) onLoginButtonTouchedUpInside
{
    [self.delegate performLogin];
}

#pragma mark - Layout subviews

- (void) layoutSubviews
{
    CGFloat buttonWidth = CGRectGetWidth( self.frame ) - SIDE_MARGIN_WIDTH * 2;
    CGFloat buttonHeight = CGRectGetHeight( loginButton.frame ) + BUTTON_PADDING_HEIGHT;
    loginButton.frame = CGRectMake( CGRectGetMidX( self.frame ) - buttonWidth / 2, CGRectGetMaxY( self.frame ) - buttonHeight - BOTTOM_MARGIN_Y, buttonWidth, buttonHeight );
}

@end
