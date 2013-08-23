//
//  LaunchView.m
//  HushATweet
//
//  Created by Bryant Balatbat on 2013-08-21.
//  Copyright (c) 2013 Bryant Balatbat. All rights reserved.
//

#import "HATLaunchView.h"

#pragma mark - Layout consants

#define BOTTOM_MARGIN_Y 10
#define SIDE_MARGIN_WIDTH 10
#define BUTTON_PADDING_HEIGHT 10

#pragma mark - 

@implementation HATLaunchView
{
    UIButton *viewProfileButton;
    UIButton *startGameNowButton;
    UIButton *startGameWithSearchButton;
    UIButton *logoutButton;
    
    NSArray *buttons;
}

#pragma mark - Synthesized properties

@synthesize delegate = _delegate;

#pragma mark - Constructors & Initializers

#pragma mark Convenience Constructors

+ (id) view
{
    return [[self alloc] initWithFrame: CGRectZero andDelegate: nil];
}

+ (id) viewWithFrame: (CGRect)frame andDelegate: (id<HATLaunchViewDelegate>)delegate;
{
    return [[self alloc] initWithFrame: frame andDelegate: delegate];
}

#pragma mark Initializers

- (id)initWithFrame:(CGRect)frame andDelegate: (id<HATLaunchViewDelegate>)delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = delegate;
        [self initButtons];
    }
    return self;
}

- (void) initButtons
{
    startGameNowButton = [self makeButtonWithTitle: @"Start a Game Now" andAction: @selector( onStartGameNowButtonTouchedUpInside )];
    startGameWithSearchButton = [self makeButtonWithTitle: @"Start a Game with a Phrase" andAction: @selector( onStartGameWithSearchButtonTouchedUpInside )];
    viewProfileButton = [self makeButtonWithTitle: @"View Profile" andAction: @selector( onViewProfileButtonTouchedUpInside )];
    logoutButton = [self makeButtonWithTitle: @"Logout from Twitter" andAction: @selector( onLogoutButtonTouchedUpInside )];
    
    buttons = @[ startGameNowButton, startGameWithSearchButton, viewProfileButton, logoutButton ];
}

#pragma mark - Button handlers

- (void) onStartGameNowButtonTouchedUpInside
{
    [self.delegate startGameNow];
}

- (void) onStartGameWithSearchButtonTouchedUpInside
{
    [self.delegate startGameWithSearch];
}

- (void) onViewProfileButtonTouchedUpInside
{
    [self.delegate viewProfile];
}

- (void) onLogoutButtonTouchedUpInside
{
    [self.delegate performLogout];
}

#pragma mark - Utility methods

- (UIButton *) makeButtonWithTitle: (NSString *)title andAction: (SEL)action
{
    UIButton *button = [UIButton buttonWithType: UIButtonTypeCustom];
    [button setBackgroundColor: [UIColor blackColor]];
    [button setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
    [button addTarget: self action: action forControlEvents: UIControlEventTouchUpInside];
    [button setTitle: title forState: UIControlStateNormal];
    [button.titleLabel setFont: [UIFont fontWithName: FONT_FAMILY_HELVETICA_BOLD size: FONT_SIZE_BUTTON]];
    [button sizeToFit];
    
    [self addSubview: button];
    return button;
}

#pragma mark - Layout subviews

- (void) layoutSubviews
{
    for( int i = 0; i < buttons.count; i++ ) {
        
        UIButton *button = [buttons objectAtIndex: i];
        CGFloat buttonWidth = CGRectGetWidth( self.frame ) - SIDE_MARGIN_WIDTH * 2;
        CGFloat buttonHeight = CGRectGetHeight( button.frame ) + BUTTON_PADDING_HEIGHT;
        button.frame = CGRectMake( CGRectGetMidX( self.frame ) - buttonWidth / 2, CGRectGetMaxY( self.frame ) - ( buttonHeight + BOTTOM_MARGIN_Y ) * ( buttons.count - i ), buttonWidth, buttonHeight );
        
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
