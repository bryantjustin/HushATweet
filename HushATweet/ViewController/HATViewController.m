//
//  FTFViewController.m
//  HushATweet
//
//  Created by Bryant Balatbat on 2013-08-20.
//  Copyright (c) 2013 Bryant Balatbat. All rights reserved.
//

#import "FHSTwitterEngine.h"

#import "HATViewController.h"

#import "HATGameView.h"
#import "HATLoginView.h"
#import "HATLaunchView.h"

@implementation HATViewController
{
    HATLoginView *loginView;
    HATLaunchView *launchView;
    HATGameView *gameView;
}

#pragma mark - Synthesized properties


#pragma mark - UIViewController methods

- (void) loadView
{
    [[FHSTwitterEngine sharedEngine] permanentlySetConsumerKey: CONSUMER_KEY andSecret: CONSUMER_SECRET];
    [super loadView];
}

- (void) viewDidLoad
{
    // For iOS 7
    
    if( [self respondsToSelector: @selector( setNeedsStatusBarAppearanceUpdate )] ) {
        
        [self prefersStatusBarHidden];
        [self performSelector: @selector( setNeedsStatusBarAppearanceUpdate )];
        
    // For iOS 6
        
    } else {
        
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
        
    }
    
    // Determine if user should be prompted for authentication.
    
    if( [FHSTwitterEngine sharedEngine].isAuthorized ) {
        [self openLaunchView];
    } else {
        [self openLoginView];
    }
}

- (BOOL) prefersStatusBarHidden
{
    return YES;
}

- (void) viewDidAppear:(BOOL)animated
{
    
}

#pragma mark - HATLoginViewDelegate methods

- (void) performLogin
{
    __weak HATViewController *viewController = self;
    [[FHSTwitterEngine sharedEngine] showOAuthLoginControllerFromViewController:self withCompletion: ^(BOOL success) {
        [viewController onPerformLoginComplete: success];
    }];
}

- (void) onPerformLoginComplete: (BOOL)success
{
    if( success ) {
        
        [loginView removeFromSuperview];
        [self openLaunchView];
        
    } else {
        
        NSLog( @"WARN: Twitter failed to authenticate." );
        [[[UIAlertView alloc] initWithTitle: @"Login Error!" message:@"You must be logged in to Twitter to use this app." delegate: self cancelButtonTitle: @"OK" otherButtonTitles: nil] show];
        
    }
}

#pragma mark - HATLaunchViewDelegate methods

- (void) startGameNow
{
    [self openGameViewWithSearchPrompt: NO];
    [self closeViewByFadeOut: launchView];
}

- (void) startGameWithSearch
{
    [self openGameViewWithSearchPrompt: YES];
    [self closeViewByFadeOut: launchView];
}

- (void) viewProfile
{
    
}

- (void) performLogout
{
    
}

#pragma mark - View presentation methods

- (void) openLoginView
{
    loginView = [HATLoginView viewWithFrame: self.view.bounds andDelegate: self];
    [self.view addSubview: loginView];
}

- (void) openLaunchView
{
    launchView = [HATLaunchView viewWithFrame: self.view.bounds andDelegate: self];
    [self.view addSubview: launchView];
}

- (void) openGameViewWithSearchPrompt: (BOOL)shouldPromptSearch
{
    gameView = [HATGameView viewWithFrame: self.view.bounds andShouldPromptSearch: shouldPromptSearch];
    [self.view addSubview: gameView];
}

- (void) closeViewByFadeOut: (UIView *)closingView
{
    [UIView animateWithDuration: 1.0 animations: ^(void) {
        [closingView setAlpha: 0.0f];
    } completion: ^(BOOL completion) {
        [closingView removeFromSuperview];
    }];
}
#pragma mark - Utility methods

@end
