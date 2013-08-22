//
//  LaunchView.h
//  HushATweet
//
//  Created by Bryant Balatbat on 2013-08-21.
//  Copyright (c) 2013 Bryant Balatbat. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HATLaunchViewDelegate <NSObject>

- (void) startGameNow;
- (void) startGameWithSearch;
- (void) viewProfile;
- (void) performLogout;

@end

@interface HATLaunchView : UIView

@property (weak, nonatomic) id<HATLaunchViewDelegate> delegate;

+ (id) view;
+ (id) viewWithFrame: (CGRect)frame andDelegate: (id<HATLaunchViewDelegate>)delegate;
- (id) initWithFrame: (CGRect)frame andDelegate: (id<HATLaunchViewDelegate>)delegate;

@end
