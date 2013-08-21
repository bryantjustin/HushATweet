//
//  FTFViewController.m
//  HushATweet
//
//  Created by Bryant Balatbat on 2013-08-20.
//  Copyright (c) 2013 Bryant Balatbat. All rights reserved.
//

#import "FHSTwitterEngine.h"

#import "HATViewController.h"
#import "HATLoginView.h"

@implementation HATViewController
{
    HATLoginView *loginView;
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
    if( [FHSTwitterEngine sharedEngine].isAuthorized ) {
        
    } else {
        loginView = [HATLoginView viewWithFrame: self.view.bounds andDelegate: self];
        [self.view addSubview: loginView];
    }
}

- (void) viewDidAppear:(BOOL)animated
{
    
}

#pragma mark - HATLoginViewDelegate methods

- (void) performLogin
{
    [[FHSTwitterEngine sharedEngine]showOAuthLoginControllerFromViewController:self withCompletion:^(BOOL success) {
        NSLog( success ? @"L0L success": @"O noes!!! Loggen faylur!!!");
    }];
}

- (void) onPerformLoginComplete: (BOOL)success
{
    if( success ) {
        
    } else {
        NSLog( @"WARN: Twitter failed to authenticate." );
    }
}

@end
