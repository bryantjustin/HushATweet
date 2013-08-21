//
//  FTFLoginView.m
//  HushATweet
//
//  Created by Bryant Balatbat on 2013-08-20.
//  Copyright (c) 2013 Bryant Balatbat. All rights reserved.
//

#import "HATLoginView.h"

@implementation HATLoginView
{
    UIButton *loginButton;
}

#pragma mark - Synthesized properties

@synthesize delegate = _delegate;

#pragma mark - Convenience constructor

+ (id) view
{
    return [[self alloc] initWithFrame: CGRectZero andDelegate: nil];
}

+ (id) viewWithFrame: (CGRect)frame andDelegate: (id<HATLoginViewDelegate>)delegate;
{
    return [[self alloc] initWithFrame: frame andDelegate: delegate];
}

- (id) initWithFrame: (CGRect)frame andDelegate: (id<HATLoginViewDelegate>)delegate
{
    self = [super initWithFrame: frame];
    if( self ) {
        
        self.delegate = delegate;
        
        loginButton = [UIButton buttonWithType: UIButtonTypeRoundedRect];
        [loginButton setTitle: @"Login with Twitter" forState: UIControlStateNormal];
        [loginButton sizeToFit];
        [loginButton addTarget: self action: @selector( onLoginButtonTouchedUpInside ) forControlEvents: UIControlEventTouchUpInside];
        [self addSubview: loginButton];
        
    }
    
    return self;
}

- (void) layoutSubviews
{
    loginButton.frame = CGRectMake( CGRectGetMidX( self.frame ) - CGRectGetMidX( loginButton.frame ), CGRectGetMidY( self.frame ) - CGRectGetMidY( loginButton.frame ), CGRectGetWidth( loginButton.frame ), CGRectGetHeight( loginButton.frame ));
}

#pragma mark - Button handlers

- (void) onLoginButtonTouchedUpInside
{
    [self.delegate performLogin];
}
@end
